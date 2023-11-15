import 'package:budget/features/app/const/actions_update.dart';
import 'package:budget/features/app/dialogs/delete/dialog_delete.dart';
import 'package:budget/features/app/dialogs/edit_name/dialog_edit_name.dart';
import 'package:budget/features/shop_list/sheets/menu_record_list/bloc/sheet_menu_record_list_bloc.dart';
import 'package:budget/repositories/shop_list/models/record_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SheetMenuRecordList extends StatelessWidget {
  const SheetMenuRecordList({super.key, required this.recordList});
  final RecordList recordList;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SheetMenuRecordListBloc(recordList),
        child: BlocListener<SheetMenuRecordListBloc, SheetMenuRecordListState>(
          listener: (context, state) {
            if (state is SheetMenuRecordListRenameState) {
              Navigator.pop(context, StateUpdate.page);
            }
            if (state is SheetMenuRecordListDeleteState) {
              Navigator.pop(context, StateUpdate.page);
            }
          },
          child: const SheetView(),
        ));
  }
}

class SheetView extends StatelessWidget {
  const SheetView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      children: [
        TitleSheet(),
        Divider(),
        ButtonRenameRecordList(),
        ButtonDeleteRecordList(),
      ],
    );
  }
}

class TitleSheet extends StatelessWidget {
  const TitleSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetMenuRecordListBloc, SheetMenuRecordListState>(
      builder: (context, state) {
        if (state is SheetMenuRecordListInitial) {
          return ListTile(
            title: Text(state.recordList.name),
            subtitle: const Text(
              'Запись',
              style: TextStyle(fontSize: 10),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ButtonRenameRecordList extends StatelessWidget {
  const ButtonRenameRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SheetMenuRecordListBloc, SheetMenuRecordListState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<SheetMenuRecordListBloc>(context);
        if (state is SheetMenuRecordListInitial) {
          return ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Переименовать'),
            onTap: () async {
              final String? newName = await showDialog(
                context: context,
                builder: (context) =>
                    DialogEditName(nameEdit: state.recordList.name),
              );
              if (newName != null) {
                bloc.add(SheetMenuRecordListRenameEvent(newName));
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ButtonDeleteRecordList extends StatelessWidget {
  const ButtonDeleteRecordList({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SheetMenuRecordListBloc>(context);
    return ListTile(
      leading: const Icon(Icons.delete),
      title: const Text('Удалить'),
      onTap: () async {
        final bool? result = await showDialog(
          context: context,
          builder: (context) => const DialodgDelete(),
        );
        if (result == true) {
          bloc.add(SheetMenuRecordListDeleteEvent());
        }
      },
    );
  }
}
