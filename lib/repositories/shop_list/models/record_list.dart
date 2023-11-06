abstract class Records {
  final String name;
  final int isselected;
  Records({required this.name, required this.isselected});
}

//Column table -> |idshoplist|name|
class WriteRecordList extends Records {
  final int idshoplist;

  WriteRecordList({
    required super.name,
    required this.idshoplist,
    required super.isselected,
  });

  //Для записи в БД
  Map<String, dynamic> toMap() {
    return {
      'idshoplist': idshoplist,
      'name': name,
      'isselected': isselected,
    };
  }
}

//Column table -> |id|name|idshoplist|
class ReadRecordList extends Records {
  final int id;
  ReadRecordList(
      {required this.id, required super.name, required super.isselected});
}

//Column table -> |id|name|idshoplist|
class RecordList extends ReadRecordList {
  RecordList(
      {required super.id, required super.name, required super.isselected});
  //Чтение БД
  factory RecordList.fromMap(Map<String, dynamic> json) => RecordList(
        id: json['id'],
        name: json['name'],
        isselected: json['isselected'],
      );
}
