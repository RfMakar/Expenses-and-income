import 'package:budget/models/operations.dart';
import 'package:flutter/material.dart';

class ProviderHistoryDart extends ChangeNotifier {
  final List<HistoryOperation> listHistoryOperation;

  ProviderHistoryDart(this.listHistoryOperation);
}
