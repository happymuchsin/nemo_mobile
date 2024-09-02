import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/global_widgets/needle.dart';
import '../../../controllers/approval_controller.dart';

class ApprovalPage extends GetView<ApprovalController> {
  const ApprovalPage({super.key});

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
          title: 'Approval',
          halaman: 'approval',
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(Get.width * .83, 0, 0, 0),
                child: btn(type: 'row', onPressed: () => controller.getData(), isIcon: true, icon: FontAwesomeIcons.rotateLeft),
              ),
              focusScan(
                  fCard: controller.fIdCard,
                  kCard: controller.kIdCard,
                  onFocusChange: (value) async {
                    if (value) {
                      controller.sIdCard('');
                    }

                    if (!value) {
                      if (controller.sIdCard.value != '') {
                        await controller.scanId();

                        controller.sIdCard.value = '';
                        controller.fIdCard.requestFocus();
                      }
                    }
                  },
                  txt: controller.sIdCard.value),
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.dataList.length,
                    itemBuilder: (context, index) {
                      final data = controller.dataList[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Container(
                                  width: controller.deviceType.value == 'tablet' ? 75 : 40,
                                  height: controller.deviceType.value == 'tablet' ? 75 : 40,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [Colors.purple, Colors.blue],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      getInitials(data.name.toString()),
                                      style: TextStyle(color: Colors.white, fontSize: controller.deviceType.value == 'tablet' ? 35 : 12),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.name.toString(),
                                      style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 30 : 18, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data.username.toString(),
                                      style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  data.status.toString().toUpperCase(),
                                  style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 30 : 20),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  height: controller.deviceType.value == 'tablet' ? 75 : 40,
                                  child: btn(
                                      type: 'row',
                                      onPressed: () => controller.btnStatus(
                                          data.id,
                                          data.status.toString().toUpperCase(),
                                          data.idCard,
                                          data.username,
                                          data.line,
                                          data.lineId,
                                          data.buyer,
                                          data.style,
                                          data.srf,
                                          data.styleId,
                                          data.brand,
                                          data.tipe,
                                          data.size,
                                          data.boxCard,
                                          data.needleId,
                                          data.gambar),
                                      isIcon: true,
                                      icon: FontAwesomeIcons.barcode,
                                      fontSize: controller.deviceType.value == 'tablet' ? 30 : 12,
                                      iconSize: controller.deviceType.value == 'tablet' ? 50 : 28),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
