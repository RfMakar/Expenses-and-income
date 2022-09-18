class ShopList {
  final String nameList;
  final String nameProduct;
  final int isSelected;

  ShopList({
    required this.nameList,
    required this.nameProduct,
    required this.isSelected,
  });

  factory ShopList.fromMap(Map<String, dynamic> json) => ShopList(
        nameList: json['nameList'],
        nameProduct: json['nameProduct'],
        isSelected: json['isSelected'],
      );

  //Для записи в БД
  Map<String, dynamic> toMap() => {
        'nameList': nameList,
        'nameProduct': nameProduct,
        'isSelected': isSelected,
      };
}
