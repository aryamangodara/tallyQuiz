import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication extends ChangeNotifier {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle({required BuildContext context}) async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      // FirebaseAuth.instance.s
      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    notifyListeners();
    return user;
  }

  var firebaseAuth = FirebaseAuth.instance;
  bool isAuth() {
    if (firebaseAuth.currentUser != null) {
      return true;
    }
    return false;
  }

  Future logout() async {
    await googleSignIn.disconnect();
    await firebaseAuth.signOut();
    notifyListeners();
  }
}
