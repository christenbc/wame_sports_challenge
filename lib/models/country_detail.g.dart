// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDetails _$CountryDetailsFromJson(Map<String, dynamic> json) =>
    CountryDetails(
      capital: json['capital'] as String?,
      flagImageUri: json['flagImageUri'] as String?,
      callingCode: json['callingCode'] as String?,
      numRegions: (json['numRegions'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CountryDetailsToJson(CountryDetails instance) =>
    <String, dynamic>{
      'capital': instance.capital,
      'flagImageUri': instance.flagImageUri,
      'callingCode': instance.callingCode,
      'numRegions': instance.numRegions,
    };
