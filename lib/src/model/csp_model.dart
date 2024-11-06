import 'package:csp/csp.dart';
import 'package:csp/src/model/csp_solver.dart';
import 'package:csp/src/pruner/arc3_pruner.dart';

///
/// The `csp_model.dart` file defines the fundamental structure of the Constraint Satisfaction Problem (CSP)
/// which is essential for running a solver on top of it.
///
/// A CSP is characterized by a list of variables and constraints. This class uses generics to ensure flexibility
/// and compatibility with various solvers.
///
/// The generic type `T` must be compatible with the given CSP Solver. For instance, if the Multiple Assignment Solver
/// is used, the generic type should be `Map<String, List<String>>` as that is the type the solver operates on.
///
/// Example usage:
/// ```dart
/// // Define variables and constraints
/// List<CSPVariable> variables = [/*...*/];
/// List<CSPConstraint> constraints = [/*...*/];
///
/// // Initialize the solver
/// CSPSolver<Map<String, List<String>>> solver = MultipleAssignmentSolver();
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
///
/// For more information, refer to the [CSPSolver] and [ArcPruner] classes.
///
class CSP<T> {
  final List<CSPVariable> variables;
  final List<CSPConstraint> constraints;
  CSPSolver<T> solver;
  ArcPruner pruner;

  CSP({
    required this.variables,
    required this.constraints,
    required this.solver,
    ArcPruner? pruner,
  }) : pruner = pruner ?? Arc3Pruner();

  T? solve() {
    return solver.solve(csp: this, pruner: pruner);
  }

  static printCSP(Map<String, String>? csp) {
    if (csp != null) {
      for (var entry in csp.entries) {
        print('Variable: ${entry.key}, Value: ${entry.value}');
      }
    } else {
      print('No solution found');
    }
  }
}

///
/// ArcPruner is an interface to define pruner classes, used to help find inconsistencies and arc incompatiblilities between Variables inside of a CSP.
///
///
abstract class ArcPruner {
  prune(CSP csp);
}
