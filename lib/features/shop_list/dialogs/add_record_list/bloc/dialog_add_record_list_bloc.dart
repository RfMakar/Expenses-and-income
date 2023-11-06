import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dialog_add_record_list_event.dart';
part 'dialog_add_record_list_state.dart';

class DialogAddRecordListBloc
    extends Bloc<DialogAddRecordListEvent, DialogAddRecordListState> {
  DialogAddRecordListBloc() : super(DialogAddRecordListInitial()) {
    on<DialogAddRecordListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
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