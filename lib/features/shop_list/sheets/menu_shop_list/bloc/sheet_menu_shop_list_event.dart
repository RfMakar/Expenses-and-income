part of 'sheet_menu_shop_list_bloc.dart';

@immutable
sealed class SheetMenuShopListEvent {}

class SheetMenuShopListInitialEvent extends SheetMenuShopListEvent {}

class SheetMenuShopListRenameEvent extends SheetMenuShopListEvent {
  final String newName;

  SheetMenuShopListRenameEvent(this.newName);
}

class SheetMenuShopListDeleteEvent extends SheetMenuShopListEvent {}
