part of 'sheet_menu_shop_list_bloc.dart';

@immutable
sealed class SheetMenuShopListEvent {}

class SheetMenuShopListLoadedEvent extends SheetMenuShopListEvent {}

class SheetMenuShopListOnPressedButtonRenameShopListEvent
    extends SheetMenuShopListEvent {
  final String newName;

  SheetMenuShopListOnPressedButtonRenameShopListEvent(this.newName);
}

class SheetMenuShopListOnPressedButtonDeleteShopListEvent
    extends SheetMenuShopListEvent {}
