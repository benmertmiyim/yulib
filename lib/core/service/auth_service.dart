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

  @override
  Future<Object?> createUserWithEmailAndPassword(
      String email, String password, String nameSurname) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      CollectionReference customers = firebaseFirestore.collection("customers");
      await customers.doc(firebaseAuth.currentUser!.uid).set({
        "email": email,
        "name_surname": nameSurname,
        "registered_date": Timestamp.now(),
      });
      return getCurrentCustomer();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return null;
  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
    return false;
  }
}
