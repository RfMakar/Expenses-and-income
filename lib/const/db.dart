class DBTable {
  static const finance = 'finance';
  static const categories = 'categories';
  static const subcategories = 'subcategories';
  static const operations = 'operations';
}

class DBTableFinance {
  static String createTable() => '''
    CREATE TABLE ${DBTable.finance}(
    id INTEGER PRIMARY KEY NOT NULL,
    name TEXT NOT NULL
    );
    ''';
  static String insertTable() => '''
     INSERT INTO ${DBTable.finance}(id, name) VALUES
    (0, 'Расход'),
    (1, 'Доход'); 
    ''';
}

class DBTableCategories {
  static String createTable() => '''
    CREATE TABLE ${DBTable.categories}(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idfinance INTEGER REFERENCES operations (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL,
    color TEXT NOT NULL
    );
    ''';
  static String insertTable() => '''
    INSERT INTO ${DBTable.categories}(idfinance, name, color) VALUES
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
    FROM ${DBTable.categories} 
    WHERE id = ?;
    ''';
  static String updateName() => '''
    UPDATE ${DBTable.categories} 
    SET name = ?
    WHERE id = ?;
    ''';
  static String updateColor() => '''
    UPDATE ${DBTable.categories} 
    SET color = ?
    WHERE id = ?;
    ''';

  static String getList() => '''
    SELECT id, name, color
    FROM ${DBTable.categories}
    WHERE idfinance = ?
    ORDER BY id DESC
    ;
    ''';
}

class DBTableSubCategories {
  static String createTable() => '''
    CREATE TABLE ${DBTable.subcategories}(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idcategories INTEGER REFERENCES categories (id) ON DELETE CASCADE NOT NULL,
    name TEXT NOT NULL
    );
    ''';
  static String insertTable() => '''
    INSERT INTO ${DBTable.subcategories}(idcategories, name) VALUES
    (1, 'ТО'),
    (1, 'Бензин'),
    (1, 'Запчасти'),
    (1, 'Мойка'); 
    ''';
  static String deletedSubCategories() => '''
    DELETE
    FROM ${DBTable.subcategories} 
    WHERE id = ?;
    ''';
  static String updateName() => '''
    UPDATE ${DBTable.subcategories} 
    SET name = ?
    WHERE id = ?;
    ''';
  static String getList() => '''
      SELECT id, name
      FROM ${DBTable.subcategories}
      WHERE idcategories = ?
      ORDER BY id DESC
      ;
        ''';
}

class DBTableOperations {
  static String createTable() => '''
    CREATE TABLE ${DBTable.operations} (
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    idsubcategories INTEGER REFERENCES subcategories (id) ON DELETE CASCADE NOT NULL,
    date TEXT NOT NULL,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    day INTEGER NOT NULL,
    value REAL NOT NULL,
    note TEXT NOT NULL
    );
    ''';
}

class DBTableHistoryOperations {
  static String getList() => '''
      SELECT ${DBTable.operations}.id AS idoperations,
      ${DBTable.categories}.name AS namecategories,
      ${DBTable.subcategories}.name AS namesubcategories,
      date,
      value
      FROM ${DBTable.operations}
      JOIN ${DBTable.categories} ON ${DBTable.categories}.id = ${DBTable.subcategories}.idcategories
      JOIN ${DBTable.subcategories} ON  ${DBTable.subcategories}.id = ${DBTable.operations}.idsubcategories
      
      WHERE year = ? AND month = ?  
      ;
        ''';
}

/*

  final int idoperations;
  final String namecategories;
  final String namesubcategories;
  final String date;
  final double value;
  final String color;
*/