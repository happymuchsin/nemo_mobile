import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import '../../../controllers/approval_controller.dart';

class ApprovalPage extends GetView<ApprovalController> {
  const ApprovalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
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
              // focusScan(
              //     fCard: controller.fIdCard,
              //     kCard: controller.kIdCard,
              //     onFocusChange: (value) async {
              //       if (value) {
              //         controller.sIdCard('');
              //       }

              //       if (!value) {
              //         if (controller.sIdCard.value != '') {
              //           await controller.scanId();

              //           controller.sIdCard.value = '';
              //           controller.fIdCard.requestFocus();
              //         }
              //       }
              //     },
              //     txt: controller.sIdCard.value),
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
                            flex: 3,
                            child: Row(
                              children: [
                                // Container(
                                //   width: controller.deviceType.value == 'tablet' ? 75 : 40,
                                //   height: controller.deviceType.value == 'tablet' ? 75 : 40,
                                //   decoration: const BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     gradient: LinearGradient(
                                //       colors: [Colors.purple, Colors.blue],
                                //       begin: Alignment.topLeft,
                                //       end: Alignment.bottomRight,
                                //     ),
                                //   ),
                                //   child: Center(
                                //     child: Text(
                                //       getInitials(data.name.toString()),
                                //       style: TextStyle(color: Colors.white, fontSize: controller.deviceType.value == 'tablet' ? 35 : 12),
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   width: 20,
                                // ),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.requestDate.toString(),
                                            style:
                                                TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 30 : 18, fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data.requestTime.toString(),
                                            style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12),
                                          ),
                                        ],
                                      ),
                                      const VerticalDivider(
                                        width: 20,
                                        thickness: 2,
                                        color: Colors.black,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: Get.width * .2,
                                            child: Text(
                                              data.name.toString(),
                                              style:
                                                  TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 30 : 18, fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Text(
                                            data.username.toString(),
                                            style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12),
                                          ),
                                        ],
                                      ),
                                      const VerticalDivider(
                                        width: 20,
                                        thickness: 2,
                                        color: Colors.black,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'LINE',
                                            style:
                                                TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 30 : 18, fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: Get.width * .1,
                                            child: Text(
                                              data.line.toString().replaceAll('LINE ', ''),
                                              style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: Get.width * .2,
                                      child: Text(
                                        data.approvalName.toString(),
                                        style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 30 : 18, fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    Text(
                                      data.approvalUsername.toString(),
                                      style: TextStyle(fontSize: controller.deviceType.value == 'tablet' ? 20 : 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  height: controller.deviceType.value == 'tablet' ? 75 : 40,
                                  child: btn(
                                      type: 'row',
                                      onPressed: () => controller.approval(data.status, data.id),
                                      backgroundColor: data.status == 'WAITING' ? Colors.red : Colors.green,
                                      isIcon: true,
                                      icon: FontAwesomeIcons.creditCard,
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
