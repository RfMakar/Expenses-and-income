import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/record_list.dart';
import 'package:budget/repositories/shop_list/sqlite/db_shop_lists.dart';
import 'package:meta/meta.dart';

part 'sheet_menu_record_list_event.dart';
part 'sheet_menu_record_list_state.dart';

class SheetMenuRecordListBloc
    extends Bloc<SheetMenuRecordListEvent, SheetMenuRecordListState> {
  SheetMenuRecordListBloc(this._recordList)
      : super(SheetMenuRecordListInitial(_recordList)) {
    on<SheetMenuRecordListRenameEvent>((event, emit) async {
      await DBShopList.updateRecordListName(
          event.nameRecordList, _recordList.id);
      emit(SheetMenuRecordListRenameState());
    });
    on<SheetMenuRecordListDeleteEvent>((event, emit) async {
      await DBShopList.deleteRecordList(_recordList.id);
      emit(SheetMenuRecordListDeleteState());
    });
  }

  final RecordList _recordList;
}
