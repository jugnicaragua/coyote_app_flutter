import 'dart:convert';

import 'package:coyote_app/src/models/banks.dart';
import 'package:http/http.dart' as http;

class BankProvider {
  final String _url = 'http://45.58.34.229:8080';

  Future<Root> loadBanks(String date) async {
    final url = '$_url/api/commercialBankExchangeRates/date/$date';
    final response = await http.get(url);
    return Root.fromJson(json.decode(response.body));
  }
}
