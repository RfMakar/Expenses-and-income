import 'package:budget/model/category.dart';
import 'package:budget/screen2/const/const_color.dart';
import 'package:flutter/material.dart';

class ScreenSubCategory extends StatelessWidget {
  const ScreenSubCategory({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(int.parse(category.color)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: ColorApp.colorIcon),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              category.name,
              style: const TextStyle(color: ColorApp.colorText),
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
              //provider.onPressedAddNewCategoy();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 90,
            width: double.infinity,
            color: Color(int.parse(category.color)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      category.name,
                      style: const TextStyle(
                          fontSize: 22, color: ColorApp.colorText),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                          onPressed: () async {},
                          icon: Icon(
                            Icons.add,
                            color: Color(int.parse(category.color)),
                          )),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      category.percentToString(),
                      style: const TextStyle(
                          fontSize: 22, color: ColorApp.colorText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
