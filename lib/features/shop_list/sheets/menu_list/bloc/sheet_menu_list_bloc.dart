import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sheet_menu_list_event.dart';
part 'sheet_menu_list_state.dart';

class SheetMenuListBloc extends Bloc<SheetMenuListEvent, SheetMenuListState> {
  SheetMenuListBloc() : super(SheetMenuListInitial()) {
    on<SheetMenuListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
