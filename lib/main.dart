import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/auth.dart';
import 'package:quiz/screens/about_us_screen.dart';
import 'package:quiz/screens/create_quiz_screen.dart';
import 'package:quiz/screens/login_screen.dart';
import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Authentication(),
        ),
      ],
      child: MaterialApp(
        title: 'Quiz aPp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          'create-quiz': (context) => const CreateQuizScreen(),
          'home': (context) => const HomeScreen(),
          'about-us': (context) => const AboutUsScreen(),
        },
        home: Consumer<Authentication>(
          builder: (context, auth, child) =>
              auth.isAuth() ? const HomeScreen() : LoginScreen(),
        ),
      ),
    );
  }
}
