import '../domain/counter_repository_base.dart';

import '../domain/value/ref.dart';

/// 用途: データの永続化と検索
class CounterRepository implements CounterRepositoryBase {
  @override
  void incrementCounter(int counter, {required CounterRef ref}) {
    ref.update({'counter': ++counter});
  }
}
