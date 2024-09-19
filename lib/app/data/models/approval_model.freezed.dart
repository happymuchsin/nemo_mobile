// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'approval_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ApprovalModel _$ApprovalModelFromJson(Map<String, dynamic> json) {
  return _ApprovalModel.fromJson(json);
}

/// @nodoc
mixin _$ApprovalModel {
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get line => throw _privateConstructorUsedError;
  String? get requestDate => throw _privateConstructorUsedError;
  String? get requestTime => throw _privateConstructorUsedError;
  String? get approvalName => throw _privateConstructorUsedError;
  String? get approvalUsername => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApprovalModelCopyWith<ApprovalModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApprovalModelCopyWith<$Res> {
  factory $ApprovalModelCopyWith(
          ApprovalModel value, $Res Function(ApprovalModel) then) =
      _$ApprovalModelCopyWithImpl<$Res, ApprovalModel>;
  @useResult
  $Res call(
      {String id,
      String? username,
      String? name,
      String? status,
      String? line,
      String? requestDate,
      String? requestTime,
      String? approvalName,
      String? approvalUsername});
}

/// @nodoc
class _$ApprovalModelCopyWithImpl<$Res, $Val extends ApprovalModel>
    implements $ApprovalModelCopyWith<$Res> {
  _$ApprovalModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? line = freezed,
    Object? requestDate = freezed,
    Object? requestTime = freezed,
    Object? approvalName = freezed,
    Object? approvalUsername = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String?,
      requestDate: freezed == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as String?,
      requestTime: freezed == requestTime
          ? _value.requestTime
          : requestTime // ignore: cast_nullable_to_non_nullable
              as String?,
      approvalName: freezed == approvalName
          ? _value.approvalName
          : approvalName // ignore: cast_nullable_to_non_nullable
              as String?,
      approvalUsername: freezed == approvalUsername
          ? _value.approvalUsername
          : approvalUsername // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApprovalModelImplCopyWith<$Res>
    implements $ApprovalModelCopyWith<$Res> {
  factory _$$ApprovalModelImplCopyWith(
          _$ApprovalModelImpl value, $Res Function(_$ApprovalModelImpl) then) =
      __$$ApprovalModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? username,
      String? name,
      String? status,
      String? line,
      String? requestDate,
      String? requestTime,
      String? approvalName,
      String? approvalUsername});
}

/// @nodoc
class __$$ApprovalModelImplCopyWithImpl<$Res>
    extends _$ApprovalModelCopyWithImpl<$Res, _$ApprovalModelImpl>
    implements _$$ApprovalModelImplCopyWith<$Res> {
  __$$ApprovalModelImplCopyWithImpl(
      _$ApprovalModelImpl _value, $Res Function(_$ApprovalModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = freezed,
    Object? name = freezed,
    Object? status = freezed,
    Object? line = freezed,
    Object? requestDate = freezed,
    Object? requestTime = freezed,
    Object? approvalName = freezed,
    Object? approvalUsername = freezed,
  }) {
    return _then(_$ApprovalModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      line: freezed == line
          ? _value.line
          : line // ignore: cast_nullable_to_non_nullable
              as String?,
      requestDate: freezed == requestDate
          ? _value.requestDate
          : requestDate // ignore: cast_nullable_to_non_nullable
              as String?,
      requestTime: freezed == requestTime
          ? _value.requestTime
          : requestTime // ignore: cast_nullable_to_non_nullable
              as String?,
      approvalName: freezed == approvalName
          ? _value.approvalName
          : approvalName // ignore: cast_nullable_to_non_nullable
              as String?,
      approvalUsername: freezed == approvalUsername
          ? _value.approvalUsername
          : approvalUsername // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ApprovalModelImpl implements _ApprovalModel {
  _$ApprovalModelImpl(
      {required this.id,
      this.username,
      this.name,
      this.status,
      this.line,
      this.requestDate,
      this.requestTime,
      this.approvalName,
      this.approvalUsername});

  factory _$ApprovalModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ApprovalModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? username;
  @override
  final String? name;
  @override
  final String? status;
  @override
  final String? line;
  @override
  final String? requestDate;
  @override
  final String? requestTime;
  @override
  final String? approvalName;
  @override
  final String? approvalUsername;

  @override
  String toString() {
    return 'ApprovalModel(id: $id, username: $username, name: $name, status: $status, line: $line, requestDate: $requestDate, requestTime: $requestTime, approvalName: $approvalName, approvalUsername: $approvalUsername)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApprovalModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.line, line) || other.line == line) &&
            (identical(other.requestDate, requestDate) ||
                other.requestDate == requestDate) &&
            (identical(other.requestTime, requestTime) ||
                other.requestTime == requestTime) &&
            (identical(other.approvalName, approvalName) ||
                other.approvalName == approvalName) &&
            (identical(other.approvalUsername, approvalUsername) ||
                other.approvalUsername == approvalUsername));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, username, name, status, line,
      requestDate, requestTime, approvalName, approvalUsername);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApprovalModelImplCopyWith<_$ApprovalModelImpl> get copyWith =>
      __$$ApprovalModelImplCopyWithImpl<_$ApprovalModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ApprovalModelImplToJson(
      this,
    );
  }
}

abstract class _ApprovalModel implements ApprovalModel {
  factory _ApprovalModel(
      {required final String id,
      final String? username,
      final String? name,
      final String? status,
      final String? line,
      final String? requestDate,
      final String? requestTime,
      final String? approvalName,
      final String? approvalUsername}) = _$ApprovalModelImpl;

  factory _ApprovalModel.fromJson(Map<String, dynamic> json) =
      _$ApprovalModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get username;
  @override
  String? get name;
  @override
  String? get status;
  @override
  String? get line;
  @override
  String? get requestDate;
  @override
  String? get requestTime;
  @override
  String? get approvalName;
  @override
  String? get approvalUsername;
  @override
  @JsonKey(ignore: true)
  _$$ApprovalModelImplCopyWith<_$ApprovalModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
