import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import '../../../controllers/portal_controller.dart';

class PortalPage extends GetView<PortalController> {
  const PortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: ViewAppBar(
        title: 'Dashboard',
        halaman: 'dashboard',
      ),
      body: Container(
        margin: controller.deviceType.value == 'tablet'
            ? EdgeInsets.fromLTRB(Get.width * .1, Get.height * .1, Get.width * .1, Get.height * .1)
            : EdgeInsets.fromLTRB(Get.width * .05, Get.height * .05, Get.width * .05, Get.height * .05),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Obx(
          () => GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              mainAxisExtent: controller.deviceType.value == 'tablet' ? 225 : 120,
            ),
            itemCount: controller.dataModel.where((e) => e.visible == true).length,
            // itemCount: controller.dataModel.length,
            itemBuilder: (context, index) {
              final d = controller.dataModel.where((e) => e.visible == true).toList()[index];
              return homeIcon(routename: d.route, tipe: d.tipe, source: d.source, name: d.name, visible: d.visible, argument: d.args);
            },
          ),
        ),
      ),
    );
  }
}
