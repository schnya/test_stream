import 'value/ref.dart';

abstract class CounterFactoryBase {
  CounterRef createRef(String? token);
}
