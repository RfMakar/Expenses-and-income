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
              title: Column(
                children: [
                  const Text(
                    'Новая категория',
                    style: TextStyle(
                      color: ColorApp.colorText,
                    ),
                  ),
                  Text(
                    provider.titleAppBar(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorApp.colorText,
                    ),
                  ),
                ],
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: ColorApp.colorIcon,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              backgroundColor: provider.color,
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check,
                      color: ColorApp.colorIcon,
                    ))
              ],
            ),
            body: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: provider.color,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  height: 120,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 20),
                        const Expanded(
                          child: TextField(
                            cursorColor: ColorApp.colorIcon,
                            style: TextStyle(
                              color: ColorApp.colorText,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.sentences,
                            maxLength: 30,
                            //controller: textController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelStyle: TextStyle(color: ColorApp.colorText),
                              labelText: 'Название',
                              // errorText: validate ? 'Введите категорию' : null,
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
                                  builder: (context) =>
                                      const WidgetSelectedColor(),
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
                ),
                const SubCategory(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SubCategory extends StatefulWidget {
  const SubCategory({super.key});

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProviderScreenAddCategory>(context);
    return Column(
      children: [
        const SizedBox(height: 30),
        Container(
          height: 40,
          width: double.infinity,
          color: provider.color,
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
                  final String? text =
                      await WidgetDialogApp.dialogSubCategory(null, context);

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
              textColor: provider.color,
              trailing: IconButton(
                onPressed: () {
                  provider.onPressedDeleteSubCategory(index);
                },
                icon: const Icon(
                  Icons.delete,
                  //color: Colors.red,
                ),
              ),
              title: Text(provider.listSubCategory[index]),
              onTap: () async {
                final String? text = await WidgetDialogApp.dialogSubCategory(
                    provider.listSubCategory[index], context);

                if (text != null) {
                  provider.onPressedEditSubcategory(text, index);
                }
              },
            );
          },
        ),
      ],
    );
  }
}

/*
GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: provider.listSubCategory.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(provider.listSubCategory[index]),
              ),
            );
          },
        ),

*/