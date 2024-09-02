import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import '../../../controllers/missing_fragment_controller.dart';

class MissingFragmentPage extends GetView<MissingFragmentController> {
  const MissingFragmentPage({super.key});

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
          title: 'Missing Fragment',
          halaman: 'missing-fragment',
        ),
        body: Container(
          padding: controller.deviceType.value == 'tablet' ? const EdgeInsets.all(30) : const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              const Text(
                'Searching Needle',
                style: TextStyle(fontSize: 50),
              ),
              SizedBox(
                height: Get.height * .05,
              ),
              Image.asset(
                "assets/img/metalDetector.png",
                height: Get.height * .3,
              ),
              SizedBox(
                height: Get.height * .05,
              ),
              Row(
                children: [
                  exBtn(
                      type: 'row',
                      onPressed: () => controller.scanCapture('complete'),
                      isIcon: true,
                      icon: FontAwesomeIcons.check,
                      isText: true,
                      text: 'COMPLETE'),
                  const SizedBox(
                    width: 30,
                  ),
                  exBtn(
                    type: 'row',
                    onPressed: () => controller.scanCapture('incomplete'),
                    isIcon: true,
                    icon: FontAwesomeIcons.x,
                    isText: true,
                    text: 'INCOMPLETE',
                    backgroundColor: Colors.red,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
