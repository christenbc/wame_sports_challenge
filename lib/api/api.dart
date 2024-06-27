import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wame_sports_challenge_christen/models/models.dart';

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

  /// Retrieves a first batch of countries listed by the API
  static Future<List<Country>> fetchCountries() async {
    const int batchSize = 2;
    const String url = '$_baseUrl/countries?limit=$batchSize';

    final response = await http.get(Uri.parse(url), headers: _headers);

    if (response.statusCode == 200) {
      final dynamic rawData = jsonDecode(response.body);
      final List<dynamic> data = rawData["data"];
      final countries = data.map((countryData) => Country.fromJson(countryData)).toList();
      return countries;
    } else {
      throw Exception('Failed to load countries');
    }
  }

  // TODO: Implement another function to paginate the rest of the countries

  /// Provided a [country], get detailed information about it.
  static Future<CountryDetails> fetchCountryDetails({required Country country}) async {
    final String url = '$_baseUrl/countries/${country.code}';

    final response = await http.get(Uri.parse(url), headers: _headers);

    if (response.statusCode == 200) {
      final dynamic rawData = jsonDecode(response.body);
      final dynamic data = rawData["data"];
      final countryDetails = CountryDetails.fromJson(data);
      return countryDetails;
    } else {
      throw Exception('Failed to load countries');
    }
  }
}
