import 'package:csp/csp.dart';

/// The `NotValueConstraint` enforces that a variable must not have a specific value.
///
/// Note: This constraint only works with CSPs of type `Map<String, String>`.
///
/// Example:
/// ```dart
/// CSPVariable var = CSPVariable('A', ['1', '2', '3']);
/// NotValueConstraint constraint = NotValueConstraint(var, '2');
/// ```

class NotValueConstraint<T, V> implements CSPConstraint<T> {
  final CSPVariable<V> variable;
  final V value;
  final V? Function(T assignments, String descriptor) valueExtractor;

  @override
  bool isSatisfied(T assignments) {
    final extractedValue = valueExtractor(assignments, variable.descriptor);

    if (extractedValue == null) {
      return true;
    }
    return extractedValue != value;
  }

  @override
  List<CSPVariable> get variables => [variable];

  NotValueConstraint(this.variable, this.value, this.valueExtractor);
}
