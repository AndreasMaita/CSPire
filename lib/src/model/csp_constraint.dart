import 'package:csp/csp.dart';

abstract class CSPConstraint<T> {
  List<CSPVariable> get variables;
  
  bool isSatisfied(T assignments);
}