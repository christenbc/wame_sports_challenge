import 'package:equatable/equatable.dart';

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

  factory CountryDetails.fromJson(Map<String, dynamic> json) => CountryDetails(
        capital: json["capital"],
        flagImageUri: json["flagImageUri"],
        callingCode: json["callingCode"],
        numRegions: json["numRegions"],
      );

  Map<String, dynamic> toJson() => {
        "capital": capital,
        "flagImageUri": flagImageUri,
        "callingCode": callingCode,
        "numRegions": numRegions,
      };

  @override
  List<Object?> get props => [capital, flagImageUri, callingCode, numRegions];
}
