import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz/models/auth.dart';

import '../models/local_storage.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    getTotalQuizAttempted();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(9)),
          child: Image.network(user.photoURL!),
        ),
        const SizedBox(height: 30),
        Text(
          'Name: ${user.displayName}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          'Email: ${user.email}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 60),
        const Text('Total Quiz Attempted'),
        Text(
          '$totalQuizAttempted',
          style: const TextStyle(color: Colors.grey, fontSize: 50),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            Provider.of<Authentication>(context, listen: false).logout();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (route) => false);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.red)),
          child: const Text('Logout'),
        ),
      ],
    ));
  }
}
