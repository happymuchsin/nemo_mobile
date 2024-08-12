import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import '../../../controllers/scan_capture_controller.dart';

class ScanCapturePage extends GetView<ScanCaptureController> {
  const ScanCapturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        EasyLoading.dismiss();
        if (didPop) {
          return;
        }

        controller.cameraController.dispose();
        Get.back();
      },
      child: Scaffold(
        appBar: ViewAppBar(
          title: controller.lemparan[0]['title'],
          halaman: controller.lemparan[0]['halaman'],
        ),
        body: Obx(
          () {
            if (!controller.isCameraInitialized.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                SizedBox(
                  height: Get.height * .01,
                ),
                SizedBox(
                  height: Get.height * .05,
                  width: Get.width * .75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      btn(
                          type: 'row',
                          onPressed: () => controller.reset(),
                          backgroundColor: Colors.red,
                          isIcon: true,
                          icon: FontAwesomeIcons.rotateLeft,
                          isText: true,
                          text: 'Reset'),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                SizedBox(
                  height: Get.height * .75,
                  width: Get.width * .75,
                  child: CameraPreview(controller.cameraController),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                SizedBox(
                  height: Get.height * .05,
                  child: !controller.captured.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            btn(
                                type: 'row',
                                onPressed: () => controller.takePicture(),
                                isIcon: true,
                                icon: Icons.camera,
                                isText: true,
                                text: 'Capture'),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            btn(
                                type: 'row',
                                onPressed: () => controller.submit(),
                                isIcon: true,
                                icon: FontAwesomeIcons.floppyDisk,
                                isText: true,
                                text: 'Submit'),
                            const SizedBox(
                              width: 50,
                            ),
                            btn(
                                type: 'row',
                                onPressed: () {
                                  controller.captured(false);
                                  controller.cameraController.resumePreview();
                                },
                                backgroundColor: Colors.red,
                                isIcon: true,
                                icon: FontAwesomeIcons.x,
                                isText: true,
                                text: 'Cancel'),
                          ],
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
