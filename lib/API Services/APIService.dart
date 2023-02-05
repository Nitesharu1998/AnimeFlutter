import 'package:anigami/Utils/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BaseClient {
  var client = http.Client();

  Future<dynamic> get(String endpoint) async {
    try {
      var finalAPIForCall = Uri.parse(Constants.BaseURL + endpoint);
      var _headers = {
        'X-RapidAPI-Key': Constants.AppApiKey,
        'X-RapidAPI-Host': Constants.AppHost
      };
      var responseOfGet = await client.get(finalAPIForCall, headers: _headers);
      if (responseOfGet.statusCode == 200) {
        return responseOfGet.body;
      }
    } catch (e) {
      debugPrint("some exception>>>>> " + e.toString());
    }
  }
}
