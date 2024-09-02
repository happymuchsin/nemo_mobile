// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approval_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ApprovalModelImpl _$$ApprovalModelImplFromJson(Map<String, dynamic> json) =>
    _$ApprovalModelImpl(
      id: json['id'] as String,
      username: json['username'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      idCard: json['idCard'] as String?,
      line: json['line'] as String?,
      lineId: (json['lineId'] as num?)?.toInt(),
      buyer: json['buyer'] as String?,
      style: json['style'] as String?,
      srf: json['srf'] as String?,
      styleId: (json['styleId'] as num?)?.toInt(),
      brand: json['brand'] as String?,
      tipe: json['tipe'] as String?,
      size: json['size'] as String?,
      boxCard: json['boxCard'] as String?,
      needleId: (json['needleId'] as num?)?.toInt(),
      gambar: json['gambar'] as String?,
    );

Map<String, dynamic> _$$ApprovalModelImplToJson(_$ApprovalModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'status': instance.status,
      'idCard': instance.idCard,
      'line': instance.line,
      'lineId': instance.lineId,
      'buyer': instance.buyer,
      'style': instance.style,
      'srf': instance.srf,
      'styleId': instance.styleId,
      'brand': instance.brand,
      'tipe': instance.tipe,
      'size': instance.size,
      'boxCard': instance.boxCard,
      'needleId': instance.needleId,
      'gambar': instance.gambar,
    };
