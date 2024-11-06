import 'package:csp/csp.dart';
import 'package:csp/src/model/csp_types.dart';
import 'package:csp/src/pruner/arc3_pruner.dart';
import 'package:csp/src/solvers/multiple_assignment_solver.dart';
import 'package:csp/src/constraints/exclusive_together_constraint.dart';
import 'package:csp/src/constraints/only_two_entries_constraint.dart';

void main() {
  var dates = [
    "03.11.24",
    "06.11.24",
    "10.11.24",
    "13.11.24",
    "17.11.24",
    "20.11.24",
    "24.11.24",
    "27.11.24"
  ];
  var andi = CSPVariable<String>(descriptor: "Andi", domains: dates);
  var anni = CSPVariable<String>(descriptor: "Annika", domains: dates);
  var daniel = CSPVariable<String>(descriptor: "Daniel", domains: dates);
  var roberto = CSPVariable<String>(descriptor: "Roberto", domains: dates);
  var david = CSPVariable<String>(descriptor: "David", domains: dates);
  var samira = CSPVariable<String>(descriptor: "Samira", domains: dates);
  var jasmin = CSPVariable<String>(descriptor: "Jasmin", domains: dates);
  var nadine = CSPVariable<String>(descriptor: "Nadine", domains: dates);
  var moni = CSPVariable<String>(descriptor: "Monika", domains: dates);
  var andir = CSPVariable<String>(descriptor: "Andi R.", domains: dates);
  var andiw = CSPVariable<String>(descriptor: "Andi W.", domains: dates);

  List<CSPConstraint<MultipleAssignment>> constraints = [
    ExclusiveTogetherConstraint(dependant: anni, dependantOn: andi),
    ExclusiveTogetherConstraint(dependant: samira, dependantOn: david),
    ExclusiveTogetherConstraint(dependant: jasmin, dependantOn: roberto),
    ExclusiveTogetherConstraint(dependant: nadine, dependantOn: daniel),
    ExclusiveTogetherConstraint(dependant: moni, dependantOn: andir),

    /// constraint to allow only two people for a date
    ...[for (var date in dates) Only2EntriesConstraint(value: date)]
  ];

  var csp = CSP<MultipleAssignment>(
    variables: [
      andi,
      anni,
      daniel,
      nadine,
      roberto,
      jasmin,
      david,
      samira,
      moni,
      andiw,
      andir
    ],
    solver: MultipleAssignmentSolver(),
    constraints: constraints,
    pruner: Arc3Pruner(),
  );

  Map<String, List<String>>? solution = csp.solve();
  if (solution != null) {
    for (var entry in solution.entries) {
      print('Variable: ${entry.key}, Value: ${entry.value}');
    }
  } else {
    print('No solution found');
  }
}
