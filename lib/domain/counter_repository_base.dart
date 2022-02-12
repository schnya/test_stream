import 'package:test_stream/domain/value/ref.dart';

abstract class CounterRepositoryBase {
  void incrementCounter(int counter, {required CounterRef ref});
}
