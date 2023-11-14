import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/repositories/shop_list/sqlite/db_shop_lists.dart';
import 'package:meta/meta.dart';

part 'dialog_add_shop_list_event.dart';
part 'dialog_add_shop_list_state.dart';

class DialogAddShopListBloc
    extends Bloc<DialogAddShopListEvent, DialogAddShopListState> {
  DialogAddShopListBloc() : super(DialogAddShopListInitial()) {
    on<DialogAddShopListOnPressedButtonAddEvent>((event, emit) {
      final writeShopList = WriteShopList(name: event.nameShopList);
      DBShopList.insertShopList(writeShopList);
      emit(DialogAddShopListAddState());
    });
    on<DialogAddShopListOnPressedButtonCancelEvent>((event, emit) {
      emit(DialogAddShopListCancelState());
    });
  }
}
