import 'package:covid_tracker/app/services/api.dart';
import 'package:covid_tracker/app/services/api_services.dart';
import 'package:covid_tracker/app/services/repositories/endpoint_data.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;
  DataRepository({required this.apiService});

  String? _accessToken;

  Future<int> getEndpointData(Endpoint endpoint) async =>
      await _getDataRefreshingToken<int>(
        onGetData: () => apiService.getEndpointData(
            accessToken: _accessToken.toString(), endpoint: endpoint),
      );

  Future<EndpointData> getAllEndpointsData() async =>
      await _getDataRefreshingToken<EndpointData>(
        onGetData: _getAllEndpointsData,
      );

  Future<T> _getDataRefreshingToken<T>(
      {required Future<T> Function() onGetData}) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await onGetData();
    } on Response catch (response) {
      // if unauthorized, get access token again
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await onGetData();
      }
      rethrow;
    }
  }

  Future<EndpointData> _getAllEndpointsData() async {
    final values = await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken.toString(), endpoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken.toString(),
          endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken.toString(),
          endpoint: Endpoint.casesConfirmed),
      // apiService.getEndpointData(
      //     accessToken: _accessToken.toString(), endpoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken.toString(), endpoint: Endpoint.recovered),
    ]);
    return EndpointData(
      values: {
        Endpoint.cases: values[0],
        Endpoint.casesSuspected: values[1],
        Endpoint.casesConfirmed: values[2],
        //  Endpoint.deaths: values[3],
        Endpoint.recovered: values[3],
      },
    );
  }
}
