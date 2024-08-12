// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'needle_stock_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NeedleStockModel _$NeedleStockModelFromJson(Map<String, dynamic> json) {
  return _NeedleStockModel.fromJson(json);
}

/// @nodoc
mixin _$NeedleStockModel {
  String get boxName => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get tipe => throw _privateConstructorUsedError;
  String get size => throw _privateConstructorUsedError;
  int get qty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NeedleStockModelCopyWith<NeedleStockModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NeedleStockModelCopyWith<$Res> {
  factory $NeedleStockModelCopyWith(
          NeedleStockModel value, $Res Function(NeedleStockModel) then) =
      _$NeedleStockModelCopyWithImpl<$Res, NeedleStockModel>;
  @useResult
  $Res call({String boxName, String brand, String tipe, String size, int qty});
}

/// @nodoc
class _$NeedleStockModelCopyWithImpl<$Res, $Val extends NeedleStockModel>
    implements $NeedleStockModelCopyWith<$Res> {
  _$NeedleStockModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boxName = null,
    Object? brand = null,
    Object? tipe = null,
    Object? size = null,
    Object? qty = null,
  }) {
    return _then(_value.copyWith(
      boxName: null == boxName
          ? _value.boxName
          : boxName // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      tipe: null == tipe
          ? _value.tipe
          : tipe // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      qty: null == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NeedleStockModelImplCopyWith<$Res>
    implements $NeedleStockModelCopyWith<$Res> {
  factory _$$NeedleStockModelImplCopyWith(_$NeedleStockModelImpl value,
          $Res Function(_$NeedleStockModelImpl) then) =
      __$$NeedleStockModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String boxName, String brand, String tipe, String size, int qty});
}

/// @nodoc
class __$$NeedleStockModelImplCopyWithImpl<$Res>
    extends _$NeedleStockModelCopyWithImpl<$Res, _$NeedleStockModelImpl>
    implements _$$NeedleStockModelImplCopyWith<$Res> {
  __$$NeedleStockModelImplCopyWithImpl(_$NeedleStockModelImpl _value,
      $Res Function(_$NeedleStockModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? boxName = null,
    Object? brand = null,
    Object? tipe = null,
    Object? size = null,
    Object? qty = null,
  }) {
    return _then(_$NeedleStockModelImpl(
      boxName: null == boxName
          ? _value.boxName
          : boxName // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      tipe: null == tipe
          ? _value.tipe
          : tipe // ignore: cast_nullable_to_non_nullable
              as String,
      size: null == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as String,
      qty: null == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NeedleStockModelImpl implements _NeedleStockModel {
  _$NeedleStockModelImpl(
      {required this.boxName,
      required this.brand,
      required this.tipe,
      required this.size,
      required this.qty});

  factory _$NeedleStockModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NeedleStockModelImplFromJson(json);

  @override
  final String boxName;
  @override
  final String brand;
  @override
  final String tipe;
  @override
  final String size;
  @override
  final int qty;

  @override
  String toString() {
    return 'NeedleStockModel(boxName: $boxName, brand: $brand, tipe: $tipe, size: $size, qty: $qty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NeedleStockModelImpl &&
            (identical(other.boxName, boxName) || other.boxName == boxName) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.tipe, tipe) || other.tipe == tipe) &&
            (identical(other.size, size) || other.size == size) &&
            (identical(other.qty, qty) || other.qty == qty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, boxName, brand, tipe, size, qty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NeedleStockModelImplCopyWith<_$NeedleStockModelImpl> get copyWith =>
      __$$NeedleStockModelImplCopyWithImpl<_$NeedleStockModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NeedleStockModelImplToJson(
      this,
    );
  }
}

abstract class _NeedleStockModel implements NeedleStockModel {
  factory _NeedleStockModel(
      {required final String boxName,
      required final String brand,
      required final String tipe,
      required final String size,
      required final int qty}) = _$NeedleStockModelImpl;

  factory _NeedleStockModel.fromJson(Map<String, dynamic> json) =
      _$NeedleStockModelImpl.fromJson;

  @override
  String get boxName;
  @override
  String get brand;
  @override
  String get tipe;
  @override
  String get size;
  @override
  int get qty;
  @override
  @JsonKey(ignore: true)
  _$$NeedleStockModelImplCopyWith<_$NeedleStockModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
