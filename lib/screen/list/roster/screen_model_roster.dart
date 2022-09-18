import 'package:budget/screen/list/roster/model_roster.dart';
import 'package:budget/screen/list/shop_list/screen_shop_list.dart';
import 'package:flutter/material.dart';
import 'package:budget/database/list/db_shop_list.dart';
import 'package:budget/database/list/db_roster.dart';
import 'package:budget/model/roster.dart';

class ScreenModelRoster extends ChangeNotifier {
  Roster? _editRoster;
  var textController = TextEditingController();
  var _validateTextField = false;
  var addButton = true;
  var focusNode = FocusNode();

  String? errorText() {
    return _validateTextField ? 'Введите текст' : null;
  }

  void onPressedIconButtonAddRoster(BuildContext context) {
    var nameRoster = textController.text;
    if (nameRoster.isNotEmpty) {
      var roster = Roster(name: nameRoster);
      DBRoster.insert(roster);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScreenShopList(roster: roster)),
      );
      _clearTextField();
    } else {
      _errorTextField();
    }
  }

  void onPressedIconButtonEditRoster() async {
    var nameRoster = textController.text;
    if (nameRoster.isNotEmpty) {
      var roster = Roster(name: nameRoster);
      DBShopList.updateRoster(roster, _editRoster!);
      DBRoster.update(roster, _editRoster!);
      _clearTextField();
    } else {
      _errorTextField();
    }
  }

  void _clearTextField() {
    textController.clear();
    focusNode.unfocus();
    if (_validateTextField) {
      _validateTextField = false;
    }
    if (!addButton) {
      addButton = true;
    }
    notifyListeners();
  }

  void _errorTextField() {
    _validateTextField = true;
    notifyListeners();
  }

  void onTapListTile(BuildContext context, ModelRoster modelRoster) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ScreenShopList(roster: modelRoster.roster)),
    );
  }

  void onLongPressListTileDelete(ModelRoster modelCardShop) {
    final roster = modelCardShop.roster;
    DBRoster.delete(roster);
    DBShopList.deleteRoster(roster);
    notifyListeners();
  }

  void onLongPressListTileEdit(ModelRoster modelRoster) {
    textController.text = modelRoster.title;
    addButton = false;
    _editRoster = modelRoster.roster;
    focusNode.requestFocus();
    notifyListeners();
  }

  Future<List<ModelRoster>> getList() async {
    List<ModelRoster> listModelRoster = [];
    var list = await DBRoster.getList();
    for (var roster in list) {
      listModelRoster.add(ModelRoster(roster));
    }
    return listModelRoster;
  }
}
