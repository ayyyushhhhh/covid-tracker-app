import 'package:covid_tracker/app/services/api.dart';
import 'package:covid_tracker/app/services/repositories/data_repository.dart';
import 'package:covid_tracker/app/services/repositories/endpoint_data.dart';
import 'package:covid_tracker/ui/endpoint_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  EndpointData? _endpointsData;

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
            for (var endpoint in Endpoint.values)
              EndPointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData!.values[endpoint]
                    : null,
              )
          ],
        ),
      ),
    );
  }
}
