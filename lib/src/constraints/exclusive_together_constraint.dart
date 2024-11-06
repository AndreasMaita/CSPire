import 'package:csp/csp.dart';

/// The `ExclusiveTogetherConstraint` class enforces a constraint where the values assigned to two variables must be mutually exclusive.
///
/// This constraint ensures that if one variable is assigned a value, the other variable cannot be assigned the same value.
/// It is particularly useful in scenarios where certain variables should not share the same value.
///
/// Example Usage:
/// ```dart
/// // Define variables
/// CSPVariable varA = CSPVariable('A', ['1', '2', '3']);
/// CSPVariable varB = CSPVariable('B', ['1', '2', '3']);
///
/// // Create the constraint
/// ExclusiveTogetherConstraint constraint = ExclusiveTogetherConstraint(
///   dependant: varA,
///   dependantOn: varB,
/// );
///
/// // Add the constraint to the list of constraints
/// List<CSPConstraint> constraints = [constraint];
/// ```
class ExclusiveTogetherConstraint
    implements CSPConstraint<Map<String, List<String>>> {
  CSPVariable dependant;
  CSPVariable dependantOn;

  @override
  bool isSatisfied(Map<String, List<String>> assignments) {
    // Only check if both variables have been assigned
    if (!assignments.containsKey(dependant.descriptor) ||
        !assignments.containsKey(dependantOn.descriptor)) {
      return true; // Not enough information yet to evaluate this constraint
    }
    if (assignments[dependant.descriptor]!.isEmpty) {
      return true;
    }

    return assignments[dependant.descriptor]?.every((value) =>
            assignments[dependantOn.descriptor]?.contains(value) ?? false) ??
        true;
  }

  @override
  List<CSPVariable> get variables => [dependant, dependantOn];

  ExclusiveTogetherConstraint(
      {required this.dependant, required this.dependantOn});
}
