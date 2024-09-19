import 'package:freezed_annotation/freezed_annotation.dart';

part 'approval_model.freezed.dart';
part 'approval_model.g.dart';

@freezed
class ApprovalModel with _$ApprovalModel {
  factory ApprovalModel({
    required String id,
    String? username,
    String? name,
    String? status,
    String? line,
    String? requestDate,
    String? requestTime,
    String? approvalName,
    String? approvalUsername,
  }) = _ApprovalModel;

  factory ApprovalModel.fromJson(Map<String, dynamic> json) => _$ApprovalModelFromJson(json);
}
