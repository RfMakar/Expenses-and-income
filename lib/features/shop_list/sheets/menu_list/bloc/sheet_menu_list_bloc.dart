import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/repositories/shop_list/sqlite/db_shop_lists.dart';
import 'package:meta/meta.dart';

part 'sheet_menu_list_event.dart';
part 'sheet_menu_list_state.dart';

class SheetMenuListBloc extends Bloc<SheetMenuListEvent, SheetMenuListState> {
  SheetMenuListBloc(this._shopList) : super(SheetMenuListInitial()) {
    on<SheetMenuListOnPresButMarkEvent>((event, emit) async {
      await DBShopList.markRecordList(_shopList.id);
      emit(SheetMenuListMarkState());
    });
    on<SheetMenuListOnPresButRestoreEvent>((event, emit) async {
      await DBShopList.restoreRecordList(_shopList.id);
      emit(SheetMenuListRestoreState());
    });
    on<SheetMenuListOnPresButDeleteEvent>((event, emit) async {
      await DBShopList.deleteSelecetRecordList(_shopList.id);
      emit(SheetMenuListDeleteState());
    });
    on<SheetMenuListOnPresButClearEvent>((event, emit) async {
      await DBShopList.clearShopList(_shopList.id);
      emit(SheetMenuListClearState());
    });
  }
  final ShopList _shopList;
}
