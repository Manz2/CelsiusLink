import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_model.freezed.dart';

@freezed
class HomeModel with _$HomeModel {
  const factory HomeModel(
      {required String temp,
      required String hum,
      required String bat,
      required int selected,
      required List<Map<DateTime, double>> temperatureToday}) = _HomeModel;
}
