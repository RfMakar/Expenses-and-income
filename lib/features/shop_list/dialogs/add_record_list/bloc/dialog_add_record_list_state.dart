part of 'dialog_add_record_list_bloc.dart';

@immutable
sealed class DialogAddRecordListState {}

final class DialogAddRecordListInitial extends DialogAddRecordListState {
  final ShopList shopList;

  DialogAddRecordListInitial(this.shopList);
}

final class DialogAddRecordListAddState extends DialogAddRecordListState {}

final class DialogAddRecordListCancelState extends DialogAddRecordListState {}
