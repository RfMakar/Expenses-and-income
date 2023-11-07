part of 'dialog_add_shop_list_bloc.dart';

@immutable
sealed class DialogAddShopListEvent {}

class DialogAddShopListOnPressedButtonAddEvent extends DialogAddShopListEvent {
  DialogAddShopListOnPressedButtonAddEvent({required this.nameShopList});
  final String nameShopList;
}

class DialogAddShopListOnPressedButtonCancelEvent
    extends DialogAddShopListEvent {}
