part of 'page_shop_list_bloc.dart';

@immutable
sealed class PageShopListEvent {}

final class PageShopListLoadingEvent extends PageShopListEvent {}

final class PageShopListLoadedEvent extends PageShopListEvent {}
