import 'package:freezed_annotation/freezed_annotation.dart';

part 'needle_stock_model.freezed.dart';
part 'needle_stock_model.g.dart';

@freezed
class NeedleStockModel with _$NeedleStockModel {
  factory NeedleStockModel({
    required String boxName,
    required String brand,
    required String tipe,
    required String size,
    required int qty,
  }) = _NeedleStockModel;

  factory NeedleStockModel.fromJson(Map<String, dynamic> json) => _$NeedleStockModelFromJson(json);
}
