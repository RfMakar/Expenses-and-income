part of 'dialog_add_shop_list_bloc.dart';

@immutable
sealed class DialogAddShopListEvent {}

class DialogAddShopListInsertDBEvent extends DialogAddShopListEvent {
  DialogAddShopListInsertDBEvent({required this.nameShopList});
  final String nameShopList;
}
