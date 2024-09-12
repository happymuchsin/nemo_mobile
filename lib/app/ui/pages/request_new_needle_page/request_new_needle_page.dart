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
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        EasyLoading.dismiss();
        if (didPop) {
          return;
        }

        Get.back();
      },
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: ViewAppBar(
            title: 'Request New Needle',
            halaman: 'request-new-needle',
          ),
          body: Container(
            padding: controller.deviceType.value == 'tablet' ? const EdgeInsets.all(30) : const EdgeInsets.all(0),
            child: Obx(
              () => controller.step.value == '1'
                  ? Column(
                      children: [
                        titlePage(title: 'REQUEST NEW NEEDLE', fontSize: controller.deviceType.value == 'tablet' ? 30 : 18),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                headerFile('User Information', paddingTop: 0, paddingBottom: 0),
                                Row(
                                  children: [
                                    // Expanded(
                                    //   child: inputForm(true, 1, controller.tIdCard, 'ID Card'),
                                    // ),
                                    Expanded(
                                      child: inputForm(true, 1, controller.tUsername, 'Username'),
                                    ),
                                    Expanded(
                                      child: inputForm(true, 1, controller.tName, 'Name'),
                                    ),
                                    Expanded(
                                      child: inputForm(true, 1, controller.tLine, 'Line'),
                                    ),
                                  ],
                                ),
                                headerFile('Request Status', paddingTop: 0, paddingBottom: 0),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    children: [
                                      exBtn(
                                          type: 'row',
                                          onPressed: () => controller.changeStatus('New Operator'),
                                          backgroundColor: controller.selectedStatus.value == 'New Operator' ? Colors.green : Colors.grey,
                                          foregroundColor: Colors.white,
                                          isIcon: false,
                                          isText: true,
                                          text: 'New Operator'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      exBtn(
                                          type: 'row',
                                          onPressed: () => controller.changeStatus('New Machine'),
                                          backgroundColor: controller.selectedStatus.value == 'New Machine' ? Colors.green : Colors.grey,
                                          foregroundColor: Colors.white,
                                          isIcon: false,
                                          isText: true,
                                          text: 'New Machine'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      exBtn(
                                          type: 'row',
                                          onPressed: () => controller.changeStatus('Missing'),
                                          backgroundColor: controller.selectedStatus.value == 'Missing' ? Colors.green : Colors.grey,
                                          foregroundColor: Colors.white,
                                          isIcon: false,
                                          isText: true,
                                          text: 'Missing'),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      exBtn(
                                          type: 'row',
                                          onPressed: () => controller.changeStatus('Others'),
                                          backgroundColor: controller.selectedStatus.value == 'Others' ? Colors.green : Colors.grey,
                                          foregroundColor: Colors.white,
                                          isIcon: false,
                                          isText: true,
                                          text: 'Others'),
                                    ],
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible: controller.selectedStatus.value == 'Others',
                                    child: Column(
                                      children: [
                                        headerFile('Remark :', paddingTop: 0, paddingBottom: 0),
                                        inputForm(false, 1, controller.tRemark, ''),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !keyboardIsOpen,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(Get.width * .05, 0, Get.width * .05, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                btn(
                                    type: 'row',
                                    onPressed: () => controller.next(),
                                    backgroundColor: Colors.orange,
                                    isIcon: true,
                                    icon: FontAwesomeIcons.arrowRight,
                                    isText: true,
                                    text: 'Next'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        titlePage(title: 'REQUEST NEW NEEDLE', fontSize: controller.deviceType.value == 'tablet' ? 30 : 18),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                headerFile('User Information', paddingTop: 0, paddingBottom: 0),
                                Row(
                                  children: [
                                    // Expanded(
                                    //   child: inputForm(true, 1, controller.tIdCard, 'ID Card'),
                                    // ),
                                    Expanded(
                                      child: inputForm(true, 1, controller.tUsername, 'Username'),
                                    ),
                                    Expanded(
                                      child: inputForm(true, 1, controller.tName, 'Name'),
                                    ),
                                    Expanded(
                                      child: inputForm(true, 1, controller.tLine, 'Line'),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          headerFile('Request Status', paddingTop: 0, paddingBottom: 0),
                                          inputForm(true, 1, controller.tSelectedStatus, '', isAlign: true, textAlign: TextAlign.center),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          headerFile('Remark', paddingTop: 0, paddingBottom: 0),
                                          inputForm(true, 1, controller.tRemark, ''),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                headerFile('SRF', paddingTop: 0, paddingBottom: 0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: inputForm(false, 1, controller.tDepan, '', inputType: TextInputType.number),
                                    ),
                                    Expanded(
                                      child: Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: DropdownButtonFormField2(
                                            style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                                            isExpanded: true,
                                            decoration: wxInputDecoration(text: ''),
                                            value: controller.sTengah.value.isNotEmpty ? controller.sTengah.value : null,
                                            onChanged: (e) {
                                              controller.sTengah(e.toString());
                                            },
                                            items: controller.bulan
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e.toString(),
                                                    child: Text(
                                                      e.toString(),
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
                                    Expanded(
                                      child: Obx(
                                        () => Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: DropdownButtonFormField2(
                                            style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                                            isExpanded: true,
                                            decoration: wxInputDecoration(text: ''),
                                            value: controller.sBelakang.value.isNotEmpty ? controller.sBelakang.value : null,
                                            onChanged: (e) {
                                              controller.sBelakang(e.toString());
                                            },
                                            items: controller.tahun
                                                .map(
                                                  (e) => DropdownMenuItem(
                                                    value: e.toString(),
                                                    child: Text(
                                                      e.toString(),
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
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          btn(
                                            type: 'row',
                                            onPressed: () => controller.cari(),
                                            backgroundColor: Colors.blue,
                                            isIcon: true,
                                            icon: FontAwesomeIcons.magnifyingGlass,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                headerFile('Information', paddingTop: 0, paddingBottom: 0),
                                Row(
                                  children: [
                                    Expanded(
                                      child: inputForm(true, 1, controller.tBuyer, 'Buyer'),
                                    ),
                                    Expanded(
                                      child: inputForm(true, 1, controller.tSeason, 'Season'),
                                    ),
                                    Expanded(
                                      child: inputForm(true, 1, controller.tStyle, 'Style'),
                                    ),
                                  ],
                                ),
                                headerFile('Needle', paddingTop: 0, paddingBottom: 0),
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
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !keyboardIsOpen,
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(Get.width * .05, 0, Get.width * .05, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                btn(
                                    type: 'row',
                                    onPressed: () => controller.step('1'),
                                    backgroundColor: Colors.orange,
                                    isIcon: true,
                                    icon: FontAwesomeIcons.arrowLeft,
                                    isText: true,
                                    text: 'Back'),
                                btn(
                                    type: 'row',
                                    onPressed: () => controller.submit(),
                                    isIcon: true,
                                    icon: FontAwesomeIcons.floppyDisk,
                                    isText: true,
                                    text: 'Finish'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
