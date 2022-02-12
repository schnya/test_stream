import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:test_stream/domain/utils.dart' show app;
import 'package:test_stream/presentation/widget/increment_button.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseMessaging messaging = FirebaseMessaging.instance;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? token = 'hoge';
  late var future = firestore.collection('counter').doc(token).get();

  @override
  void initState() {
    super.initState();

    app.init();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    messaging.getToken().then((value) => setState(() => token = value));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: ((
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        // ignore: avoid_print
        print('🔥Connect firestore');
        int _counter = snapshot.data?.get('counter') as int? ?? 0;

        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('これだけ何度もボタンを押してるんだから:'),
                    Text('$_counter',
                        style: Theme.of(context).textTheme.headline4),
                    hogehoge,
                  ],
                ),
          floatingActionButton: IncrementButton(
            onPressed: () {
              app.incrementCounter(token, _counter);
              setState(() => ++_counter);
            },
          ),
        );
      }),
    );
  }

  Widget get hogehoge {
    return FutureBuilder(
        future: app.friendCounter(token),
        builder: (
          BuildContext context,
          AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
        ) {
          // ignore: avoid_print
          print('🔥Connect firestore');
          int _counter = snapshot.data?.get('counter') as int? ?? 0;

          return Align(
            alignment: Alignment.bottomLeft,
            child: Text('$_counter'),
          );
        });
  }
}
