import 'package:flutter/material.dart';
import 'ReusableWidgets/NeuAppBar.dart';

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
      home: const MyHomePage(title: 'Neu News'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  // List<Widget> pageList = [
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: neuBar('Neu News'),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You Should NOT see this page.',
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) => setState(() {
                _currentIndex = value;
              }),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.edit_document),
                label: "Suggestions",
                backgroundColor: Colors.amber),
            BottomNavigationBarItem(
                icon: Icon(Icons.gamepad),
                label: "Clubs",
                backgroundColor: Colors.amber),
            BottomNavigationBarItem(
                icon: Icon(Icons.house),
                label: "Home",
                backgroundColor: Colors.amber),
            BottomNavigationBarItem(
                icon: Icon(Icons.newspaper),
                label: "News",
                backgroundColor: Colors.amber),
          ]),
      // body: pageList.elementAt(_currentIndex),
    );
  }
}
