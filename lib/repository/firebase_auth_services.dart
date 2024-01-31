import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthServices {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signupwithEmailAndPassword(String email, String password) async {
  try {
    UserCredential credential = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);
    User? user = credential.user;
    return user;
  } catch (e) {
    print("Some error occured");
    
  }
  return null;
}

Future<User?> signInwithEmailAndPassword(String email, String password) async {
  try {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
      email: email, password: password);
    User? user = credential.user;
    return user;
  } catch (e) {
    print("Some error occured");
    
  }
  return null;
}

}



