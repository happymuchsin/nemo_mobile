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
        appBar: const ViewAppBar(
          title: 'Approval',
          halaman: 'approval',
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(Get.width * .88, 0, 0, 0),
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
                                  width: 75,
                                  height: 75,
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
                                      style: const TextStyle(color: Colors.white, fontSize: 35),
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
                                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data.username.toString(),
                                      style: const TextStyle(fontSize: 20),
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
                                  style: const TextStyle(fontSize: 30),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  height: 75,
                                  child: btn(
                                      type: 'row',
                                      onPressed: () => controller.btnStatus(
                                          data.id,
                                          data.status.toString().toUpperCase(),
                                          data.idCard,
                                          data.username,
                                          data.line,
                                          data.lineId,
                                          data.style,
                                          data.styleId,
                                          data.brand,
                                          data.tipe,
                                          data.size,
                                          data.boxCard,
                                          data.needleId,
                                          data.gambar),
                                      isIcon: true,
                                      icon: FontAwesomeIcons.barcode,
                                      fontSize: 30,
                                      iconSize: 50),
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
