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
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        EasyLoading.dismiss();
        if (didPop) {
          return;
        }

        Get.back(result: 'refresh');
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
            title: 'Change Needle',
            halaman: 'change-needle',
          ),
          body: Container(
            padding: controller.deviceType.value == 'tablet' ? const EdgeInsets.all(30) : const EdgeInsets.all(0),
            child: Obx(
              () => controller.step.value == '1'
                  ? Column(
                      children: [
                        titlePage(title: 'CHANGE NEEDLE', fontSize: controller.deviceType.value == 'tablet' ? 30 : 18),
                        Expanded(
                          child: SingleChildScrollView(
                            controller: controller.scrollController,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Obx(
                                        () => Container(
                                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                          height: Get.width * .3,
                                          width: Get.width * .3,
                                          child: btnImageInkWell(controller, controller.gambar.value, 'gambar'),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          headerFile('User Information', paddingTop: 0, paddingBottom: 0),
                                          // inputForm(true, 1, controller.tIdCard, 'ID Card'),
                                          inputForm(true, 1, controller.tUsername, 'Username'),
                                          inputForm(true, 1, controller.tName, 'Name'),
                                          inputForm(true, 1, controller.tLine, 'Line'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                headerFile('Change Option', paddingTop: 0, paddingBottom: 0, axis: MainAxisAlignment.center),
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
                                                      controller.sCondition('');
                                                      controller.tCondition.text = '';
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
                                Obx(
                                  () => controller.selectedCheckboxIndex.value != -1
                                      ? controller.tulisan[controller.selectedCheckboxIndex.value] == 'Broken Missing Fragment'
                                          ? Column(
                                              children: [
                                                headerFile('Fragment Condition', paddingTop: 0, paddingBottom: 0, axis: MainAxisAlignment.center),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(Get.width * .2, 0, Get.width * .2, 20),
                                                  child: Row(
                                                    children: [
                                                      exBtn(
                                                          type: 'row',
                                                          onPressed: () => controller.changeCondition('Completed'),
                                                          backgroundColor: Colors.green,
                                                          foregroundColor: Colors.white,
                                                          isIcon: false,
                                                          isText: true,
                                                          text: 'Completed'),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      exBtn(
                                                          type: 'row',
                                                          onPressed: () => controller.changeCondition('Missing Fragment'),
                                                          backgroundColor: Colors.orange,
                                                          foregroundColor: Colors.white,
                                                          isIcon: false,
                                                          isText: true,
                                                          text: 'Missing Fragment'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                headerFile('Needle Condition', paddingTop: 0, paddingBottom: 0, axis: MainAxisAlignment.center),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(Get.width * .2, 0, Get.width * .2, 20),
                                                  child: Row(
                                                    children: [
                                                      exBtn(
                                                          type: 'row',
                                                          onPressed: () => controller.changeCondition('Good'),
                                                          backgroundColor: Colors.green,
                                                          foregroundColor: Colors.white,
                                                          isIcon: false,
                                                          isText: true,
                                                          text: 'Good'),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      exBtn(
                                                          type: 'row',
                                                          onPressed: () => controller.changeCondition('Not Good'),
                                                          backgroundColor: Colors.orange,
                                                          foregroundColor: Colors.white,
                                                          isIcon: false,
                                                          isText: true,
                                                          text: 'Not Good'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                      : Container(),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  : controller.step.value == '2'
                      ? Column(
                          children: [
                            titlePage(
                                title: 'CHANGE NEEDLE - ${controller.tulisan[controller.selectedCheckboxIndex.value].toUpperCase()}',
                                fontSize: controller.deviceType.value == 'tablet' ? 30 : 18),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: controller.scrollController,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        headerFile('User Information', paddingTop: 0, paddingBottom: 0),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: btn(
                                                  type: 'row',
                                                  onPressed: () {},
                                                  backgroundColor: controller.sCondition.value == 'Good' || controller.sCondition.value == 'Completed'
                                                      ? Colors.green
                                                      : Colors.orange,
                                                  isText: true,
                                                  text: controller.sCondition.value),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: btn(
                                                  type: 'row',
                                                  onPressed: () => functionView(
                                                        'zoom',
                                                        from: 'path',
                                                        path: controller.gambar.value!.path,
                                                      ),
                                                  backgroundColor: Colors.blue,
                                                  isIcon: true,
                                                  icon: FontAwesomeIcons.image),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
                                    if (controller.sArea.value == 'SAMPLE ROOM') headerFile('SRF', paddingTop: 0, paddingBottom: 0),
                                    if (controller.sArea.value == 'SAMPLE ROOM')
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
                                    if (controller.sArea.value == 'SAMPLE ROOM') headerFile('Information', paddingTop: 0, paddingBottom: 0),
                                    if (controller.sArea.value == 'SAMPLE ROOM')
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
                                    if (controller.sArea.value != 'SAMPLE ROOM') headerFile('Select', paddingTop: 0, paddingBottom: 0),
                                    if (controller.sArea.value != 'SAMPLE ROOM')
                                      Row(
                                        children: [
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
                                                    controller.spinner('season', e.toString());
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
                                                  decoration: wxInputDecoration(text: 'Season'),
                                                  value: controller.sSeason.value.isNotEmpty ? controller.sSeason.value : null,
                                                  onChanged: (e) {
                                                    controller.sSeason(e.toString());
                                                    controller.spinner('style', e.toString());
                                                  },
                                                  items: controller.lSeason
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
                        )
                      : controller.step.value == '3'
                          ? Column(
                              children: [
                                titlePage(
                                    title: 'CHANGE NEEDLE - ${controller.tulisan[controller.selectedCheckboxIndex.value].toUpperCase()}',
                                    fontSize: controller.deviceType.value == 'tablet' ? 30 : 18),
                                Expanded(
                                  child: SingleChildScrollView(
                                    controller: controller.scrollController,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            headerFile('User Information', paddingTop: 0, paddingBottom: 0),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: btn(
                                                      type: 'row',
                                                      onPressed: () {},
                                                      backgroundColor:
                                                          controller.sCondition.value == 'Good' || controller.sCondition.value == 'Completed'
                                                              ? Colors.green
                                                              : Colors.orange,
                                                      isText: true,
                                                      text: controller.sCondition.value),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: btn(
                                                      type: 'row',
                                                      onPressed: () => functionView(
                                                            'zoom',
                                                            from: 'path',
                                                            path: controller.gambar.value!.path,
                                                          ),
                                                      backgroundColor: Colors.blue,
                                                      isIcon: true,
                                                      icon: FontAwesomeIcons.image),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
                                        if (controller.sArea.value == 'SAMPLE ROOM') headerFile('SRF', paddingTop: 0, paddingBottom: 0),
                                        if (controller.sArea.value == 'SAMPLE ROOM')
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
                                                      style:
                                                          TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
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
                                                      style:
                                                          TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
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
                                        if (controller.sArea.value == 'SAMPLE ROOM') headerFile('Information', paddingTop: 0, paddingBottom: 0),
                                        if (controller.sArea.value == 'SAMPLE ROOM')
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
                                        if (controller.sArea.value != 'SAMPLE ROOM') headerFile('Select', paddingTop: 0, paddingBottom: 0),
                                        if (controller.sArea.value != 'SAMPLE ROOM')
                                          Row(
                                            children: [
                                              Obx(
                                                () => Expanded(
                                                  child: Container(
                                                    padding: const EdgeInsets.all(10),
                                                    child: DropdownButtonFormField2(
                                                      style:
                                                          TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                                                      isExpanded: true,
                                                      decoration: wxInputDecoration(text: 'Buyer'),
                                                      value: controller.sBuyer.value.isNotEmpty ? controller.sBuyer.value : null,
                                                      onChanged: (e) {
                                                        controller.sBuyer(e.toString());
                                                        controller.spinner('season', e.toString());
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
                                                      style:
                                                          TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
                                                      isExpanded: true,
                                                      decoration: wxInputDecoration(text: 'Season'),
                                                      value: controller.sSeason.value.isNotEmpty ? controller.sSeason.value : null,
                                                      onChanged: (e) {
                                                        controller.sSeason(e.toString());
                                                        controller.spinner('style', e.toString());
                                                      },
                                                      items: controller.lSeason
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
                                                      style:
                                                          TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12, color: Colors.black),
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
                                        headerFile('Request Approval To', paddingTop: 0, paddingBottom: 0),
                                        Obx(
                                          () => Container(
                                            padding: const EdgeInsets.all(10),
                                            child: DropdownButtonFormField2(
                                              style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 14, color: Colors.black),
                                              isExpanded: true,
                                              decoration: wxInputDecoration(text: ''),
                                              value: controller.sApproval.value.isNotEmpty ? controller.sApproval.value : null,
                                              onChanged: (e) {
                                                controller.sApproval(e.toString());
                                              },
                                              items: controller.lApproval
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
                            )
                          : Container(),
            ),
          ),
        ),
      ),
    );
  }
}
