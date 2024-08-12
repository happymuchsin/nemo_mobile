import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
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
        appBar: const ViewAppBar(
          title: 'Return Needle',
          halaman: 'return-needle',
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
                headerFile('Information'),
                Row(
                  children: [
                    Expanded(
                      child: inputForm(true, 1, controller.tLine, 'Line'),
                    ),
                    Expanded(
                      child: inputForm(true, 1, controller.tStyle, 'Style'),
                    ),
                  ],
                ),
                headerFile('Box'),
                Row(
                  children: [
                    Expanded(
                      child: inputForm(true, 1, controller.tBoxCard, 'Box Card'),
                    ),
                    Expanded(
                      child: inputForm(true, 1, controller.tBoxName, 'Box'),
                    ),
                  ],
                ),
                headerFile('Needle'),
                Row(
                  children: [
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
                      onPressed: () => controller.scanBoxCard(),
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
