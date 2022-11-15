import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:yulib/core/base/book_base.dart';
import 'package:yulib/core/model/book_model.dart';

class BookService implements BookBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<bool> orderBook(BookModel bookModel) async {
    try {
      if (bookModel.active) {
        User? user = firebaseAuth.currentUser;
        DocumentReference books =
            firebaseFirestore.collection("books").doc(bookModel.id);
        CollectionReference orders = firebaseFirestore.collection("orders");
        await orders.add({
          "active": true,
          "customer_id": user!.uid,
          "book_id": bookModel.id,
          "book_image": bookModel.imageURL,
          "book_name": bookModel.name,
          "ordered_date": Timestamp.now(),
          "delivery_date": "",
          "user": user.email,
        }).then((value) async {
          await books.update({"active": false, "order_id": value.id});
        });
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<BookModel>?> getBooks() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("books")
        .where("active", isEqualTo: true)
        .get();
    List<BookModel> list = [];
    for (int i = 0; i < querySnapshot.size; i++) {
      Map<String, dynamic> vendor =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      debugPrint(vendor.toString());
      list.add(BookModel.fromMap(vendor));
    }
    return list;
  }

  @override
  Future<BookModel?> getBook(String bookId) async {
    DocumentSnapshot documentSnapshot =
        await firebaseFirestore.collection("books").doc(bookId).get();
    return BookModel.fromMap(documentSnapshot.data() as Map<String, dynamic>);
  }

  @override
  Future<List<BookModel>?> getOrders() async {
    User? user = firebaseAuth.currentUser;
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("orders")
        .where("customer_id", isEqualTo: user!.uid)
        .get();
    List<BookModel> list = [];
    for (int i = 0; i < querySnapshot.size; i++) {
      Map<String, dynamic> vendor =
          querySnapshot.docs[i].data() as Map<String, dynamic>;
      debugPrint(vendor.toString());
      list.add(BookModel.fromMapForOrder(vendor));
    }
    return list;
  }
}
