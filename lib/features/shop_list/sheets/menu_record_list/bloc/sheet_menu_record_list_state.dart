part of 'sheet_menu_record_list_bloc.dart';

@immutable
sealed class SheetMenuRecordListState {}

final class SheetMenuRecordListInitial extends SheetMenuRecordListState {
  SheetMenuRecordListInitial(this.recordList);
  final RecordList recordList;
}

final class SheetMenuRecordListRenameState extends SheetMenuRecordListState {}

final class SheetMenuRecordListDeleteState extends SheetMenuRecordListState {}
