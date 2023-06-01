import 'package:budget/model/category.dart';
import 'package:budget/screen2/add_category/screen_add_categoty.dart';
import 'package:budget/screen2/home/provider_screen_home.dart';
import 'package:budget/screen2/sub_category/screen_sub_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderScreenHome(),
      builder: (context, child) => Consumer<ProviderScreenHome>(
        builder: (context, provider, _) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenAddCategory(
                      isSelectedBudget: provider.isSelectedBudget,
                    ),
                  ),
                );
                provider.sceenUpdate();
              },
              child: const Icon(Icons.add),
            ),
            appBar: AppBar(
              title: const Text('budget'),
            ),
            body: FutureBuilder<List<Category>>(
              future: provider.getListFinance(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: CircularProgressIndicator());
                }
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    final category = snapshot.data![index];
                    return WidgetCardCategory(category: category);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class WidgetCardCategory extends StatelessWidget {
  const WidgetCardCategory({super.key, required this.category});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScreenSubCategory(category: category),
          ),
        );
        // showModalBottomSheet(
        //     context: context,
        //     builder: (context) {
        //       return ScreenSubCategory(
        //         category: category,
        //       );
        //     });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(int.parse(category.color)),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category.name,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              '${category.percent} %',
              style: const TextStyle(fontSize: 16),
            ),
            Text('${category.value} руб'),
          ],
        ),
      ),
    );
  }
}

/*
InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return ScreenSubCategory(
                category: category,
              );
            });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color(int.parse(category.color)),
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              category.name,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              '${category.percent} %',
              style: const TextStyle(fontSize: 16),
            ),
            Text('${category.value} руб'),
          ],
        ),
      ),
    );

*/