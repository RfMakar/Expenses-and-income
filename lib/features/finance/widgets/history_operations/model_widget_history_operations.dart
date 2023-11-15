import 'package:budget/repositories/finance/models/operations.dart';

class ModelWidgetHistoryOperations {
  ModelWidgetHistoryOperations(this.listHistoryOperation, this.updatePage);
  final List<HistoryOperation> listHistoryOperation;
  final void Function() updatePage;
}
