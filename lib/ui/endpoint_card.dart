import 'package:covid_tracker/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCardData {
  EndpointCardData(this.title, this.assetName, this.color);
  final String title;
  final String assetName;
  final Color color;
}

class EndPointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int? value;
  EndPointCard({required this.endpoint, required this.value});

  static Map<Endpoint, EndpointCardData> _cardsData = {
    Endpoint.cases:
        EndpointCardData('Cases', 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.casesSuspected: EndpointCardData(
        'Suspected cases', 'assets/suspect.png', Color(0xFFEEDA28)),
    Endpoint.casesConfirmed: EndpointCardData(
        'Confirmed cases', 'assets/fever.png', Color(0xFFE99600)),
    Endpoint.deaths:
        EndpointCardData('Deaths', 'assets/death.png', Color(0xFFE40000)),
    Endpoint.recovered:
        EndpointCardData('Recovered', 'assets/patient.png', Color(0xFF70A901)),
  };
  @override
  Widget build(BuildContext context) {
    final cardData = _cardsData[endpoint];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardData!.title,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: cardData.color),
            ),
            SizedBox(height: 4),
            SizedBox(
              height: 52,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(cardData.assetName, color: cardData.color),
                  Text(
                    value != null ? value.toString() : '',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: cardData.color, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
