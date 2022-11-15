
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
  unAuthorized,
  landing,
}

class AuthView with ChangeNotifier implements AuthBase {
  AuthProcess _authProcess = AuthProcess.idle;
  AuthState authState = AuthState.landing;
  AuthService authService = locator<AuthService>();
  Customer? customer;

  AuthProcess get authProcess => _authProcess;

  set authProcess(AuthProcess value) {
    _authProcess = value;
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
        authState = AuthState.unAuthorized;
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
      customer = await authService.signInWithEmailAndPassword(email, password);
      if(customer != null){
        authState = AuthState.authorized;
      }else{
        authState = AuthState.unAuthorized;
      }
      debugPrint(
        "AuthView - signInWithEmailAndPassword : $customer",
      );
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
      authState = AuthState.unAuthorized;
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
}