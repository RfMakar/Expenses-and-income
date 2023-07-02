class DBTableFinance {
  static const name = 'finance';

  static String createTable() => '''
    CREATE TABLE $name(
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
    );
    ''';
  static String insertTable() => '''
     INSERT INTO $name(id, name) VALUES
    (0, 'Расход'),
    (1, 'Доход'); 
    ''';
}

class DBTableCategories {
  static const name = 'categories';

  static String createTable() => '''
    CREATE TABLE $name(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idoperations INTEGER REFERENCES operations (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    color TEXT NOT NULL
    );
    ''';
  static String insertTable() => '''
    INSERT INTO $name(idoperations, name, color) VALUES
    (0, 'Машина','4280391411'),
    (0, 'Продукты','4288585374'),
    (0, 'Развлечения','4294198070'),
    (0, 'Спорт','4284955319'),
    (0, 'Кафе','4280391411'),
    (0, 'Подарки','4284955319'),
    (1, 'Зарплата','4288585374'),
    (1, 'Вклад','4284955319'); 
    ''';
  static String deletedCategories() => '''
    DELETE
    FROM $name 
    WHERE id = ?;
    ''';
  static String updateName() => '''
    UPDATE $name 
    SET name = ?
    WHERE id = ?;
    ''';
  static String updateColor() => '''
    UPDATE $name 
    SET color = ?
    WHERE id = ?;
    ''';

  static String getList() => '''
    SELECT id, name, color
    FROM $name
    WHERE idoperations = ?
    ORDER BY id DESC
    ;
    ''';
}

class DBTableSubCategories {
  static const name = 'subcategories';

  static String createTable() => '''
    CREATE TABLE $name(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idcategories INTEGER REFERENCES categories (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL
    );
    ''';
  static String insertTable() => '''
    INSERT INTO $name(idcategories, name) VALUES
    (1, 'ТО'),
    (1, 'Бензин'),
    (1, 'Запчасти'),
    (1, 'Мойка'); 
    ''';
  static String deletedSubCategories() => '''
    DELETE
    FROM $name 
    WHERE id = ?;
    ''';
  static String updateName() => '''
    UPDATE $name 
    SET name = ?
    WHERE id = ?;
    ''';
  static String getList() => '''
      SELECT id, name
      FROM $name
      WHERE idcategories = ?
      ORDER BY id DESC
      ;
        ''';
}




/*
class DBTableAccount {
  static const name = 'account';

  static String createTable() => '''
    CREATE TABLE $name(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT NOT NULL,
    color TEXT NOT NULL
    );
      ''';
  static String getList() => '''
      SELECT account.id, account.name, SUM(value) as value, account.color
      FROM transactions
      JOIN account ON account.id = transactions.idAccount
      GROUP BY name;
        ''';
}

*/