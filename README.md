# CSP Solver

A flexible constraint satisfaction problem (CSP) solver library written in Dart.

## Features

- Generic CSP solver framework that can handle various types of problems
- Multiple solver implementations:
  - Backtracking solver
  - Arc Consistency 3 (MAC3) pruning solver
- Common constraint types included:
  - Not equal constraint
  - Not value constraint  
  - Binary value constraint
  - Exclusive together constraint
- Extensible architecture for custom solvers and constraints
- Well documented API with examples

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  csp_solver:
    path: path/to/csp_solver
```
## Future Features

The following features are planned for future releases:

- Forward checking solver implementation for improved efficiency
- Additional constraint types:
  - All different constraint
  - Arithmetic constraints (>, <, =, etc.)
- Parallel solving capabilities for large-scale problems
- Optimization support for finding best solutions
- Visual solution explorer and debugging tools
- Performance benchmarking tools
- Additional pruning algorithms:
  - AC4 pruning
  - Path consistency
