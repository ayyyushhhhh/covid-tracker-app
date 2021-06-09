import 'dart:convert';

import 'package:covid_tracker/app/services/api.dart';
import 'package:covid_tracker/app/services/endpoint_data.dart';
import 'package:http/http.dart' as http;

class APIService {
  APIService({required this.api});
  final API api;
  Future<String> getAccessToken() async {
    final http.Response response = await http.post(api.tokenUri(),
        headers: {"Authorization": "Basic ${api.apiKey}"});
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final accessToken = data["access_token"];
      if (accessToken != null) {
        return accessToken;
      }
    }
    throw response;
  }

  Future<EndpointData> getEndpointData(
      {required Endpoint endpoint, required String accessToken}) async {
    final uri = api.endpointUri(endpoint);
    final response =
        await http.get(uri, headers: {"Authorization": "Bearer $accessToken"});
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint].toString();
        final int? result = endpointData[responseJsonKey];
        final String dateString = endpointData['date'];
        final date = DateTime.tryParse(dateString);
        if (result != null) {
          return EndpointData(value: result, date: date);
        }
      }
    }
    print(response.body);
    throw response;
  }

  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: "cases",
    Endpoint.casesSuspected: "data",
    Endpoint.casesConfirmed: "data",
    Endpoint.deaths: "deaths",
    Endpoint.recovered: "data"
  };
}
