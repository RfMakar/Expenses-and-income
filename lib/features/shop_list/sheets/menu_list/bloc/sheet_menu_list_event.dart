part of 'sheet_menu_list_bloc.dart';

@immutable
sealed class SheetMenuListEvent {}

class SheetMenuListInitialEvent extends SheetMenuListEvent {}

class SheetMenuListOnPresButMarkEvent extends SheetMenuListEvent {}

class SheetMenuListOnPresButRestoreEvent extends SheetMenuListEvent {}

class SheetMenuListOnPresButDeleteEvent extends SheetMenuListEvent {}

class SheetMenuListOnPresButClearEvent extends SheetMenuListEvent {}
