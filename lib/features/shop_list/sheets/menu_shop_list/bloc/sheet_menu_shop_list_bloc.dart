import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/repositories/shop_list/sqlite/db_shop_lists.dart';
import 'package:meta/meta.dart';

part 'sheet_menu_shop_list_event.dart';
part 'sheet_menu_shop_list_state.dart';

class SheetMenuShopListBloc
    extends Bloc<SheetMenuShopListEvent, SheetMenuShopListState> {
  SheetMenuShopListBloc(this._shopList)
      : super(SheetMenuShopListInitial(_shopList)) {
    on<SheetMenuShopListRenameEvent>((event, emit) async {
      await DBShopList.updateShopListName(event.newName, _shopList.id);
      emit(SheetMenuShopListRenameState());
    });
    on<SheetMenuShopListDeleteEvent>((event, emit) async {
      await DBShopList.deleteShopList(_shopList.id);
      emit(SheetMenuShopListDeleteState());
    });
  }
  final ShopList _shopList;
}
