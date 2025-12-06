
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hommie/models/apartment_model.dart';

class ApartmentsService {
  static const String baseUrl = "http://10.0.2.2:8000/api";
  static const String imageBaseUrl = "http://10.0.2.2:8000/storage/";

  static Future<List<ApartmentModel>> fetchApartments({String query = ''}) async {
    final uri = Uri.parse("$baseUrl/apartments").replace(
      queryParameters: query.isNotEmpty ? {'query': query} : null,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

      if (jsonResponse.containsKey('data')) {
        final dynamic data = jsonResponse['data'];
        if (data is List) {
  return data.map((json) => ApartmentModel.fromJson(Map<String, dynamic>.from(json))).toList();
} else if (data is Map) {
  return [ApartmentModel.fromJson(Map<String, dynamic>.from(data))];
        }
      }

      return [];
    } else {
      throw Exception("Failed to load apartments");
    }
  }
}
