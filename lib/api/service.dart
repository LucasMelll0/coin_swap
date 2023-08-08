import 'dart:convert';

import 'package:coin_swap/api/constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<Map<String, String>> getCoins() async {
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.coinsEndpoint);
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return Map<String, String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
