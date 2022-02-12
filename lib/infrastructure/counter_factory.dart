import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test_stream/domain/value/ref.dart';

import '../domain/counter_factory_base.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseMessaging messaging = FirebaseMessaging.instance;

class CounterFactory implements CounterFactoryBase {
  const CounterFactory();

  @override
  CounterRef createRef(String? token) {
    return CounterRef(ref: firestore.collection('counter').doc(token));
  }
}
