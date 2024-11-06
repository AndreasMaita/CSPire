import 'package:csp/csp.dart';
import 'package:csp/src/constraints/not_equal_constraint.dart';
import 'package:csp/src/constraints/not_value_constraint.dart';
import 'package:csp/src/pruner/arc3_pruner.dart';
import 'package:csp/src/solvers/single_assignment_solver.dart';

void main() {
  // Define variables X, Y, Z with domains
  var x = CSPVariable(descriptor: 'X', domains: ['1', '2']);
  var y = CSPVariable(descriptor: 'Y', domains: ['1', '2']);
  var z = CSPVariable(descriptor: 'Z', domains: ['2', '3']);

  List<CSPConstraint> constraints = [
    NotEqualConstraint(
        x, y, (assignments, descriptor) => assignments[descriptor]),
    NotEqualConstraint(
        y, z, (assignments, descriptor) => assignments[descriptor]),
    NotValueConstraint(
        x, "1", (assignments, descriptor) => assignments[descriptor]),
  ];

  // Create the CSP instance
  var csp = CSP(
      variables: [x, y, z],
      constraints: constraints,
      solver: SingleAssignmentSolver());

  // Solve the CSP
  Arc3Pruner().prune(csp);
  for (var entry in csp.variables) {
    print('Variable: ${entry.descriptor}, Value: ${entry.domains}');
  }

  var solution = csp.solve();
  CSP.printCSP(solution);
}

// Output should be a valid assignment for X, Y, Z, ensuring X != Y, Y != Z.
