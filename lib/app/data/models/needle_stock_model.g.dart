// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'needle_stock_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NeedleStockModelImpl _$$NeedleStockModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NeedleStockModelImpl(
      boxName: json['boxName'] as String,
      brand: json['brand'] as String,
      tipe: json['tipe'] as String,
      size: json['size'] as String,
      qty: (json['qty'] as num).toInt(),
    );

Map<String, dynamic> _$$NeedleStockModelImplToJson(
        _$NeedleStockModelImpl instance) =>
    <String, dynamic>{
      'boxName': instance.boxName,
      'brand': instance.brand,
      'tipe': instance.tipe,
      'size': instance.size,
      'qty': instance.qty,
    };
