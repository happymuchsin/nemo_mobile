import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import '../../../controllers/xx_scan_capture_box_controller.dart';

class ScanCaptureBoxPage extends GetView<ScanCaptureBoxController> {
  const ScanCaptureBoxPage({super.key});

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
                if (controller.deviceType.value == 'tablet')
                  SizedBox(
                    height: Get.height * .01,
                  ),
                SizedBox(
                  height: Get.height * .09,
                  width: Get.width * .75,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Username',
                                style: TextStyle(
                                  fontSize: controller.deviceType.value == 'tablet' ? 20 : 12,
                                ),
                              ),
                              Text(
                                ': ${controller.person.values == [] ? '' : controller.person['username']}',
                                style: TextStyle(
                                  fontSize: controller.deviceType.value == 'tablet' ? 20 : 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: controller.deviceType.value == 'tablet' ? 20 : 12,
                                ),
                              ),
                              Text(
                                ': ${controller.person.values == [] ? '' : controller.person['name']}',
                                style: TextStyle(
                                  fontSize: controller.deviceType.value == 'tablet' ? 20 : 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: controller.deviceType.value == 'tablet' ? Get.height * .05 : Get.height * .07,
                        child: btn(
                          type: 'row',
                          onPressed: () => controller.reset(),
                          backgroundColor: Colors.red,
                          isIcon: true,
                          icon: FontAwesomeIcons.rotateLeft,
                          isText: true,
                          text: 'Reset',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                SizedBox(
                  height: controller.deviceType.value == 'tablet' ? Get.height * .7 : Get.height * .65,
                  width: Get.width * .75,
                  child: CameraPreview(controller.cameraController),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                SizedBox(
                  height: controller.deviceType.value == 'tablet' ? Get.height * .05 : Get.height * .07,
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
