import 'package:budget/const/actions_update.dart';
import 'package:budget/dialogs/app_shop_list/add_record_list/dialog_add_record_list.dart';
import 'package:budget/models/app_shop_list/shop_list.dart';
import 'package:budget/screens/app_shop_list/record_list/provider_screen_record_list.dart';
import 'package:budget/sheets/app_shop_list/menu_record_list/sheet_menu_record_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenRecordList extends StatelessWidget {
  const ScreenRecordList({super.key, required this.shopList});
  final ShopList shopList;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ProviderScreenRecordlist(shopList),
        child: Consumer<ProviderScreenRecordlist>(
          builder: (context, provider, child) {
            return Scaffold(
              appBar: AppBar(title: Text(shopList.name)),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  bool result = await showDialog(
                    context: context,
                    builder: (context) =>
                        DialogAddRecordList(shopList: provider.shopList),
                  );
                  if (result) {
                    provider.updateScreen();
                  }
                },
                label: const Text('Запись'),
                icon: const Icon(Icons.add),
              ),
              body: FutureBuilder(
                future: provider.getListRecord(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.listRecordList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 0.5,
                        child: ListTile(
                          title: Text(
                            provider.titleRecordList(index),
                            style: TextStyle(
                              decoration: provider.valueSelectRecordList(index)
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: Checkbox(
                            value: provider.valueSelectRecordList(index),
                            onChanged: (select) {
                              provider.onChangedListTile(select!, index);
                            },
                          ),
                          onLongPress: () async {
                            final ActionsUpdate? actionsUpdate =
                                await showModalBottomSheet(
                              context: context,
                              builder: (context) => SheetMenuRecordList(
                                  recordList: provider.recordList(index)),
                            );
                            if (actionsUpdate == ActionsUpdate.updateScreen) {
                              provider.updateScreen();
                            }
                          },
                          onTap: () => provider.onTapSelectListTile(index),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          },
        ));
  }
}
