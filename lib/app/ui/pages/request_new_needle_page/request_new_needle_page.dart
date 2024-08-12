import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/decoration.dart';
import 'package:nemo/app/ui/global_widgets/fixed_form.dart';
import '../../../controllers/request_new_needle_controller.dart';

class RequestNewNeedlePage extends GetView<RequestNewNeedleController> {
  const RequestNewNeedlePage({super.key});

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
        appBar: const ViewAppBar(
          title: 'Request New Needle',
          halaman: 'request-new-needle',
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                headerFile('User'),
                Row(
                  children: [
                    Expanded(
                      child: inputForm(true, 1, controller.tIdCard, 'ID Card'),
                    ),
                    Expanded(
                      child: inputForm(true, 1, controller.tUsername, 'Username'),
                    ),
                    Expanded(
                      child: inputForm(true, 1, controller.tName, 'Name'),
                    ),
                  ],
                ),
                headerFile('Select'),
                Row(
                  children: [
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
                  ],
                ),
                headerFile('Needle'),
                Row(
                  children: [
                    Expanded(
                      child: inputForm(true, 1, controller.tBoxCard, 'Box Card'),
                    ),
                    Expanded(
                      child: inputForm(true, 1, controller.tBrand, 'Brand'),
                    ),
                    Expanded(
                      child: inputForm(true, 1, controller.tTipe, 'Type'),
                    ),
                    Expanded(
                      child: inputForm(true, 1, controller.tSize, 'Size'),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: btn(
                      type: 'row',
                      onPressed: () => controller.submit(),
                      isIcon: true,
                      icon: FontAwesomeIcons.floppyDisk,
                      isText: true,
                      text: 'Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
