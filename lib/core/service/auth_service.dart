import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yulib/core/base/auth_base.dart';
import 'package:yulib/core/model/customer_model.dart';

class AuthService implements AuthBase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<Customer?> getCurrentCustomer() async {
    try {
      User? user = firebaseAuth.currentUser;

      if (user != null) {
        CollectionReference customer =
            firebaseFirestore.collection("customers");
        DocumentSnapshot documentSnapshot = await customer.doc(user.uid).get();

        if (documentSnapshot.exists) {
          Map map = documentSnapshot.data() as Map;
          return Customer(
            uid: user.uid,
            email: user.email!,
            nameSurname: map["name_surname"],
          );
        }
      }
      return null;
    } catch (e) {
      debugPrint(
        "AuthService - Exception - Get Current Customer : ${e.toString()}",
      );
      return null;
    }
  }

  @override
  Future<Customer?> signInWithEmailAndPassword(String email, String password) async {
    var asd = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    debugPrint(asd.toString());
    return getCurrentCustomer();
  }

  @override
  Future signOut() async {
    await firebaseAuth.signOut();
  }
}
