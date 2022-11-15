import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:yulib/ui/screens/main_screen/history_screen.dart';
import 'package:yulib/ui/screens/main_screen/home_screen.dart';
import 'package:yulib/ui/screens/main_screen/scanner_screen.dart';

import '../../../core/view/auth_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = const <Widget>[
    HomeScreen(),
    ScannerScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    AuthView authView = Provider.of<AuthView>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("YuLib"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authView.signOut();
            },
            icon: const Icon(
              Icons.logout,
            ),
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: primaryColor.withOpacity(.5),
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.camera,
                  text: 'Scan',
                ),
                GButton(
                  icon: LineIcons.history,
                  text: 'History',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (i) {
                setState(() {
                  _selectedIndex = i;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
