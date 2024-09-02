import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/decoration.dart';
import 'package:nemo/app/ui/global_widgets/fixed_form.dart';
import '../../../controllers/return_needle_controller.dart';

class ReturnNeedlePage extends GetView<ReturnNeedleController> {
  const ReturnNeedlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        EasyLoading.dismiss();
        if (didPop) {
          return;
        }

        Get.back();
      },
      child: Scaffold(
        appBar: ViewAppBar(
          title: 'Return Needle',
          halaman: 'return-needle',
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: inputForm(true, 1, controller.username, 'Username'),
                ),
                Expanded(
                  child: inputForm(true, 1, controller.line, 'Line'),
                ),
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
              ],
            ),
            Row(
              children: [
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButtonFormField2(
                        style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                        isExpanded: true,
                        decoration: wxInputDecoration(text: 'Brand'),
                        value: controller.sBrand.value.isNotEmpty ? controller.sBrand.value : null,
                        onChanged: (e) {
                          controller.sBrand(e.toString());
                          controller.spinner('tipe', e.toString());
                        },
                        items: controller.lBrand
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
                        decoration: wxInputDecoration(text: 'Tipe'),
                        value: controller.sTipe.value.isNotEmpty ? controller.sTipe.value : null,
                        onChanged: (e) {
                          controller.sTipe(e.toString());
                          controller.spinner('size', e.toString());
                        },
                        items: controller.lTipe
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
                        decoration: wxInputDecoration(text: 'Size'),
                        value: controller.sSize.value.isNotEmpty ? controller.sSize.value : null,
                        onChanged: (e) {
                          controller.sSize(e.toString());
                          controller.spinner('code', e.toString());
                        },
                        items: controller.lSize
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
                        decoration: wxInputDecoration(text: 'Code'),
                        value: controller.sCode.value.isNotEmpty ? controller.sCode.value : null,
                        onChanged: (e) {
                          controller.sCode(e.toString());
                        },
                        items: controller.lCode
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
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: inputForm(true, 1, controller.boxCard, 'Box Card'),
                ),
                Expanded(
                  child: inputForm(true, 1, controller.boxName, 'Box'),
                ),
                Expanded(
                  child: inputForm(true, 1, controller.boxStatus, 'Status'),
                ),
              ],
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
