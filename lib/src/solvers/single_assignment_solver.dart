import 'package:csp/csp.dart';
import 'package:csp/src/model/csp_solver.dart';

import '../pruner/arc3_pruner.dart';

/// The `SingleAssignmentSolver` class provides a backtracking algorithm to solve Constraint Satisfaction Problems (CSPs) by assigning a single value to each variable.
///
/// This solver iterates over the variables, assigning values to them while ensuring that each assignment satisfies all given constraints.
/// If a variable cannot be assigned a valid value, the algorithm backtracks and attempts a different value.
/// This process continues until a valid assignment is found for all variables or it is determined that no solution is possible.
///
/// Key Features:
/// - **Backtracking Algorithm**: Efficiently explores possible assignments and backtracks when necessary.
/// - **Single Value Assignment**: Assigns a single value to each variable, ensuring simplicity and clarity.
/// - **Constraint Satisfaction**: Ensures that all assignments meet the specified constraints.
///
/// Example Usage:
/// ```dart
/// // Define variables and constraints
/// List<CSPVariable> variables = [/*...*/];
/// List<CSPConstraint> constraints = [/*...*/];
///
/// // Initialize the solver
/// SingleAssignmentSolver solver = SingleAssignmentSolver();
///
/// // Create a CSP instance
/// CSP<Map<String, String>> csp = CSP(
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
class SingleAssignmentSolver extends CSPSolver<Map<String, String>> {
  @override
  Map<String, String>? solve({required CSP csp, ArcPruner? pruner}) {
    pruner ??= Arc3Pruner();
    pruner.prune(csp);
    return _backtrack({}, csp.variables, csp.constraints);
  }

  Map<String, String>? _backtrack(
    Map<String, String> assignments,
    List<CSPVariable> variables,
    List<CSPConstraint> constraints,
  ) {
    // If all variables are assigned, we're done
    if (assignments.length == variables.length) {
      return assignments;
    }

    // Select an unassigned variable
    var unassigned =
        variables.firstWhere((v) => !assignments.containsKey(v.descriptor));

    for (var value in unassigned.domains) {
      // Create a new assignment
      Map<String, String> newAssignments = {
        ...assignments,
        unassigned.descriptor: value
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
}
