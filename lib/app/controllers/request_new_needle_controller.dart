import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/decoration.dart';
import 'package:nemo/app/ui/global_widgets/fixed_form.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class RequestNewNeedleController extends GetxController {
  final apiReq = Api();
  final localShared = LocalShared();

  var person = {}.obs, box = {}.obs, stock = {}.obs;
  var sIdCard = "".obs,
      sBoxCard = "".obs,
      deviceType = "".obs,
      idCard = "".obs,
      boxCard = "".obs,
      sBuyer = "".obs,
      sStyle = "".obs,
      sApproval = "".obs;
  var lIdCard = [].obs, lBoxCard = [].obs, lBuyer = [].obs, lStyle = [].obs, lApproval = [].obs;
  var fIdCard = FocusNode(), fBoxCard = FocusNode();

  var tIdCard = TextEditingController();
  var tUsername = TextEditingController();
  var tName = TextEditingController();
  var tBoxCard = TextEditingController();
  var tBrand = TextEditingController();
  var tTipe = TextEditingController();
  var tSize = TextEditingController();
  var tRemark = TextEditingController();
  var tLine = TextEditingController();

  var pembantu = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    spinner('buyer', '');
    spinner('approval', '');
    scanIdCard();
  }

  Future<void> spinner(tipe, x) async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    var a = await apiReq.baseUrl();
    data['x'] = x;
    data['area_id'] = await localShared.bacaInt('area_id');
    data['username'] = await localShared.baca('username');
    if (tipe == 'buyer') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lBuyer(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else if (tipe == 'style') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lStyle(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else if (tipe == 'approval') {
      data['tipe'] = tipe;
      var r = await apiReq.makeRequest("$a/spinner", data);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        lApproval(r['data']);
      } else if (r['success'] == 423) {
        EasyLoading.dismiss();
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    } else {
      lBuyer();
      lStyle();
      lApproval();
    }
  }

  Future<void> scanIdCard() async {
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
                    await scanId();

                    sIdCard.value = '';
                    fIdCard.requestFocus();
                  }
                }
              },
              txt: sIdCard.value),
          cardScan('Scan ID Card'),
        ],
      ),
      // onDismissCallback: (p0) {
      //   fIdCard.unfocus();
      // },
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

  Future<void> scanId() async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sIdCard.value.toString();
    if (kDebugMode) {
      data['rfid'] = 'ul2c2';
    }
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/person', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      tLine.text = r['data']['line'];
      tIdCard.text = r['data']['rfid'];
      tUsername.text = r['data']['username'];
      tName.text = r['data']['name'];
      person(r['data']);
      idCard(r['data']['rfid']);
      dialogCustomBody(
        width: Get.width * .8,
        type: DialogType.noHeader,
        widget: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Username : ${person['username']}',
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Name : ${person['name']}',
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        onDismissCallback: (p0) {
          fIdCard.unfocus();
          scanBoxCard();
        },
        dismissOnTouchOutside: true,
      );
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> scanBoxCard() async {
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
                    await scanBox();

                    sBoxCard.value = '';
                    fBoxCard.requestFocus();
                  }
                }
              },
              txt: sBoxCard.value),
          cardScan('Scan Box Card'),
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

  Future<void> scanBox() async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['rfid'] = sBoxCard.value.toString();
    if (kDebugMode) {
      data['rfid'] = '00box1';
    }
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/box', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      tBoxCard.text = r['data']['box']['rfid'];
      tBrand.text = r['data']['stock']['needle']['brand'];
      tTipe.text = r['data']['stock']['needle']['tipe'];
      tSize.text = r['data']['stock']['needle']['size'];
      box(r['data']['box']);
      stock(r['data']['stock']);
      boxCard(r['data']['box']['rfid']);
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> submit() async {
    if (sBuyer.value == '') {
      notif('Please select Buyer');
    } else if (sStyle.value == '') {
      notif('Please select Style');
    } else {
      EasyLoading.show();
      Map<String, dynamic> data = {};
      data['idCard'] = idCard.value;
      data['style'] = sStyle.value;
      data['boxCard'] = boxCard.value;
      data['needle'] = stock['needle']['id'];
      data['username'] = await localShared.baca('username');
      data['status'] = "REQUEST NEW";
      var a = await apiReq.baseUrl();
      var r = await apiReq.makeRequest("$a/needle/save", data, second: 60);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        notif(
          r['message'],
          tipe: 'success',
          onDismissCallback: (p0) {
            Get.back();
          },
        );
      } else {
        EasyLoading.dismiss();
        if (r['data'] == 'approval') {
          notif(
            r['message'],
            onDismissCallback: (p0) {
              dialogCustomBody(
                type: DialogType.noHeader,
                widget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      modalTitle(text: 'Approved By', color: Colors.teal),
                      const SizedBox(
                        height: 10,
                      ),
                      Obx(
                        () => Container(
                          padding: const EdgeInsets.all(10),
                          child: DropdownButtonFormField2(
                            style: TextStyle(fontSize: deviceType.value == 'tablet' ? 20 : 14, color: Colors.black),
                            isExpanded: true,
                            decoration: wxInputDecoration(text: 'Approved By'),
                            value: sApproval.value.isNotEmpty ? sApproval.value : null,
                            onChanged: (e) {
                              sApproval(e.toString());
                            },
                            items: lApproval
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e['id'].toString(),
                                    child: Text(
                                      e['name'].toString(),
                                    ),
                                  ),
                                )
                                .toList(),
                            dropdownSearchData: wxDropdownSearchData(controller: pembantu),
                            onMenuStateChange: (isOpen) {
                              if (!isOpen) {
                                pembantu.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      inputForm(false, 1, tRemark, 'Remark'),
                      Row(
                        children: [
                          exBtn(
                              type: 'row',
                              onPressed: () {
                                xdialog.dismiss();
                              },
                              backgroundColor: Colors.red,
                              isIcon: true,
                              icon: FontAwesomeIcons.x,
                              isText: deviceType.value == 'tablet' ? true : false,
                              text: 'Cancel'),
                          const SizedBox(
                            width: 20,
                          ),
                          exBtn(
                              type: 'row',
                              onPressed: () {
                                simpan();
                              },
                              isIcon: true,
                              icon: FontAwesomeIcons.floppyDisk,
                              isText: deviceType.value == 'tablet' ? true : false,
                              text: 'Save'),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          notif(r['message']);
        }
      }
    }
  }

  Future<void> simpan() async {
    if (sApproval.value == '') {
      notif('Please select Approved By');
    } else if (tRemark.text == '') {
      notif('Please insert Remark');
    } else {
      EasyLoading.show();
      Map<String, dynamic> data = {};
      data['tipe'] = 'request-new';
      data['idCard'] = idCard.value;
      data['style'] = sStyle.value;
      data['boxCard'] = boxCard.value;
      data['approval'] = sApproval.value;
      data['reff'] = await localShared.baca('reff');
      data['area_id'] = await localShared.bacaInt('area_id');
      data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
      data['username'] = await localShared.baca('username');
      data['remark'] = tRemark.text;
      var a = await apiReq.baseUrl();
      var r = await apiReq.makeRequest("$a/needle/approval", data, second: 60);
      if (r['success'] == 200) {
        EasyLoading.dismiss();
        xdialog.dismiss();
        notif(
          r['message'],
          tipe: 'success',
          onDismissCallback: (p0) {
            Get.back(result: 'refresh');
          },
        );
      } else {
        EasyLoading.dismiss();
        notif(r['message']);
      }
    }
  }

  @override
  void onClose() {
    fIdCard.dispose();
    fBoxCard.dispose();
    super.onClose();
  }
}
