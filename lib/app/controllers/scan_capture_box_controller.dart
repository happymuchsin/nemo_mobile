import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import 'package:nemo/app/ui/global_widgets/notif.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class ScanCaptureBoxController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();

  var person = {}.obs, box = {}.obs, stock = {}.obs;
  var sIdCard = "".obs, sBoxCard = "".obs, deviceType = "".obs, idCard = "".obs, boxCard = "".obs;
  var lIdCard = [].obs, lBoxCard = [].obs;
  var fIdCard = FocusNode(), fBoxCard = FocusNode();

  late CameraController cameraController;
  late List<CameraDescription> cameras;
  var isCameraInitialized = false.obs;

  var captured = false.obs;

  XFile? gambar;

  @override
  void onInit() {
    super.onInit();

    initializedCamera();
  }

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
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
    boxCard('');
    box.clear();
    stock.clear();
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
      scanBoxCard();
    } on CameraException catch (e) {
      notif(e.toString());
      return null;
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
    // data['rfid'] = '0010754220';
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest('$a/card/box', data);
    if (r['success'] == 200) {
      EasyLoading.dismiss();
      xdialog.dismiss();
      box(r['data']['box']);
      stock(r['data']['stock']);
      boxCard(r['data']['box']['rfid']);
    } else {
      EasyLoading.dismiss();
      notif(r['message']);
    }
  }

  Future<void> submit() async {
    if (idCard.value == '') {
      notif('Please scan ID Card');
    } else if (boxCard.value == '') {
      notif('Please scan Box Card');
    } else {
      cameraController.pausePreview();
      Map<String, dynamic> dilempar = {};
      dilempar['idCard'] = idCard.value;
      dilempar['person'] = person;
      dilempar['boxCard'] = boxCard.value;
      dilempar['box'] = box;
      dilempar['stock'] = stock;
      dilempar['gambar'] = gambar;
      final result = await Get.toNamed('/${lemparan[0]['dari']}', arguments: dilempar);

      if (result == 'refresh') {
        reset();
      }
    }
  }

  @override
  void onClose() {
    cameraController.pausePreview();
    cameraController.dispose();
    fIdCard.dispose();
    fBoxCard.dispose();
    super.onClose();
  }
}
