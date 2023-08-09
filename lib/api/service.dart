import 'dart:convert';

import 'package:coin_swap/api/constants.dart';
import 'package:coin_swap/model/currency.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Map<String, String>? coins;

  Future<Map<String, String>> getCoins() async {
    if (coins != null) {
      return coins!;
    }
    var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.coinsEndpoint);
    var response = await http.get(url);
    print('Fez requisição');
    if (response.statusCode == 200) {
      return Map<String, String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<CurrencyValue> getCurrency(String code) async {
    var url = Uri.parse("${ApiConstants.baseUrl}/last/$code");
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return CurrencyValue.fromJson(
          Map<String, dynamic>.from(jsonDecode(response.body)));
    } else {
      throw Exception('Failed to get data');
    }
  }
}
