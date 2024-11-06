import 'package:csp/csp.dart';
import 'package:csp/csp_constraints.dart';
import 'package:csp/csp_solvers.dart';
import 'package:csp/src/model/csp_types.dart';

void main() {
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

  CSP.printCSP(csp.solve());
}
