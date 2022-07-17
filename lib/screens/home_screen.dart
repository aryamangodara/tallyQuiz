import 'package:flutter/material.dart';
import 'package:quiz/screens/attempt_screen.dart';
import 'package:quiz/screens/main_drawer.dart';
import 'package:quiz/screens/my_quiz_screen.dart';
import 'package:quiz/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  var pages = [
    const AttemptScreen(),
    const MyQuizScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(title: const Text('The Quiz App')),
      body: pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            const Color.fromRGBO(241, 241, 241, 1), //rgb(241, 241, 241)
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          pageIndex = value;
        }),
        currentIndex: pageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'My Quizes'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'create-quiz'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
