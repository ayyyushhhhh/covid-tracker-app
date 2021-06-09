import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedDateFormatter {
  LastUpdatedDateFormatter({required this.lastUpdated});
  final DateTime? lastUpdated;

  String lastUpdatedStatusText() {
    if (lastUpdated != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(lastUpdated!);
      return 'Last updated: $formatted';
    }
    return "";
  }
}

class LastUpdatedStatustext extends StatelessWidget {
  const LastUpdatedStatustext({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
