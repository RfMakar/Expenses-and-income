import 'package:budget/repositories/finanse/models/operations.dart';
import 'package:flutter/material.dart';

class ProviderWidgetHistory extends ChangeNotifier {
  final int idfinance;
  final List<HistoryOperation> listHistoryOperation;

  ProviderWidgetHistory(this.listHistoryOperation, this.idfinance);

  String titleHistoryOperation(int index) {
    return listHistoryOperation[index].getDateFormat();
  }

  String valueHistory(int index) {
    return listHistoryOperation[index].getValue(idfinance);
  }

  List<Operation> listOperation(int index) {
    return listHistoryOperation[index].listOperation ?? [];
  }

  Operation operation(int indexHistory, int indexOperation) {
    return listOperation(indexHistory)[indexOperation];
  }

  String titleOperation(int indexHistory, int indexOperation) {
    return listOperation(indexHistory)[indexOperation].nameCategory;
  }

  String subTitleOperation(int indexHistory, int indexOperation) {
    return listOperation(indexHistory)[indexOperation].nameSubCategory;
  }

  String trailingOperation(int indexHistory, int indexOperation) {
    return listOperation(indexHistory)[indexOperation].getValue(idfinance);
  }
}
