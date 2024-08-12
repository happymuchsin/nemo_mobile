import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/decoration.dart';
import 'package:nemo/app/ui/global_widgets/fixed_form.dart';
import '../../../controllers/change_needle_controller.dart';

class ChangeNeedlePage extends GetView<ChangeNeedleController> {
  const ChangeNeedlePage({super.key});

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
        appBar: const ViewAppBar(
          title: 'Change Needle',
          halaman: 'change-needle',
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(child: inputForm(true, 1, controller.username, 'Username')),
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField2(
                        style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 14, color: Colors.black),
                        isExpanded: true,
                        decoration: wxInputDecoration(text: 'Line'),
                        value: controller.sLine.value.isNotEmpty ? controller.sLine.value : null,
                        onChanged: (e) {
                          controller.sLine(e.toString());
                        },
                        items: controller.lLine
                            .map(
                              (e) => DropdownMenuItem(
                                value: e['id'].toString(),
                                child: Text(
                                  e['name'].toString(),
                                ),
                              ),
                            )
                            .toList(),
                        dropdownSearchData: wxDropdownSearchData(controller: controller.pembantu),
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            controller.pembantu.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField2(
                        style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 14, color: Colors.black),
                        isExpanded: true,
                        decoration: wxInputDecoration(text: 'Style'),
                        value: controller.sStyle.value.isNotEmpty ? controller.sStyle.value : null,
                        onChanged: (e) {
                          controller.sStyle(e.toString());
                        },
                        items: controller.lStyle
                            .map(
                              (e) => DropdownMenuItem(
                                value: e['id'].toString(),
                                child: Text(
                                  e['name'].toString(),
                                ),
                              ),
                            )
                            .toList(),
                        dropdownSearchData: wxDropdownSearchData(controller: controller.pembantu),
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            controller.pembantu.clear();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(child: inputForm(true, 1, controller.brand, 'Brand')),
                Expanded(child: inputForm(true, 1, controller.tipe, 'Type')),
                Expanded(child: inputForm(true, 1, controller.size, 'Size')),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            Image.asset(
                              controller.images[index],
                              width: controller.deviceType.value == 'tablet' ? 250 : 100,
                              height: controller.deviceType.value == 'tablet' ? 250 : 100,
                            ),
                            SizedBox(
                              width: controller.deviceType.value == 'tablet' ? 250 : 100,
                              child: Text(
                                controller.tulisan[index],
                                style: const TextStyle(fontSize: 30),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Transform.scale(
                              scale: 2,
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
            ),
            btn(type: 'row', onPressed: () => controller.submit(), isIcon: true, icon: FontAwesomeIcons.floppyDisk, isText: true, text: 'SUBMIT'),
          ],
        ),
      ),
    );
  }
}
