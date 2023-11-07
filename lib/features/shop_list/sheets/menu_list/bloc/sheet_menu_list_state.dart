part of 'sheet_menu_list_bloc.dart';

@immutable
sealed class SheetMenuListState {}

final class SheetMenuListInitial extends SheetMenuListState {}

final class SheetMenuListMarkState extends SheetMenuListState {}

final class SheetMenuListRestoreState extends SheetMenuListState {}

final class SheetMenuListDeleteState extends SheetMenuListState {}

final class SheetMenuListClearState extends SheetMenuListState {}
