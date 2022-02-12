import 'package:test_stream/application/counter_app_service.dart';
import 'package:test_stream/infrastructure/counter_factory.dart';
import 'package:test_stream/infrastructure/counter_repository.dart';

final CounterAppService app = CounterAppService(
  factory: const CounterFactory(),
  repository: CounterRepository(),
);
