import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/fixed_form.dart';
import '../../../controllers/xx_replacement_needle_controller.dart';

class ReplacementNeedlePage extends GetView<ReplacementNeedleController> {
  const ReplacementNeedlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        EasyLoading.dismiss();
        if (didPop) {
          return;
        }

        Get.back(result: 'refresh');
      },
      child: Scaffold(
        appBar: ViewAppBar(
          title: controller.lemparan[0]['title'],
          halaman: controller.lemparan[0]['halaman'],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(child: inputForm(true, 1, controller.username, 'Username')),
                Expanded(child: inputForm(true, 1, controller.line, 'Line')),
                Expanded(child: inputForm(true, 1, controller.buyer, 'Buyer')),
                Expanded(child: inputForm(true, 1, controller.style, 'Style')),
                Expanded(child: inputForm(true, 1, controller.srf, 'SRF')),
                Expanded(child: inputForm(true, 1, controller.brand, 'Brand')),
                Expanded(child: inputForm(true, 1, controller.tipe, 'Type')),
                Expanded(child: inputForm(true, 1, controller.size, 'Size')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                controller.images.length,
                (index) {
                  return Obx(
                    () => GestureDetector(
                      onTap: () {
                        controller.selectCheckbox(index);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.memory(
                            base64Decode(controller.lemparan[0]['gambar']),
                            fit: BoxFit.contain,
                            width: controller.deviceType.value == 'tablet' ? 400 : 150,
                            height: controller.deviceType.value == 'tablet' ? 400 : 150,
                          ),
                          SizedBox(
                            width: controller.deviceType.value == 'tablet' ? 400 : 100,
                            child: Text(
                              controller.tulisan[index],
                              style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 30 : 12),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Transform.scale(
                            scale: controller.deviceType.value == 'tablet' ? 2 : 1,
                            child: Checkbox(
                              shape: const CircleBorder(),
                              value: controller.selectedCheckboxIndex.value == index,
                              onChanged: (value) {
                                controller.selectCheckbox(index);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              height: controller.deviceType.value == 'tablet' ? Get.height * .05 : Get.height * .07,
              child: btn(
                  type: 'row', onPressed: () => controller.submit(), isIcon: true, icon: FontAwesomeIcons.floppyDisk, isText: true, text: 'SUBMIT'),
            ),
          ],
        ),
      ),
    );
  }
}
