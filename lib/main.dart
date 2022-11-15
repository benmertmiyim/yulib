import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yulib/core/view/auth_view.dart';
import 'package:yulib/core/view/book_view.dart';
import 'package:yulib/firebase_options.dart';
import 'package:yulib/locator.dart';
import 'package:yulib/ui/screens/landing_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setUpLocator();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthView(),
        ),
        ChangeNotifierProvider(
          create: (context) => BookView(),
        ),
      ],
      child: MaterialApp(
        title: "YuLib",
        debugShowCheckedModeBanner: false,
        theme:ThemeData(fontFamily: "Baloo2"),
        home: const LandingScreen(),
      ),
    );
  }
}
