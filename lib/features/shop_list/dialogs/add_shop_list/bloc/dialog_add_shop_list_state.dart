part of 'dialog_add_shop_list_bloc.dart';

@immutable
sealed class DialogAddShopListState {}

final class DialogAddShopListInitial extends DialogAddShopListState {}

final class DialogAddShopListCancelState extends DialogAddShopListState {}

final class DialogAddShopListAddState extends DialogAddShopListState {}
