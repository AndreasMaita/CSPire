import 'package:csp/csp.dart';

class Arc3Pruner implements ArcPruner {
  @override
  prune(CSP csp) {
    // Step 1: Initialize the queue with all arcs in the CSP
    List<List<CSPVariable>> queue = [];
    for (var variable in csp.variables) {
      for (var neighbor in csp.variables) {
        if (variable != neighbor) {
          queue.add([variable, neighbor]);
        }
      }
    }

    // Step 2: Process the queue until it is empty
    while (queue.isNotEmpty) {
      var arc = queue.removeAt(0);
      var x = arc[0];
      var y = arc[1];

      // Step 3: Revise the domain of variable x with respect to variable y
      if (_revise(x, y, csp.constraints)) {
        // If the domain of x is empty after revision, return failure
        if (x.domains.isEmpty) {
          return false;
        }

        // Step 4: If the domain of x was revised, add all neighboring arcs back to the queue
        for (var neighbor in csp.variables) {
          if (neighbor != x && neighbor != y) {
            queue.add([neighbor, x]);
          }
        }
      }
    }

    return true; // CSP is arc consistent
  }

  bool _revise(CSPVariable x, CSPVariable y, List<CSPConstraint> constraints) {
    bool revised = false;

    // Iterate over each value in the domain of x
    for (int i = x.domains.length - 1; i >= 0; i--) {
      var valueX = x.domains[i];
      bool hasSupport = false;

      // Check if there is a value in the domain of y that is consistent with valueX
      for (var valueY in y.domains) {
        var affectedConstraints = constraints
            .where((constraint) =>
                constraint.variables.contains(x) ||
                constraint.variables.contains(y))
            .toList();
        if (_isConsistent(
            x.descriptor, valueX, y.descriptor, valueY, affectedConstraints)) {
          hasSupport = true;
          break;
        }
      }

      // If no value in y's domain supports valueX, remove valueX from x's domain
      if (!hasSupport) {
        x.domains.removeAt(i);
        revised = true;
      }
    }

    return revised;
  }

  bool _isConsistent(
      String descriptorX, String valueX, String descriptorY, String valueY,
      [List<CSPConstraint>? constraints]) {
    if (constraints != null) {
      for (var constraint in constraints) {
        if (!constraint
            .isSatisfied({descriptorX: valueX, descriptorY: valueY})) {
          return false;
        }
      }
    }
    return true;
  }
}
