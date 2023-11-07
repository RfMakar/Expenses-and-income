import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/record_list.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/repositories/shop_list/sqllite/db_shop_lists.dart';
import 'package:meta/meta.dart';
part 'dialog_add_record_list_event.dart';
part 'dialog_add_record_list_state.dart';

class DialogAddRecordListBloc
    extends Bloc<DialogAddRecordListEvent, DialogAddRecordListState> {
  DialogAddRecordListBloc(this._shopList)
      : super(DialogAddRecordListInitial(_shopList)) {
    on<DialogAddRecordListAddEvent>((event, emit) {
      final writeRecordList = WriteRecordList(
        name: event.nameRecordList,
        idshoplist: _shopList.id,
        isselected: 0,
      );
      DBShopList.insertRecordList(writeRecordList);
      emit(DialogAddRecordListAddState());
    });
    on<DialogAddRecordListCancelEvent>((event, emit) {
      emit(DialogAddRecordListCancelState());
    });
  }
  final ShopList _shopList;
}


/*

class ProviderDialogAddRecordList extends ChangeNotifier {
  final ShopList shopList;
  ProviderDialogAddRecordList(this.shopList);
  final textEditingControllerName = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool onPressedButtonAddRecordList() {
    if (!formKey.currentState!.validate()) {
      return false;
    } else {
      insertDBRecordList();
      return true;
    }
  }

  void insertDBRecordList() {
    final writeRecordList = WriteRecordList(
      name: textEditingControllerName.text.trim(),
      idshoplist: shopList.id,
      isselected: 0,
    );
    DBShopList.insertRecordList(writeRecordList);
  }
}

*/