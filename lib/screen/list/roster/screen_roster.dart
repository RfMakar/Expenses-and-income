import 'package:budget/screen/list/roster/model_roster.dart';
import 'package:budget/screen/list/roster/screen_model_roster.dart';
import 'package:budget/screen/widget/bottom_sheet_del_edit.dart';
import 'package:flutter/material.dart';
import 'package:budget/screen/widget/my_widget.dart';
import 'package:provider/provider.dart';

class ScreenRoster extends StatelessWidget {
  const ScreenRoster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ScreenModelRoster(),
      child: Stack(
        children: const [
          RosterListWidget(),
          AddNewList(),
        ],
      ),
    );
  }
}

class RosterListWidget extends StatelessWidget {
  const RosterListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ScreenModelRoster>();
    return FutureBuilder<List<ModelRoster>>(
      future: model.getList(),
      builder: ((_, snapshot) {
        if (!snapshot.hasData) {
          return MyWidget.widgetLoading();
        } else if (snapshot.data!.isEmpty) {
          return MyWidget.widgetIsEmpty();
        }
        final listModelRoster = snapshot.data!;
        return ListView.builder(
          padding: const EdgeInsets.only(
            top: 100,
            left: 8,
            right: 8,
            bottom: 8,
          ),
          itemCount: listModelRoster.length,
          itemBuilder: (_, index) {
            final modelRoster = listModelRoster[index];

            return Card(
              child: ListTile(
                title: Text(modelRoster.title),
                trailing: const Icon(Icons.navigate_next),
                onTap: () => model.onTapListTile(context, modelRoster),
                onLongPress: () => onLongPressListTile(
                  context,
                  () => model.onLongPressListTileDelete(modelRoster),
                  () => model.onLongPressListTileEdit(modelRoster),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  void onLongPressListTile(BuildContext context, void Function() onTapDelete,
      void Function() onTapEdit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetDelEdit(
        onTapDelete: () {
          onTapDelete();
          Navigator.pop(context);
        },
        onTapEdit: () {
          onTapEdit();
          Navigator.pop(context);
        },
      ),
    );
  }
}

class AddNewList extends StatelessWidget {
  const AddNewList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenModelRoster>(
      builder: (_, model, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.sentences,
              controller: model.textController,
              focusNode: model.focusNode,
              decoration: InputDecoration(
                hintText: 'Новый список',
                suffixIcon: model.addButton
                    ? iconButtonAddRoster()
                    : iconButtonEditRoster(),
                errorText: model.errorText(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget iconButtonAddRoster() {
    return Builder(builder: (context) {
      var model = context.read<ScreenModelRoster>();
      return IconButton(
        onPressed: () => model.onPressedIconButtonAddRoster(context),
        icon: const Icon(Icons.add),
      );
    });
  }

  Widget iconButtonEditRoster() {
    return Builder(builder: (context) {
      var model = context.read<ScreenModelRoster>();
      return IconButton(
        onPressed: () => model.onPressedIconButtonEditRoster(),
        icon: const Icon(Icons.edit),
      );
    });
  }
}
