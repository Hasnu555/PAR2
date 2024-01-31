import 'package:derviza_app/screen/edit_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}
class MockFirebaseStorage extends Mock implements FirebaseStorage {}
class MockStorageReference extends Mock implements Reference {}
class MockXFile extends Mock implements XFile {}

void main() {
  group('EditProfilePage Widget Test', () {
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;
    late MockFirebaseStorage mockFirebaseStorage;
    late MockStorageReference mockStorageReference;
    late MockXFile mockXFile;

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockUser = MockUser();
      mockFirebaseStorage = MockFirebaseStorage();
      mockStorageReference = MockStorageReference();
      mockXFile = MockXFile();

      when(mockFirebaseAuth.currentUser).thenAnswer((_) => mockUser);
      when(mockUser.displayName).thenReturn('John Doe');
      when(mockUser.email).thenReturn('john.doe@example.com');
    });

    testWidgets('EditProfilePage displays correctly', (WidgetTester tester) async {
      // Build our EditProfilePage widget and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: EditProfilePage(),
        ),
      );

      // Verify that the EditProfilePage displays correctly.
      expect(find.text('Edit Profile'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Update Profile'), findsOneWidget);
    });

    testWidgets('EditProfilePage updates profile', (WidgetTester tester) async {
      // Mock FirebaseAuth to return a user.
      when(mockFirebaseAuth.currentUser).thenAnswer((_) => mockUser);

      // Mock FirebaseStorage to return a reference.
      when(mockFirebaseStorage.ref()).thenReturn(mockStorageReference);

      // Mock ImagePicker to return a file.
      // when(mockXFile.path).thenReturn('path_to_image');
      // when(mockImagePicker.pickImage(source: ImageSource.gallery)).thenAnswer((_) async => mockXFile);

      // Build our EditProfilePage widget and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: EditProfilePage(),
        ),
      );

      // Tap the "Update Profile" button.
      await tester.tap(find.text('Update Profile'));
      await tester.pump();

      // Verify that the profile update was attempted.
      verify(mockUser.updateDisplayName('John Doe')).called(1);
      verify(mockUser.updateEmail('john.doe@example.com')).called(1);
      // verifyNever(mockUser.updatePassword(any));

      // // Verify that the image was uploaded.
      // verify(mockStorageReference.child('user_images/${mockUser.uid}.jpg')).called(1);
      // verify(mockStorageReference.child('user_images/${mockUser.uid}.jpg').putFile(File('path_to_image'))).called(1);
    });
  });
}
