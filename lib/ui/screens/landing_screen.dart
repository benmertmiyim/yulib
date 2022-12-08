import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yulib/core/view/auth_view.dart';
import 'package:yulib/ui/screens/login_screen/login_screen.dart';
import 'package:yulib/ui/screens/main_screen/main_screen.dart';
import 'package:yulib/ui/screens/register_screen/register_screen.dart';
import 'package:yulib/ui/screens/splash/splash_screen.dart';

import 'forgot_password_screen/forgot_password_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthView authView = Provider.of<AuthView>(context);

    if (authView.authState == AuthState.landing) {
      return const SplashScreen();
    } else {
       if (authView.authState == AuthState.signIn) {
        return const LoginScreen();
      } else if (authView.authState == AuthState.signUp) {
        return const RegisterScreen();
      } else if (authView.authState == AuthState.forgot) {
        return const ForgotPasswordScreen();
      } else {
        return const MainScreen();
      }
    }
  }
}
