import 'package:covid_tracker/app/services/api.dart';
import 'package:covid_tracker/app/services/api_services.dart';
import 'package:covid_tracker/app/services/repositories/data_repository.dart';
import 'package:covid_tracker/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

void main() async {
  Intl.defaultLocale = "en_GB";
  await initializeDateFormatting();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (BuildContext context) => DataRepository(
        apiService: APIService(
          api: API.sandbox(),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: DashBoard(),
      ),
    );
  }
}
