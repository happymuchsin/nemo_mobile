import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nemo/app/ui/global_widgets/appbar.dart';
import 'package:nemo/app/ui/global_widgets/button.dart';
import '../../../controllers/needle_stock_controller.dart';

class NeedleStockPage extends GetView<NeedleStockController> {
  const NeedleStockPage({super.key});

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
          title: "Needle Stock",
          halaman: 'needle-stock',
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(Get.width * .83, 0, 0, 0),
                  child: btn(type: 'row', onPressed: () => controller.getData(), isIcon: true, icon: FontAwesomeIcons.rotateLeft),
                ),
                FutureBuilder(
                  future: controller.getData(),
                  builder: (c, s) {
                    if (s.connectionState == ConnectionState.waiting) {
                      EasyLoading.show();
                      return Container();
                    } else if (s.hasError) {
                      EasyLoading.dismiss();
                      return Text('Error: ${s.error}');
                    } else {
                      return Obx(
                        () {
                          EasyLoading.dismiss();
                          if (controller.dataList.isEmpty) {
                            return const Center(
                              child: Text(
                                'No data available',
                                style: TextStyle(fontSize: 25),
                              ),
                            );
                          } else {
                            return PaginatedDataTable(
                              columnSpacing: controller.deviceType.value == 'tablet' ? Get.width * .18 : Get.width * .13,
                              columns: const [
                                DataColumn(label: Text('Box Name')),
                                DataColumn(label: Text('Brand')),
                                DataColumn(label: Text('Type')),
                                DataColumn(label: Text('Size')),
                                DataColumn(label: Text('Qty')),
                              ],
                              source: CreateNeedleStockDataSource(data: controller.dataList, vm: controller),
                              rowsPerPage: controller.rowPage.value,
                              showFirstLastButtons: true,
                            );
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
