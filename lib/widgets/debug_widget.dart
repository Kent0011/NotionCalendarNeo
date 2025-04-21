import 'package:flutter/material.dart';
import '../api/api.dart';
import '../models/event.dart';


class DebugWidget extends StatefulWidget {
  @override
  _DebugWidgetState createState() => _DebugWidgetState();
}

class _DebugWidgetState extends State<DebugWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Event>>(
        future: Api.fetchEventList(DateTime.now()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('エラー: ${snapshot.error}');
          }
          return Column(
            children: [
              for (var event in snapshot.data ?? [])
                Text(event.title),
            ],
          );
        },
      ),
    );
  }
}
