import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/repositories/shop_list/sqllite/db_shop_lists.dart';
import 'package:meta/meta.dart';

part 'sheet_menu_shop_list_event.dart';
part 'sheet_menu_shop_list_state.dart';

class SheetMenuShopListBloc
    extends Bloc<SheetMenuShopListEvent, SheetMenuShopListState> {
  SheetMenuShopListBloc(this.shopList)
      : super(SheetMenuShopListInitial(shopList)) {
    on<SheetMenuShopListOnPressedButtonRenameShopListEvent>(
        (event, emit) async {
      await DBShopList.updateShopListName(event.newName, shopList.id);
      emit(SheetMenuShopListRenameState());
    });
    on<SheetMenuShopListOnPressedButtonDeleteShopListEvent>(
        (event, emit) async {
      await DBShopList.deleteShopList(shopList.id);
      emit(SheetMenuShopListDeleteState());
    });
  }
  final ShopList shopList;
}
