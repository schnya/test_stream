import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:test_stream/domain/utils.dart' show app;

class CounterStreamBuilder extends StatefulWidget {
  final String? token;
  final String title;
  final Widget Function(int counter) builder;

  const CounterStreamBuilder({
    Key? key,
    this.token,
    required this.builder,
    this.title = '',
  }) : super(key: key);

  @override
  _CounterStreamBuilderState createState() => _CounterStreamBuilderState();
}

class _CounterStreamBuilderState extends State<CounterStreamBuilder> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // stream: app.stream(widget.token),
      builder: ((
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        // ignore: avoid_print
        print('🔥Connect firestore');
        int _counter = snapshot.data?.get('counter') as int? ?? 0;

        return snapshot.connectionState == ConnectionState.waiting
            ? Scaffold(
                appBar: AppBar(title: Text(widget.title)),
                body: const Center(child: CircularProgressIndicator()))
            : widget.builder(_counter);
      }),
    );
  }
}
