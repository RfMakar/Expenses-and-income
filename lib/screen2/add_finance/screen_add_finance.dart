import 'package:budget/screen2/const/const_color.dart';
import 'package:flutter/material.dart';

import '../../model/category.dart';

class ScreenAddFinace extends StatelessWidget {
  const ScreenAddFinace({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: category.colorCategory(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorApp.colorIcon),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          category.name,
          style: const TextStyle(color: ColorApp.colorText),
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}

class WidgetTitle extends StatelessWidget {
  const WidgetTitle({super.key, required this.category});
  final Category category;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: category.colorCategory(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.close),
          ),
          Text(
            category.name,
            style: TextStyle(fontSize: 20, color: ColorApp.colorText),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}

class WidgetListSubcategory extends StatelessWidget {
  const WidgetListSubcategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 80),
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: [
        TextField(),
      ],
    );
  }
}
