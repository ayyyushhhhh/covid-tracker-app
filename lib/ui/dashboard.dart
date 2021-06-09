import 'package:covid_tracker/app/services/api.dart';
import 'package:covid_tracker/app/services/repositories/data_repository.dart';
import 'package:covid_tracker/app/services/repositories/endpoints_data.dart';
import 'package:covid_tracker/ui/endpoint_card.dart';
import 'package:covid_tracker/ui/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndpointsData? _endpointsData;

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointsdata = await dataRepository.getAllEndpointsData();
    setState(() {
      _endpointsData = endpointsdata;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointsData != null
            ? _endpointsData!.values[Endpoint.cases]!.date!
            : null);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Covid Tracker",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdatedStatustext(
              text: formatter.lastUpdatedStatusText(),
            ),
            if (_endpointsData != null)
              for (var endpoint in Endpoint.values)
                EndPointCard(
                  endpoint: endpoint,
                  value: _endpointsData!.values[endpoint]?.value,
                )
          ],
        ),
      ),
    );
  }
}
