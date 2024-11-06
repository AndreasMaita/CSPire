import 'package:csp/csp.dart';

/// The `Only2EntriesConstraint` enforces that a variable must have only two values.
///
/// Note: This constraint only works with CSPs of type `Map<String, List<String>>`.
///
/// Example:
/// ```dart
/// CSPVariable var = CSPVariable('A', ['1', '2', '3']);
/// Only2EntriesConstraint constraint = Only2EntriesConstraint(var, '2');
/// ```

class Only2EntriesConstraint
    implements CSPConstraint<Map<String, List<String>>> {
  String value;

  @override
  bool isSatisfied(Map<String, List<String>> assignments) {
    var test =
        assignments.values.where((param) => param.contains(value)).length;
    if (test <= 2) {
      return true;
    }
    return false;
  }

  Only2EntriesConstraint({required this.value});

  @override
  List<CSPVariable> get variables => [];
}
