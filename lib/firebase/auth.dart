
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


abstract class BaseAuth {
  Future<String> signIn(String email, String password);

  // Future<String> signUp(String email, String password);
  Future<TodoAuthResult> signUp(String email, String password);

  Future<FirebaseUser> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();
}

class TodoAuthResult {
  int resultCode; // Success: 0, Fail: 1 (Temporary)
  String resultMsg;
  FirebaseUser user;
   
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }

  // Future<String> signUp(String email, String password) async {
  //   AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
  //       email: email, password: password);
  //   FirebaseUser user = result.user;
  //   return user.uid;
  // }

  Future<TodoAuthResult> signUp(String email, String password) async {
    TodoAuthResult authResult = TodoAuthResult();

    AuthResult result;
    try {
       result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on Exception catch (e) {
      print(e);
    }
    // AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)
    //                     .catchError((onError) => authResult.resultMsg = onError.toString());

    authResult.user = result.user; 
                
    return authResult;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }
}
