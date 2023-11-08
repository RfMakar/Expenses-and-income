import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/record_list.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/repositories/shop_list/sqllite/db_shop_lists.dart';
import 'package:meta/meta.dart';

part 'page_record_list_event.dart';
part 'page_record_list_state.dart';

class PageRecordListBloc
    extends Bloc<PageRecordListEvent, PageRecordListState> {
  PageRecordListBloc(this.shopList) : super(PageRecordListInitial()) {
    on<PageRecordListLoadingEvent>((event, emit) async {
      emit(PageRecordListLoadingState());
      _listRecordList = await DBShopList.getListRecordList(shopList.id);
      emit(PageRecordListLoadedState(_listRecordList));
    });

    on<PageRecordListOnTapEvent>((event, emit) async {
      final selected = event.select == true ? 1 : 0;
      final idRecordList = event.recordList.id;
      DBShopList.updateSelectedRecordList(selected, idRecordList);
      _listRecordList = await DBShopList.getListRecordList(shopList.id);
      emit(PageRecordListLoadedState(_listRecordList));
    });
  }
  final ShopList shopList;
  late List<RecordList> _listRecordList;
}


/*
class PageRecordListBloc
    extends Bloc<PageRecordListEvent, PageRecordListState> {
  PageRecordListBloc(this.shopList) : super(PageRecordListInitial()) {
    on<PageRecordListLoadingEvent>((event, emit) async {
      emit(PageRecordListLoadingState());
      _listRecordList = await DBShopList.getListRecordList(shopList.id);
      emit(PageRecordListLoadedState(_listRecordList));
    });

    on<PageRecordListOnTapEvent>((event, emit) async {
      final selected = event.select == true ? 1 : 0;
      final idRecordList = event.recordList.id;
      DBShopList.updateSelectedRecordList(selected, idRecordList);
      _listRecordList = await DBShopList.getListRecordList(shopList.id);
      emit(PageRecordListLoadedState(_listRecordList));
    });
  }
  final ShopList shopList;
  late List<RecordList> _listRecordList;
}

*/