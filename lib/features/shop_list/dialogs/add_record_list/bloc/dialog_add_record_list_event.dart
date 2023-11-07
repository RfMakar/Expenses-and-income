part of 'dialog_add_record_list_bloc.dart';

@immutable
sealed class DialogAddRecordListEvent {}

class DialogAddRecordListInitialEvent extends DialogAddRecordListEvent {}

class DialogAddRecordListAddEvent extends DialogAddRecordListEvent {
  final String nameRecordList;

  DialogAddRecordListAddEvent(this.nameRecordList);
}

class DialogAddRecordListCancelEvent extends DialogAddRecordListEvent {}
