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
        appBar: ViewAppBar(
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
                Expanded(child: inputForm(true, 1, controller.line, 'Line')),
                // Obx(
                //   () => Expanded(
                //     child: Container(
                //       padding: const EdgeInsets.all(10),
                //       child: DropdownButtonFormField2(
                //         style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                //         isExpanded: true,
                //         decoration: wxInputDecoration(text: 'Line'),
                //         value: controller.sLine.value.isNotEmpty ? controller.sLine.value : null,
                //         onChanged: (e) {
                //           controller.sLine(e.toString());
                //         },
                //         items: controller.lLine
                //             .map(
                //               (e) => DropdownMenuItem(
                //                 value: e['id'].toString(),
                //                 child: Text(
                //                   e['name'].toString(),
                //                 ),
                //               ),
                //             )
                //             .toList(),
                //         dropdownSearchData: wxDropdownSearchData(controller: controller.pembantu),
                //         onMenuStateChange: (isOpen) {
                //           if (!isOpen) {
                //             controller.pembantu.clear();
                //           }
                //         },
                //       ),
                //     ),
                //   ),
                // ),
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField2(
                        style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                        isExpanded: true,
                        decoration: wxInputDecoration(text: 'Buyer'),
                        value: controller.sBuyer.value.isNotEmpty ? controller.sBuyer.value : null,
                        onChanged: (e) {
                          controller.sBuyer(e.toString());
                          controller.spinner('style', e.toString());
                        },
                        items: controller.lBuyer
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
                        style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                        isExpanded: true,
                        decoration: wxInputDecoration(text: 'Style'),
                        value: controller.sStyle.value.isNotEmpty ? controller.sStyle.value : null,
                        onChanged: (e) {
                          controller.sStyle(e.toString());
                          controller.spinner('srf', e.toString());
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
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField2(
                        style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                        isExpanded: true,
                        decoration: wxInputDecoration(text: 'SRF'),
                        value: controller.sSrf.value.isNotEmpty ? controller.sSrf.value : null,
                        onChanged: (e) {
                          controller.sSrf(e.toString());
                        },
                        items: controller.lSrf
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
              padding: controller.deviceType.value == 'tablet' ? const EdgeInsets.all(30) : const EdgeInsets.all(20),
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
                              width: controller.deviceType.value == 'tablet' ? 250 : 75,
                              height: controller.deviceType.value == 'tablet' ? 250 : 75,
                            ),
                            SizedBox(
                              width: controller.deviceType.value == 'tablet' ? 250 : 100,
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
