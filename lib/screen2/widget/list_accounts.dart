import 'package:budget/model/account.dart';
import 'package:budget/repository/db_finance.dart';
import 'package:flutter/material.dart';

class WidgetListAccounts extends StatelessWidget {
  const WidgetListAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SizedBox(
        height: 80,
        child: FutureBuilder<List<Account>>(
          future: DBFinance.getListAccounts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: CircularProgressIndicator());
            }
            final listAccounts = snapshot.data!;

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listAccounts.length,
              itemBuilder: (context, index) {
                final accounts = listAccounts[index];
                return InkWell(
                  onTap: () {},
                  child: Container(
                      //width: 90,
                      constraints: const BoxConstraints(minWidth: 90),
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Color(int.parse(accounts.color))),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Color(int.parse(accounts.color)),
                            blurRadius: 1,
                            offset: const Offset(0.5, 0.5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            constraints: const BoxConstraints(minWidth: 90),
                            decoration: BoxDecoration(
                                color: Color(int.parse(accounts.color)),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6))),
                            child: Center(
                              child: Text(accounts.name),
                            ),
                          ),
                          Expanded(
                              child: Center(child: Text('${accounts.value} Р')))
                        ],
                      )),
                );
              },
            );
          },
        ),
      );
    });
  }
}
