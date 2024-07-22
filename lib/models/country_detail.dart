import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_detail.g.dart';

@JsonSerializable()
class CountryDetails extends Equatable {
  final String? capital;
  final String? flagImageUri;
  final String? callingCode;
  final int? numRegions;

  const CountryDetails({
    this.capital,
    this.flagImageUri,
    this.callingCode,
    this.numRegions,
  });

  factory CountryDetails.fromJson(Map<String, dynamic> json) => _$CountryDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$CountryDetailsToJson(this);

  @override
  List<Object?> get props => [capital, flagImageUri, callingCode, numRegions];
}
