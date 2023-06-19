abstract class DBTable {
  static const transactions = 'transactions';
  static const expenses = 'expenses';
  static const income = 'income';
}

abstract class DBSql {
  static const createTableTransaction = '''
    CREATE TABLE ${DBTable.transactions} (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idAccount INTEGER REFERENCES account (id) ON DELETE CASCADE NOT NULL,
    idSubCategories INTEGER REFERENCES subcategories (id) ON DELETE CASCADE,
    date TEXT NOT NULL,
    year REAL NOT NULL,
    month REAL NOT NULL,
    day REAL NOT NULL,
    value REAL NOT NULL,
    note TEXT
    );
      ''';
}

class DBTableAccount {
  static const name = 'account';

  static String createTable() => '''
    CREATE TABLE $name(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL,
    color TEXT NOT NULL,
    selection INTEGER NOT NULL
    );
      ''';
  static String getList() => '''
      SELECT account.id, account.name, SUM(value) as value, account.color, account.selection
      FROM transactions
      JOIN account ON account.id = transactions.idAccount
      GROUP BY name
      ORDER BY selection DESC;
        ''';
  static String updateSelection0() => 'UPDATE $name SET selection = 0;';
  static String updateSelection1() =>
      'UPDATE $name SET selection = 1 WHERE id = ?;';
}
