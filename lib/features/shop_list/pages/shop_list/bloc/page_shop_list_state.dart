part of 'page_shop_list_bloc.dart';

@immutable
sealed class PageShopListState {}

final class PageShopListInitial extends PageShopListState {}

final class PageShopListLoadingState extends PageShopListState {}

final class PageShopListLoadedState extends PageShopListState {
  PageShopListLoadedState({required this.listShopList});
  final List<ShopList> listShopList;
}
