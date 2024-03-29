
import 'package:flutter/material.dart';
import 'package:yulib/core/base/auth_base.dart';
import 'package:yulib/core/model/customer_model.dart';
import 'package:yulib/core/service/auth_service.dart';
import 'package:yulib/locator.dart';

enum AuthProcess {
  idle,
  busy,
}
enum AuthState {
  authorized,
  signIn,
  landing,
  signUp,
  forgot,
}

class AuthView with ChangeNotifier implements AuthBase {
  AuthProcess _authProcess = AuthProcess.idle;
  AuthState _authState = AuthState.landing;
  AuthService authService = locator<AuthService>();
  Customer? customer;

  AuthProcess get authProcess => _authProcess;

  set authProcess(AuthProcess value) {
    _authProcess = value;
    notifyListeners();
  }
  AuthState get authState => _authState;

  set authState(AuthState value) {
    _authState = value;
    notifyListeners();
  }

  AuthView() {
    getCurrentCustomer();
  }

  @override
  Future<Customer?> getCurrentCustomer() async {
    try {
      authProcess = AuthProcess.busy;
      customer = await authService.getCurrentCustomer();
      await Future.delayed(const Duration(seconds: 2)); //TODO
      if(customer != null){
        authState = AuthState.authorized;
      }else{
        authState = AuthState.signIn;
      }
      debugPrint(
        "AuthView - Current Customer : $customer",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - Get Current Customer : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return customer;
  }

  @override
  Future<Customer?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      authProcess = AuthProcess.busy;
      var res = await authService.signInWithEmailAndPassword(email, password);
      if(res is Customer){
        customer = res;
        if(customer != null){
          authState = AuthState.authorized;
        }
        debugPrint(
          "AuthView - signInWithEmailAndPassword : $customer",
        );
      }else{
        return res;
      }
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signInWithEmailAndPassword : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return customer;
  }

  @override
  Future signOut() async {
    try {
      authProcess = AuthProcess.busy;
      await authService.signOut();
      customer = null;
      authState = AuthState.signIn;
      debugPrint(
        "AuthView - signOut : $customer",
      );
    } catch (e) {
      debugPrint(
        "AuthView - Exception - signOut : ${e.toString()}",
      );
    } finally {
      authProcess = AuthProcess.idle;
    }
    return customer;
  }

  @override
  Future<Object?> createUserWithEmailAndPassword(String email, String password, String nameSurname) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.createUserWithEmailAndPassword( email,  password,  nameSurname);
      if(result is Customer){
        customer = result;
        authState = AuthState.authorized;
      }else{
        return result;
      }
      debugPrint(
        "AuthView - createUserWithEmailAndPassword : $customer",
      );
      return null;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - createUserWithEmailAndPassword : ${e.toString()}",
      );
      return null;
    } finally {
      authProcess = AuthProcess.idle;
    }

  }

  @override
  Future<Object?> sendPasswordResetEmail(String email) async {
    try {
      authProcess = AuthProcess.busy;
      var result = await authService.sendPasswordResetEmail( email);
      if(result is bool){
        return true;
      }else{
        return result;
      }
      return null;
    } catch (e) {
      debugPrint(
        "AuthView - Exception - createUserWithEmailAndPassword : ${e.toString()}",
      );
      return null;
    } finally {
      authProcess = AuthProcess.idle;
    }

  }
}
