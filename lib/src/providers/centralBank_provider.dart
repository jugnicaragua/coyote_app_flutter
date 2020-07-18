import 'dart:convert';

import 'package:coyote_app/src/models/centralBank.dart';
import 'package:coyote_app/src/utils/network.dart';
import 'package:http/http.dart' as http;

class CentralBankProvider {
  final String _url = 'http://45.58.34.229:8080';

  Future<CentralBank> exchangeByDate(String date) async {
    final url = '$_url/api/centralBankExchangeRates/$date';
    final hasConnection = await ConnectionHelper.hasConnection();
    if (hasConnection) {
      final response = await http.get(url);
      return CentralBank.fromJson(json.decode(response.body));
    }
    return null;
  }
}
