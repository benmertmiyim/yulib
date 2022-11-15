import 'package:cloud_firestore/cloud_firestore.dart';

class BookModel {
  final String id;
  final String name;
  bool active;
  String? category;
  String? desc;
  final String imageURL;
  String? launguage;
  String? location;
  String? writer;
  int? page;
  Timestamp? orderTime;
  Timestamp? deliveryTime;

  BookModel(
      {required this.id,
      this.category,
      this.desc,
      required this.active,
      required this.imageURL,
      this.launguage,
      this.location,
      this.orderTime,
      this.deliveryTime,
      required this.name,
      this.writer,
      this.page});

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['book_id'] as String,
      category: map['category'] as String,
      imageURL: map['image_url'] as String,
      desc: map['desc'] as String,
      launguage: map['launguage'] as String,
      location: map['location'] as String,
      name: map['name'] as String,
      writer: map['writer'] as String,
      active: map['active'] as bool,
      page: map["page"].toInt(),
    );
  }
  factory BookModel.fromMapForOrder(Map<String, dynamic> map) {
    return BookModel(
      id: map['book_id'] as String,
      imageURL: map['book_image'] as String,
      name: map['book_name'] as String,
      active: map['active'] as bool,
      deliveryTime: map['delivery_date'] != "" ? map['delivery_date'] as Timestamp : map['ordered_date'] as Timestamp,
      orderTime: map['ordered_date'] as Timestamp,
    );
  }
}
