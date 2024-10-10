import 'package:books_app/models/GBook.dart';

class GBookList {
  int? totalItems;
  List<GBook>? items;

  GBookList({this.totalItems, this.items});

  GBookList.fromJson(Map<String, dynamic> json) {
    print('GBoGBookList fromJson');

    try {
      totalItems = json['totalItems'];
      if (json['items'] != null) {
            items = <GBook>[];
            json['items'].forEach((v) {
              items!.add(new GBook.fromJson(v));
            });
          }
    } catch (e) {
      print(e);
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'GBookList{totalItems: $totalItems, items: $items}';
  }
}