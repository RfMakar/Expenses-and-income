part of 'sheet_menu_record_list_bloc.dart';

@immutable
sealed class SheetMenuRecordListEvent {}

class SheetMenuRecordListInitialEvent extends SheetMenuRecordListEvent {}

class SheetMenuRecordListRenameEvent extends SheetMenuRecordListEvent {
  SheetMenuRecordListRenameEvent(this.nameRecordList);
  final String nameRecordList;
}

class SheetMenuRecordListDeleteEvent extends SheetMenuRecordListEvent {}
