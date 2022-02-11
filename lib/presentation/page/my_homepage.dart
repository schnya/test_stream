import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_stream/presentation/widget/increment_button.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DocumentReference<Map<String, dynamic>> docRef =
      firestore.collection('counter').doc('hoge');

  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _counterStream =
      docRef.snapshots();

  void _incrementCounter(int counter) {
    docRef.update({'counter': ++counter});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _counterStream,
      builder: ((
        BuildContext context,
        AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot,
      ) {
        // ignore: avoid_print
        print('🔥Connect firestore');
        int _counter = snapshot.data?.get('counter') as int? ?? 0;

        return Scaffold(
          appBar: AppBar(title: Text(widget.title)),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                snapshot.connectionState == ConnectionState.waiting
                    ? const CircularProgressIndicator()
                    : Text(
                        '$_counter',
                        style: Theme.of(context).textTheme.headline4,
                      ),
              ],
            ),
          ),
          floatingActionButton:
              IncrementButton(onPressed: () => _incrementCounter(_counter)),
        );
      }),
    );
  }
}
