import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/decoration.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class ScanCaptureController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();

  var person = {}.obs;
  var sIdCard = "".obs, deviceType = "".obs, idCard = "".obs, sApproval = "".obs;
  var lIdCard = [].obs, lApproval = [].obs;
  var fIdCard = FocusNode();

  late CameraController cameraController;
  late List<CameraDescription> cameras;
  var isCameraInitialized = false.obs;

  var captured = false.obs;

  XFile? gambar;

  var pembantu = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    initializedCamera();
  }

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
    spinner('approval', '');
  }

  Future<void> initializedCamera() async {
    cameras = await availableCameras();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);

    await cameraController.initialize();
    isCameraInitialized(true);
    scanIdCard();
  }

  Future<void> reset() async {
    idCard('');
    person.clear();
    gambar = null;
    captured(false);
    await scanIdCard();
  }

  Future takePicture() async {
    if (!cameraController.value.isInitialized) {
      return null;
    }
    if (cameraController.value.isTakingPicture) {
      return null;
    }
    try {
      captured(true);
      await cameraController.setFlashMode(FlashMode.off);
      gambar = await cameraController.takePicture();
      cameraController.pausePreview();
    } on CameraException catch (e) {
      notif(e.toString());
      return null;
    }
  }

  Future<void> spinner(tipe, x) async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    var a = await apiReq.baseUrl();
    data['x'] = x;
    data['area_id'] = await localShared.bacaInt('area_id');
    data['username'] = await localShared.baca('username');
    if (tipe == 'approval') {
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
      lApproval();
    }
  }

  Future<void> scanIdCard() async {
    cameraController.pausePreview();
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
      //   cameraController.resumePreview();
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
    // data['rfid'] = '0006593697';
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/person', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      person(r['data']);
      idCard(r['data']['rfid']);
      dialogCustomBody(
        width: Get.width * .5,
        type: DialogType.noHeader,
        widget: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Username',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    ' : ${person['username']}',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Name',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    ' : ${person['name']}',
                    style: const TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
        onDismissCallback: (p0) {
          fIdCard.unfocus();
          cameraController.resumePreview();
        },
        dismissOnTouchOutside: true,
      );
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> submit() async {
    if (idCard.value == '') {
      notif('Please scan ID Card');
    } else {
      cameraController.pausePreview();
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
    }
  }

  Future<void> simpan() async {
    EasyLoading.show();
    List<int> imageBytes = File(gambar!.path).readAsBytesSync();
    Map<String, dynamic> data = {};
    data['needleStatus'] = lemparan[0]['status'];
    data['idCard'] = idCard.value;
    data['approval'] = sApproval.value;
    data['reff'] = await localShared.baca('reff');
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    data['username'] = await localShared.baca('username');
    data['filename'] = gambar!.name.toString();
    data['ext'] = gambar!.path.split('.').last;
    data['gambar'] = base64Encode(imageBytes);
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

  @override
  void onClose() {
    cameraController.pausePreview();
    cameraController.dispose();
    fIdCard.dispose();
    super.onClose();
  }
}
