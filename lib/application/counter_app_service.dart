import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:test_stream/domain/category_service.dart';

import '../domain/counter_factory_base.dart';
import '../domain/counter_repository_base.dart';

import '../domain/value/ref.dart';

class CounterAppService {
  final CounterFactoryBase _factory;
  final CounterRepositoryBase _repository;
  final CounterService _service;

  CounterAppService({
    required CounterFactoryBase factory,
    required CounterRepositoryBase repository,
  })  : _factory = factory,
        _repository = repository,
        _service = CounterService(repository: repository);

  Future<NotificationSettings> init() async {
    return await _service.requestPermission();
  }

  void incrementCounter(String? token, int counter) {
    CounterRef ref = _factory.createRef(token);
    _repository.incrementCounter(counter, ref: ref);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>? friendCounter(token) async {
    CounterRef ref = _factory.createRef(token);
    late List<String> friendsToken;
    await ref.get().then((value) => friendsToken =
        (value.get('friends') as List).whereType<String>().toList());

    CounterRef friendref = _factory.createRef(friendsToken[0]);
    return friendref.get();
  }
}
