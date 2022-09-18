import 'package:flutter/material.dart';

class BottomSheetDelEdit extends StatelessWidget {
  const BottomSheetDelEdit(
      {Key? key, required this.onTapDelete, required this.onTapEdit})
      : super(key: key);
  final void Function() onTapDelete;
  final void Function() onTapEdit;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: onTapDelete,
              icon: const Icon(Icons.delete),
              label: const Text('Удалить'),
            ),
            TextButton.icon(
              onPressed: onTapEdit,
              icon: const Icon(Icons.create),
              label: const Text('Изменить'),
            ),
          ],
        ),
      ],
    );
  }
}
