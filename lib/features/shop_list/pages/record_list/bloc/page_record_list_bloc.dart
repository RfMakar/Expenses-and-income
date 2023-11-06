import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_record_list_event.dart';
part 'page_record_list_state.dart';

class PageRecordListBloc
    extends Bloc<PageRecordListEvent, PageRecordListState> {
  PageRecordListBloc() : super(PageRecordListInitial()) {
    on<PageRecordListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}


/*
class ProviderScreenRecordlist extends ChangeNotifier {
  ProviderScreenRecordlist(this.shopList);
  final ShopList shopList;
  late List<RecordList> listRecordList;

  String titleAppBar() {
    return shopList.name;
  }

  RecordList recordList(int index) {
    return listRecordList[index];
  }

  bool valueSelectRecordList(int index) {
    return listRecordList[index].isselected == 0 ? false : true;
  }

  void onChangedListTile(bool select, int index) {
    final selected = select == false ? 0 : 1;
    final idRecordList = listRecordList[index].id;
    DBShopList.updateSelectedRecordList(selected, idRecordList);
    notifyListeners();
  }

  void onTapSelectListTile(int index) {
    final selected = listRecordList[index].isselected == 0 ? 1 : 0;
    final idRecordList = listRecordList[index].id;
    DBShopList.updateSelectedRecordList(selected, idRecordList);
    notifyListeners();
  }

  String titleCardRecordList(int index) {
    return listRecordList[index].name;
  }

  void updateScreen() async {
    notifyListeners();
  }

  Future getListRecord() async {
    listRecordList = await DBShopList.getListRecordList(shopList.id);
  }
}


*/