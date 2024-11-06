
import 'package:csp/src/model/csp_model.dart';

abstract class CSPSolver<T> {
  T? solve({required CSP csp, ArcPruner? pruner});
}