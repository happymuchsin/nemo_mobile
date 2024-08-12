import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nemo/app/data/models/needle_stock_model.dart';
import 'package:nemo/app/ui/global_widgets/helper_screen.dart';
import 'package:nemo/app/ui/utils/api.dart';
import 'package:nemo/app/ui/utils/local_data.dart';

class NeedleStockController extends GetxController {
  var lemparan = Get.arguments;
  final apiReq = Api();
  final localShared = LocalShared();
  var deviceType = "".obs;
  var dataList = <NeedleStockModel>[].obs;
  var currentPage = 1.obs, rowPage = 0.obs;

  @override
  void onReady() {
    super.onReady();

    deviceType(getDevice());
  }

  Future<void> getData() async {
    EasyLoading.show();
    Map<String, dynamic> data = {};
    data['username'] = await localShared.baca('username');
    data['area_id'] = await localShared.bacaInt('area_id');
    data['lokasi_id'] = await localShared.bacaInt('lokasi_id');
    var a = await apiReq.baseUrl();
    var r = await apiReq.makeRequest("$a/needle/stock", data, second: 60);
    if (r['success'] == 200) {
      final List<dynamic> res = r['data'];
      if (res.length > 10) {
        rowPage(10);
      } else {
        rowPage(res.length);
      }
      dataList(res.map((data) => NeedleStockModel.fromJson(data)).toList());
    }
    EasyLoading.dismiss();
  }
}

class CreateNeedleStockDataSource extends DataTableSource {
  final List data;
  final NeedleStockController vm;

  CreateNeedleStockDataSource({required this.data, required this.vm});

  @override
  DataRow? getRow(index) {
    final item = data[index];
    return DataRow(
      cells: [
        DataCell(Text(item.boxName)),
        DataCell(Text(item.brand)),
        DataCell(Text(item.tipe)),
        DataCell(Text(item.size)),
        DataCell(Text(item.qty.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
