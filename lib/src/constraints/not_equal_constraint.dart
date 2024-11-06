import 'package:csp/csp.dart';

/// Generic constraint that works with any assignment type T and value type V
class NotEqualConstraint<T, V> implements CSPConstraint<T> {
  final CSPVariable<V> variable1;
  final CSPVariable<V> variable2;
  final V? Function(T assignments, String descriptor) valueExtractor;

  NotEqualConstraint(
    this.variable1,
    this.variable2,
    this.valueExtractor,
  );

  @override
  bool isSatisfied(T assignments) {
    final value1 = valueExtractor(assignments, variable1.descriptor);
    final value2 = valueExtractor(assignments, variable2.descriptor);

    if (value1 == null || value2 == null) return true;
    return value1 != value2;
  }

  @override
  List<CSPVariable> get variables => [variable1, variable2];
}
