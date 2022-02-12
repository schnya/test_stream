import 'package:firebase_messaging/firebase_messaging.dart';
import 'counter_repository_base.dart';

final FirebaseMessaging messaging = FirebaseMessaging.instance;

class CounterService {
  // ignore: unused_field
  final CounterRepositoryBase _repository;

  CounterService({required CounterRepositoryBase repository})
      : _repository = repository;

  Future<NotificationSettings> requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // ignore: avoid_print
    print('User granted permission: ${settings.authorizationStatus}');

    return settings;
  }
}
