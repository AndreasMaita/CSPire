import 'package:csp/csp.dart';

/// The `LambdaConstraint` class enables custom constraints using lambda functions for cases where built-in constraints are insufficient.
///
/// **Warning**: Due to its inability to specify affected variables at instantiation (empty variables list),
/// this constraint does not benefit from the Arc3 pruning algorithm's optimizations. This makes it less
/// performant compared to built-in constraints and not recommended for performance-critical applications.
///
/// Example:
/// ```dart
/// CSPVariable varA = CSPVariable('A', ['1', '2', '3']);
/// CSPVariable varB = CSPVariable('B', ['1', '2', '3']);
///
/// // Ensure values are not equal
/// LambdaConstraint constraint = LambdaConstraint((assignments) {
///   return assignments['A'] != assignments['B'];
/// });
/// ```
class LambdaConstraint implements CSPConstraint<Map<String, String>> {
  final bool Function(Map<String, String>) _constraintFunction;

  @override
  bool isSatisfied(Map<String, String> assignments) {
    return _constraintFunction(assignments);
  }

  LambdaConstraint(this._constraintFunction);

  @override
  List<CSPVariable> variables = [];
}
