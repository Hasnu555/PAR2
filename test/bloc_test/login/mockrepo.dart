// File: mock_login_repo.dart
import 'package:derviza_app/bloc/login/login_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUserCredential extends Mock implements UserCredential {}
class MockUser extends Mock implements User {}
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}
class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}

class MockLoginRepository implements LoginRepository {
  final MockFirebaseAuth mockFirebaseAuth = MockFirebaseAuth();
  final MockGoogleSignIn mockGoogleSignIn = MockGoogleSignIn();

  @override
  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    if (email == 'hasnu@gmail.com' && password == '123456') {
      var mockUserCredential = MockUserCredential();
      var mockUser = MockUser();

      when(mockUser.email).thenReturn(email);
      when(mockUser.uid).thenReturn('some-unique-id');
      when(mockUserCredential.user).thenReturn(mockUser);

      return mockUserCredential;
    } else {
      throw FirebaseAuthException(
        code: 'wrong-password',
        message: 'Wrong password provided for that user.'
      );
    }
  }
  @override
  Future<UserCredential> signInWithGoogle() async {
    // Simulate Google Sign-In
    var mockGoogleSignInAccount = MockGoogleSignInAccount();
    var mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    
    when(mockGoogleSignIn.signIn()).thenAnswer((_) async => mockGoogleSignInAccount);
    when(mockGoogleSignInAccount.authentication).thenAnswer((_) async => mockGoogleSignInAuthentication);
    when(mockGoogleSignInAuthentication.accessToken).thenReturn('mock_access_token');
    when(mockGoogleSignInAuthentication.idToken).thenReturn('mock_id_token');

    var mockUserCredential = MockUserCredential();
    var mockUser = MockUser();
    when(mockUser.email).thenReturn('googleuser@example.com');
    when(mockUser.uid).thenReturn('google-unique-id');
    when(mockUserCredential.user).thenReturn(mockUser);

    return mockUserCredential;
  }

  @override
  Future<void> signOut() async {
    // Simulate sign out
    return Future.value();
  }
}
