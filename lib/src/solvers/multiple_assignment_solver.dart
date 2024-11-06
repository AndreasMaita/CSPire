import 'package:csp/csp.dart';
import 'package:csp/src/model/csp_solver.dart';

/// The `MultipleAssignmentSolver` class implements a backtracking algorithm designed to solve Constraint Satisfaction Problems (CSPs) by assigning multiple values to each variable.
///
/// This solver iterates over the variables and assigns values to them, ensuring that each assignment satisfies all given constraints.
/// If a variable cannot be assigned a valid value, the algorithm backtracks and attempts a different value.
/// This process continues until a valid assignment is found for all variables or it is determined that no solution is possible.
///
/// Key Features:
/// - **Backtracking Algorithm**: Efficiently explores possible assignments and backtracks when necessary.
/// - **Multiple Values Assignment**: Allows multiple values to be assigned to each variable, enhancing flexibility.
/// - **Constraint Satisfaction**: Ensures that all assignments meet the specified constraints.
///
/// Example Usage:
/// ```dart
/// // Define variables and constraints
/// List<CSPVariable> variables = [/*...*/];
/// List<CSPConstraint> constraints = [/*...*/];
///
/// // Initialize the solver
/// MultipleAssignmentSolver solver = MultipleAssignmentSolver();
///
/// // Create a CSP instance
/// CSP<Map<String, List<String>>> csp = CSP(
///   variables: variables,
///   constraints: constraints,
///   solver: solver,
/// );
///
/// // Solve the CSP
/// var solution = csp.solve();
/// if (solution != null) {
///   CSP.printCSP(solution);
/// } else {
///   print('No solution found');
/// }
/// ```
class MultipleAssignmentSolver implements CSPSolver<Map<String, List<String>>> {
  @override
  Map<String, List<String>>? solve({required CSP csp, ArcPruner? pruner}) {
    // pruner ??= Arc3Pruner();
    // pruner.prune(csp);
    return _backtrack({}, csp.variables, csp.constraints);
  }

  Map<String, List<String>>? _backtrack(
    Map<String, List<String>> assignments,
    List<CSPVariable> variables,
    List<CSPConstraint> constraints,
  ) {
    // If all variables have at least one assignment and all values are assigned, we're done
    if (assignments.length == variables.length &&
        assignments.values.every((values) => values.isNotEmpty) &&
        _allValuesAssigned(assignments, variables)) {
      return assignments;
    }

    // Select the next variable that has fewer assignments
    var unassigned = variables
        .where((v) =>
            !assignments.containsKey(v.descriptor) ||
            assignments[v.descriptor]!.length < v.domains.length)
        .toList();

    if (unassigned.isEmpty) {
      return null;
    }

    unassigned.sort((a, b) => (assignments[a.descriptor]?.length ?? 0)
        .compareTo(assignments[b.descriptor]?.length ?? 0));

    var variable = unassigned.first;

    // Iterate over possible values for the selected variable
    for (var value in variable.domains) {
      // Ensure the value hasn't been assigned already
      if (_valueAlreadyAssigned(value, assignments, variable.descriptor)) {
        continue; // Skip if the value is already assigned to another variable
      }

      // Create or update assignment for the variable
      Map<String, List<String>> newAssignments = {
        ...assignments,
        variable.descriptor: [
          ...(assignments[variable.descriptor] ?? []),
          value
        ]
      };

      // Check if this assignment is valid for all constraints
      if (constraints
          .every((constraint) => constraint.isSatisfied(newAssignments))) {
        // Recursively attempt to assign remaining variables
        var result = _backtrack(newAssignments, variables, constraints);
        if (result != null) {
          return result; // Solution found
        }
      }
    }

    return null; // Backtrack if no solution is found
  }

  bool _valueAlreadyAssigned(
      String value, Map<String, List<String>> assignments, String descriptor) {
    if (assignments[descriptor] != null) {
      return assignments[descriptor]!.any((values) => values.contains(value));
    }
    return false;
  }

  bool _allValuesAssigned(
      Map<String, List<String>> assignments, List<CSPVariable> variables) {
    var allValues = variables.expand((v) => v.domains).toSet();
    var assignedValues = assignments.values.expand((v) => v).toSet();
    return assignedValues.containsAll(allValues);
  }
}
