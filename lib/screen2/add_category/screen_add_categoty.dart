import 'package:budget/screen2/add_category/provider_screen_add_category.dart';
import 'package:budget/screen2/const/const_color.dart';
import 'package:budget/screen2/widget/dialog_app.dart';
import 'package:budget/screen2/widget/selected_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenAddCategory extends StatelessWidget {
  const ScreenAddCategory({super.key, required this.isSelectedBudget});
  final List<bool> isSelectedBudget;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenAddCategory(isSelectedBudget),
      builder: (context, child) => Consumer<ProviderScreenAddCategory>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: provider.color,
              leading: IconButton(
                icon: const Icon(Icons.close, color: ColorApp.colorIcon),
                onPressed: () => Navigator.pop(context),
              ),
              title: Column(
                children: [
                  const Text(
                    'Новая категория',
                    style: TextStyle(color: ColorApp.colorText),
                  ),
                  Text(
                    provider.titleAppBar(),
                    style: const TextStyle(
                        fontSize: 12, color: ColorApp.colorText),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.check,
                    color: ColorApp.colorIcon,
                  ),
                  onPressed: () {
                    provider.onPressedAddNewCategoy();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
            body: ListView(
              children: const [
                WidgetCategory(),
                WidgetSubCategory(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class WidgetCategory extends StatelessWidget {
  const WidgetCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddCategory>(context);
    return Container(
      decoration: BoxDecoration(
        color: provider.color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            offset: Offset(2, 2), // Shadow position
          ),
        ],
      ),
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                autocorrect: false,
                enableSuggestions: false,
                cursorColor: ColorApp.colorIcon,
                style: const TextStyle(
                  color: ColorApp.colorText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 30,
                controller: provider.texEdConCategory,
                decoration: const InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  labelStyle: TextStyle(
                    color: ColorApp.colorText,
                  ),
                  counterStyle: TextStyle(
                    color: ColorApp.colorText,
                  ),
                  labelText: 'Название',
                ),
              ),
            ),
            const SizedBox(width: 20),
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: IconButton(
                  onPressed: () async {
                    final Color? color = await showModalBottomSheet(
                      context: context,
                      builder: (context) => const WidgetSelectedColor(),
                    );
                    if (color != null) {
                      provider.onPressedButtonColor(color);
                    }
                  },
                  icon: Icon(
                    Icons.brush,
                    color: provider.color,
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetSubCategory extends StatelessWidget {
  const WidgetSubCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddCategory>(context);
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: provider.color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 40),
              const Text(
                'Подкатегории',
                style: TextStyle(color: ColorApp.colorText, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(
                  Icons.add,
                  color: ColorApp.colorIcon,
                ),
                onPressed: () async {
                  final String? text = await WidgetDialogApp.dialogSubCategory(
                      null, provider.color, context);

                  if (text != null) {
                    provider.onPressedNewSubCategoru(text);
                  }
                },
              ),
            ],
          ),
        ),
        ListView.builder(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.listSubCategory.length,
          itemBuilder: (context, index) {
            return ListTile(
              trailing: IconButton(
                onPressed: () {
                  provider.onPressedDeleteSubCategory(index);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ),
              title: Text(provider.listSubCategory[index]),
              onTap: () async {
                final String? text = await WidgetDialogApp.dialogSubCategory(
                    provider.listSubCategory[index], provider.color, context);

                if (text != null) {
                  provider.onPressedEditSubcategory(text, index);
                }
              },
            );
          },
        ),
        Container(
          height: 40,
          width: double.infinity,
          decoration: BoxDecoration(
            color: provider.color,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1,
                offset: Offset(2, 2), // Shadow position
              ),
            ],
          ),
        ),
      ],
    );
  }
}
