/// A variable in a Constraint Satisfaction Problem (CSP) with a domain of possible values.
///
/// The type parameter `V` defines the type of values in the domain.
///
/// Example:
/// ```dart
/// CSPVariable<String> var = CSPVariable('A', ['1', '2', '3']); // String domain
/// CSPVariable<int> var = CSPVariable('B', [1, 2, 3]); // Integer domain
/// ```
class CSPVariable<V> {
  final String descriptor;
  final List<V> domains;

  CSPVariable({
    required this.descriptor,
    required this.domains,
  });
}
