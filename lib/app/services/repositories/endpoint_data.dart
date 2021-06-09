import 'package:covid_tracker/app/services/api.dart';

class EndpointData {
  Map<Endpoint, int> values;
  EndpointData({required this.values});
  int get cases => values[Endpoint.cases]!;
  int get suspected => values[Endpoint.casesSuspected]!;
  int get confirmed => values[Endpoint.casesConfirmed]!;
  int get recovered => values[Endpoint.recovered]!;
  int get death => values[Endpoint.deaths]!;

  @override
  String toString() {
    return "case : $cases ,suspected : $suspected , confirmed : $confirmed , recovered :$recovered, death : $death";
  }
}
