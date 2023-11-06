import 'package:bloc/bloc.dart';
import 'package:budget/repositories/shop_list/models/shop_list.dart';
import 'package:budget/repositories/shop_list/sqllite/db_shop_lists.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'dialog_add_shop_list_event.dart';
part 'dialog_add_shop_list_state.dart';

class DialogAddShopListBloc
    extends Bloc<DialogAddShopListEvent, DialogAddShopListState> {
  DialogAddShopListBloc() : super(DialogAddShopListInitial()) {
    on<DialogAddShopListInsertDBEvent>((event, emit) {
      final writeShopList = WriteShopList(name: event.nameShopList);
      DBShopList.insertShopList(writeShopList);
    });
  }
}
