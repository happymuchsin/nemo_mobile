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
      line: json['line'] as String?,
      requestDate: json['requestDate'] as String?,
      requestTime: json['requestTime'] as String?,
      approvalName: json['approvalName'] as String?,
      approvalUsername: json['approvalUsername'] as String?,
    );

Map<String, dynamic> _$$ApprovalModelImplToJson(_$ApprovalModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'status': instance.status,
      'line': instance.line,
      'requestDate': instance.requestDate,
      'requestTime': instance.requestTime,
      'approvalName': instance.approvalName,
      'approvalUsername': instance.approvalUsername,
    };
