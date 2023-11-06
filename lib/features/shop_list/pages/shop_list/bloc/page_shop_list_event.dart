part of 'page_shop_list_bloc.dart';

@immutable
sealed class PageShopListEvent {}

class PageShopListLoadingEvent extends PageShopListEvent {}

class PageShopListLoadedEvent extends PageShopListEvent {}
