import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nemo/app/data/models/approval_model.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/decoration.dart';
import 'package:nemo/app/ui/global_widgets/fixed_form.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/global_context.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class ApprovalController extends GetxController {
  final apiReq = Api();
  final localShared = LocalShared();
  final dataList = <ApprovalModel>[].obs;
  var deviceType = "".obs,
      sIdCard = "".obs,
      sBoxCard = "".obs,
      idCard = "".obs,
      boxCard = "".obs,
      sApproval = "".obs,
      timeScanRfid = "".obs,
      timeScanBox = "".obs;
  var fIdCard = FocusNode(), fBoxCard = FocusNode();
  var lIdCard = [].obs, lBoxCard = [].obs;
  late AwesomeDialog hDialog;

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    awalan();
  }

  void awalan() async {
    getData();
  }

  Future<void> getData() async {
    dataList.clear();
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['username'] = await localShared.baca('username');
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest("$a/approval/data", data, second: 60);
    if (r['success'] == 200) {
      final List<dynamic> res = r['data'];
      dataList(res.map((data) => ApprovalModel.fromJson(data)).toList());
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> approval(status, id) async {
    sApproval(id);
    if (status == 'WAITING') {
      scanIdCard('approval');
    } else if (status == 'APPROVE') {
      scanIdCard('operator');
    } else {
      notif('NEED APPROVAL');
    }
  }

  Future<void> scanIdCard(tipe) async {
    Future.delayed(const Duration(milliseconds: 50), () {
      fIdCard.requestFocus();
    });
    dialogCustomBody(
      type: DialogType.noHeader,
      widget: Column(
        children: [
          focusScan(
              fCard: fIdCard,
              kCard: kIdCard,
              onFocusChange: (value) async {
                if (value) {
                  sIdCard('');
                }

                if (!value) {
                  if (sIdCard.value != '') {
                    await scanId(tipe);

                    sIdCard.value = '';
                    fIdCard.requestFocus();
                  }
                }
              },
              txt: sIdCard.value),
          cardScan(tipe == 'approval' ? 'Scan ID Card Approval' : 'Scan ID Card Requestor'),
        ],
      ),
      onDismissCallback: (p0) {
        fIdCard.unfocus();
      },
      dismissOnTouchOutside: true,
    );
  }

  KeyEventResult kIdCard(FocusNode node, KeyEvent event) {
    if (event.runtimeType == KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        sIdCard(lIdCard.join().toString());
        lIdCard.clear();
        fIdCard.unfocus();
      } else {
        lIdCard.add(event.character.toString());
      }
    }

    return event.logicalKey == LogicalKeyboardKey.enter ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  Future<void> scanId(tipe) async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sIdCard.value.toString();
    if (kDebugMode) {
      if (tipe == 'approval') {
        data['rfid'] = 'dev';
      } else {
        data['rfid'] = 'us1c1';
      }
    }
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    data['tipe'] = tipe;
    data['approval'] = sApproval.value;
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/person', data);
    if (r['success'] == 200) {
      timeScanRfid(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
      EasyLoading.dismiss();
      xdialog.dismiss();
      fIdCard.unfocus();
      historyNeedle(r['data']['history']);
    } else {
      timeScanRfid('');
      timeScanBox('');
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> historyNeedle(list) async {
    hDialog = AwesomeDialog(
      context: GlobalService.navigatorKey.currentState!.overlay!.context,
      animType: AnimType.scale,
      dialogType: DialogType.noHeader,
      keyboardAware: true,
      showCloseIcon: true,
      closeIcon: const Icon(FontAwesomeIcons.x),
      dismissOnTouchOutside: false,
      body: Column(
        children: [
          modalTitle(text: 'History Needle'),
          Row(
            children: [
              Expanded(flex: 2, child: Text('Brand', style: TextStyle(fontSize: deviceType.value == 'tablet' ? 30 : 18))),
              Expanded(flex: 3, child: Text('Type', style: TextStyle(fontSize: deviceType.value == 'tablet' ? 30 : 18))),
              Expanded(flex: 1, child: Text('Size', style: TextStyle(fontSize: deviceType.value == 'tablet' ? 30 : 18))),
              Expanded(flex: 4, child: Text('Code', style: TextStyle(fontSize: deviceType.value == 'tablet' ? 30 : 18))),
              Expanded(flex: 3, child: Text('Date Time', style: TextStyle(fontSize: deviceType.value == 'tablet' ? 30 : 18))),
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              final data = list[index];
              return Row(
                children: [
                  Expanded(flex: 2, child: Text(data['brand'].toString(), style: TextStyle(fontSize: deviceType.value == 'tablet' ? 25 : 14))),
                  Expanded(flex: 3, child: Text(data['tipe'].toString(), style: TextStyle(fontSize: deviceType.value == 'tablet' ? 25 : 14))),
                  Expanded(flex: 1, child: Text(data['size'].toString(), style: TextStyle(fontSize: deviceType.value == 'tablet' ? 25 : 14))),
                  Expanded(flex: 4, child: Text(data['code'].toString(), style: TextStyle(fontSize: deviceType.value == 'tablet' ? 25 : 14))),
                  Expanded(flex: 3, child: Text(data['created_at'].toString(), style: TextStyle(fontSize: deviceType.value == 'tablet' ? 25 : 14))),
                ],
              );
            },
          ),
          headerFile('Change Needle', paddingTop: 0, paddingBottom: 0),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Row(
              children: [
                exBtn(
                    type: 'row',
                    onPressed: () => scanBoxCard('ubah'),
                    backgroundColor: Colors.green,
                    isIcon: true,
                    icon: FontAwesomeIcons.check,
                    isText: deviceType.value == 'tablet' ? true : false,
                    text: deviceType.value == 'tablet' ? 'Yes' : ''),
                const SizedBox(
                  width: 20,
                ),
                exBtn(
                    type: 'row',
                    onPressed: () => scanBoxCard('tetap'),
                    backgroundColor: Colors.red,
                    isIcon: true,
                    icon: FontAwesomeIcons.x,
                    isText: deviceType.value == 'tablet' ? true : false,
                    text: deviceType.value == 'tablet' ? 'No' : ''),
              ],
            ),
          ),
        ],
      ),
    )..show();
  }

  Future<void> scanBoxCard(mode) async {
    Future.delayed(const Duration(milliseconds: 50), () {
      fBoxCard.requestFocus();
    });
    dialogCustomBody(
      type: DialogType.noHeader,
      widget: Column(
        children: [
          focusScan(
              fCard: fBoxCard,
              kCard: kBoxCard,
              onFocusChange: (value) async {
                if (value) {
                  sBoxCard('');
                }

                if (!value) {
                  if (sBoxCard.value != '') {
                    await scanBox(mode);

                    sBoxCard.value = '';
                    fBoxCard.requestFocus();
                  }
                }
              },
              txt: sBoxCard.value),
          cardScan(mode == 'ubah' ? 'Scan Change Needle Box Card' : 'Scan Box Card'),
        ],
      ),
      onDismissCallback: (p0) {
        fBoxCard.unfocus();
      },
      dismissOnTouchOutside: true,
    );
  }

  KeyEventResult kBoxCard(FocusNode node, KeyEvent event) {
    if (event.runtimeType == KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        sBoxCard(lBoxCard.join().toString());
        lBoxCard.clear();
        fBoxCard.unfocus();
      } else {
        lBoxCard.add(event.character.toString());
      }
    }

    return event.logicalKey == LogicalKeyboardKey.enter ? KeyEventResult.handled : KeyEventResult.ignored;
  }

  Future<void> scanBox(mode) async {
    timeScanBox(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sBoxCard.value.toString();
    if (kDebugMode) {
      data['rfid'] = '00box2n';
    }
    data['tipe'] = 'approval';
    data['approval'] = sApproval.value;
    data['username'] = await localShared.baca('username');
    data['scan_rfid'] = timeScanRfid.value;
    data['scan_box'] = timeScanBox.value;
    data['mode'] = mode;
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/box', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      hDialog.dismiss();
      notif(
        r['message'],
        tipe: 'success',
        onDismissCallback: (p0) {
          getData();
        },
      );
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
      timeScanBox('');
    }
  }

  @override
  void onClose() {
    fIdCard.dispose();
    super.onClose();
  }
}
