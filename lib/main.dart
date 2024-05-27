import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:neunews_flutter/Pages/Clubs.dart';
import 'package:neunews_flutter/Pages/NewsPage.dart';
import 'package:neunews_flutter/Pages/ProfilePage.dart';
import 'package:neunews_flutter/Pages/Register.dart';
import 'package:neunews_flutter/Session.dart';
import 'ReusableWidgets/NeuAppBar.dart';
import 'package:neunews_flutter/Pages/Suggestions.dart';
import 'package:neunews_flutter/Pages/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Neu News',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Neu News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title; // Make the title final

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var sessionManager = SessionManagerSingleton();
  int _currentIndex = 0;
  late bool _isLoggedIn = false;
  List<Widget> pageList = [
    Suggestions(),
    Clubs(),
    HomePage(),
    NewsPage(),
    ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? Scaffold(
            appBar: neuBar('Neu News'),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (value) {
                setState(() {
                  _currentIndex = value;
                });
                },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit_document),
                  label: "Suggestions",
                  backgroundColor: Colors.amber,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.gamepad),
                  label: "Clubs",
                  backgroundColor: Colors.amber,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.house),
                  label: "Home",
                  backgroundColor: Colors.amber,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: "News",
                  backgroundColor: Colors.amber,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: "Account",
                  backgroundColor: Colors.amber,
                ),
              ],
            ),
            body: pageList.elementAt(_currentIndex),
          )
        : const Scaffold(
            body: RegisterPage(),
          );
  }

  Future<void> fetchUser() async {
    await sessionManager.updateSession();
    var json = await sessionManager.getSessionValue('user');
    if (json.toString().isNotEmpty) {
      setState(() {
      _isLoggedIn = true;
      });
    } else {
      setState(() {
        _isLoggedIn = false;
      });
    }
  }
}
