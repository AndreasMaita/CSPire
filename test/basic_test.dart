import 'package:csp/csp.dart';
import 'package:csp/csp_constraints.dart';
import 'package:csp/src/model/csp_types.dart';
import 'package:csp/src/solvers/single_assignment_solver.dart';
import 'package:test/test.dart';

void main() {
  group('Basic CSP to with Binary Constraint', () {
    test('Solve simple CSP', () {
      var x = CSPVariable<String>(descriptor: "X", domains: ["1", "2"]);
      var y = CSPVariable<String>(descriptor: "Y", domains: ["1", "2"]);
      var z = CSPVariable<String>(descriptor: "Z", domains: ["1", "2"]);

      var constraints = [
        NotEqualConstraint(
            x,
            z,
            (assignments, descriptor) =>
                (assignments as SingleAssignment)[descriptor] ?? ''),
        NotEqualConstraint(
            x,
            y,
            (assignments, descriptor) =>
                (assignments as SingleAssignment)[descriptor] ?? ''),
        NotValueConstraint(
            x,
            "1",
            (assignments, descriptor) =>
                (assignments as SingleAssignment)[descriptor] ?? ''),
      ];

      var csp = CSP<SingleAssignment>(
          variables: [x, y, z],
          constraints: constraints,
          solver: SingleAssignmentSolver());
      // Solve the CSP
      var solution = csp.solve();
      CSP.printCSP(solution);

      // Verify the solution
      expect(solution, isNotNull);
      expect(solution![x.descriptor], isNot(equals(solution[y.descriptor])));
      expect(solution[y.descriptor], equals(solution[z.descriptor]));
    });

    test('No solution possible', () {
      // Define variables X, Y with domains
      var x = CSPVariable(descriptor: 'X', domains: ['1']);
      var y = CSPVariable(descriptor: 'Y', domains: ['1']);

      // Define constraints (X != Y)
      var constraints = [
        NotEqualConstraint(
            x,
            y,
            (assignments, descriptor) =>
                (assignments as SingleAssignment)[descriptor] ?? ''),
      ];

      // Create the CSP instance
      var csp = CSP(
          variables: [x, y],
          constraints: constraints,
          solver: SingleAssignmentSolver());

      // Solve the CSP
      var solution = csp.solve();

      // Verify that there is no solution
      expect(solution, isNull);
    });
  });
}
