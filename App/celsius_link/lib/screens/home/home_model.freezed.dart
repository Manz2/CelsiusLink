// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomeModel {
  String get temp => throw _privateConstructorUsedError;
  String get hum => throw _privateConstructorUsedError;
  String get bat => throw _privateConstructorUsedError;
  int get selected => throw _privateConstructorUsedError;
  List<Map<DateTime, double>> get temperatureToday =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeModelCopyWith<HomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeModelCopyWith<$Res> {
  factory $HomeModelCopyWith(HomeModel value, $Res Function(HomeModel) then) =
      _$HomeModelCopyWithImpl<$Res, HomeModel>;
  @useResult
  $Res call(
      {String temp,
      String hum,
      String bat,
      int selected,
      List<Map<DateTime, double>> temperatureToday});
}

/// @nodoc
class _$HomeModelCopyWithImpl<$Res, $Val extends HomeModel>
    implements $HomeModelCopyWith<$Res> {
  _$HomeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? hum = null,
    Object? bat = null,
    Object? selected = null,
    Object? temperatureToday = null,
  }) {
    return _then(_value.copyWith(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as String,
      hum: null == hum
          ? _value.hum
          : hum // ignore: cast_nullable_to_non_nullable
              as String,
      bat: null == bat
          ? _value.bat
          : bat // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as int,
      temperatureToday: null == temperatureToday
          ? _value.temperatureToday
          : temperatureToday // ignore: cast_nullable_to_non_nullable
              as List<Map<DateTime, double>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_HomeModelCopyWith<$Res> implements $HomeModelCopyWith<$Res> {
  factory _$$_HomeModelCopyWith(
          _$_HomeModel value, $Res Function(_$_HomeModel) then) =
      __$$_HomeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String temp,
      String hum,
      String bat,
      int selected,
      List<Map<DateTime, double>> temperatureToday});
}

/// @nodoc
class __$$_HomeModelCopyWithImpl<$Res>
    extends _$HomeModelCopyWithImpl<$Res, _$_HomeModel>
    implements _$$_HomeModelCopyWith<$Res> {
  __$$_HomeModelCopyWithImpl(
      _$_HomeModel _value, $Res Function(_$_HomeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? temp = null,
    Object? hum = null,
    Object? bat = null,
    Object? selected = null,
    Object? temperatureToday = null,
  }) {
    return _then(_$_HomeModel(
      temp: null == temp
          ? _value.temp
          : temp // ignore: cast_nullable_to_non_nullable
              as String,
      hum: null == hum
          ? _value.hum
          : hum // ignore: cast_nullable_to_non_nullable
              as String,
      bat: null == bat
          ? _value.bat
          : bat // ignore: cast_nullable_to_non_nullable
              as String,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as int,
      temperatureToday: null == temperatureToday
          ? _value._temperatureToday
          : temperatureToday // ignore: cast_nullable_to_non_nullable
              as List<Map<DateTime, double>>,
    ));
  }
}

/// @nodoc

class _$_HomeModel implements _HomeModel {
  const _$_HomeModel(
      {required this.temp,
      required this.hum,
      required this.bat,
      required this.selected,
      required final List<Map<DateTime, double>> temperatureToday})
      : _temperatureToday = temperatureToday;

  @override
  final String temp;
  @override
  final String hum;
  @override
  final String bat;
  @override
  final int selected;
  final List<Map<DateTime, double>> _temperatureToday;
  @override
  List<Map<DateTime, double>> get temperatureToday {
    if (_temperatureToday is EqualUnmodifiableListView)
      return _temperatureToday;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_temperatureToday);
  }

  @override
  String toString() {
    return 'HomeModel(temp: $temp, hum: $hum, bat: $bat, selected: $selected, temperatureToday: $temperatureToday)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomeModel &&
            (identical(other.temp, temp) || other.temp == temp) &&
            (identical(other.hum, hum) || other.hum == hum) &&
            (identical(other.bat, bat) || other.bat == bat) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            const DeepCollectionEquality()
                .equals(other._temperatureToday, _temperatureToday));
  }

  @override
  int get hashCode => Object.hash(runtimeType, temp, hum, bat, selected,
      const DeepCollectionEquality().hash(_temperatureToday));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_HomeModelCopyWith<_$_HomeModel> get copyWith =>
      __$$_HomeModelCopyWithImpl<_$_HomeModel>(this, _$identity);
}

abstract class _HomeModel implements HomeModel {
  const factory _HomeModel(
          {required final String temp,
          required final String hum,
          required final String bat,
          required final int selected,
          required final List<Map<DateTime, double>> temperatureToday}) =
      _$_HomeModel;

  @override
  String get temp;
  @override
  String get hum;
  @override
  String get bat;
  @override
  int get selected;
  @override
  List<Map<DateTime, double>> get temperatureToday;
  @override
  @JsonKey(ignore: true)
  _$$_HomeModelCopyWith<_$_HomeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
