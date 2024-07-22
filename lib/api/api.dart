import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wame_sports_challenge_christen/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

class RapidAPI {
  static const String _baseUrl = 'https://wft-geo-db.p.rapidapi.com/v1/geo';

  // The following API key is purposedly exposed to the version control and deployment.
  // Making it secure, is out of the scope of this challenge.
  // This could be addressed by deploying this functions serverless so that
  // these are never called directly from the client.
  static const _headers = {
    'x-rapidapi-key': 'f6a9ec3139mshe7e75f2dcf2ebccp13a33ejsn1fc80008bf69',
    'x-rapidapi-host': 'wft-geo-db.p.rapidapi.com'
  };

  static late Dio _dio;

  static Future<void> init() async {
    late HiveCacheStore cacheStore;
    if (kIsWeb) {
      await Hive.initFlutter(); // Initializes Hive for Flutter Web
      cacheStore = HiveCacheStore(null);
    } else {
      final appDocDir = await getApplicationDocumentsDirectory();
      cacheStore = HiveCacheStore(appDocDir.path);
    }

    final options = CacheOptions(
      store: cacheStore,
      policy: CachePolicy.request,
      hitCacheOnErrorExcept: [401, 403],
      maxStale: const Duration(days: 7),
    );

    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      headers: _headers,
    ))
      ..interceptors.add(DioCacheInterceptor(options: options));
  }

  /// Retrieves a batch of countries listed by the API
  static Future<List<Country>> fetchCountries({required int offset, required int pageSize}) async {
    String url = '$_baseUrl/countries?limit=$pageSize';

    if (offset != 0) {
      url += '&offset=$offset';
    }

    final response = await _dio.get(url);

    final dynamic rawData = response.data;
    if (response.statusCode == 200) {
      final List<dynamic> data = rawData["data"];
      final countries = data.map((countryData) => Country.fromJson(countryData)).toList();
      return countries;
    } else {
      final dynamic message = rawData["message"];
      throw Exception(message);
    }
  }

  /// Provided a [country], get detailed information about it.
  static Future<CountryDetails> fetchCountryDetails({required Country country}) async {
    final String url = '$_baseUrl/countries/${country.code}';

    final response = await _dio.get(url);

    final dynamic rawData = response.data;
    if (response.statusCode == 200) {
      final dynamic data = rawData["data"];
      final countryDetails = CountryDetails.fromJson(data);
      return countryDetails;
    } else {
      final dynamic message = rawData["message"];
      throw Exception(message);
    }
  }
}
