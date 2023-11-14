import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/repositories/shop_list/sqlite/db_shop_lists.dart';
import 'package:meta/meta.dart';

part 'page_shop_list_event.dart';
part 'page_shop_list_state.dart';

class PageShopListBloc extends Bloc<PageShopListEvent, PageShopListState> {
  PageShopListBloc() : super(PageShopListInitial()) {
    on<PageShopListLoadingEvent>((event, emit) async {
      emit(PageShopListLoadingState());
      listShopList = await DBShopList.getListShopList();
      emit(PageShopListLoadedState(listShopList: listShopList));
    });
  }

  late List<ShopList> listShopList;
}
