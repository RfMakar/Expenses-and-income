part of 'sheet_menu_shop_list_bloc.dart';

@immutable
sealed class SheetMenuShopListState {}

final class SheetMenuShopListInitial extends SheetMenuShopListState {
  SheetMenuShopListInitial(this.shopList);
  final ShopList shopList;
}

final class SheetMenuShopListRenameState extends SheetMenuShopListState {}

final class SheetMenuShopListDeleteState extends SheetMenuShopListState {}
