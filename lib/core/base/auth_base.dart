
import 'package:yulib/core/model/customer_model.dart';

abstract class AuthBase {
  Future<Customer?> getCurrentCustomer();
  Future<Customer?> signInWithEmailAndPassword(String email,String password);
  Future signOut();
  Future<Object?> sendPasswordResetEmail(String email);
  Future<Object?> createUserWithEmailAndPassword(String email,String password,String nameSurname);
}
