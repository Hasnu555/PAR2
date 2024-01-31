// import 'package:flutter/material.dart';
// import 'package:derviza_app/pages/mylist.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group('end-to-end test', () {
//     testWidgets('tap on the list item, verify details',
//         (WidgetTester tester) async {
//       // Load app widget.
//       await tester.pumpWidget( StudentListApp());

//       // Verify the presence of the first item.
//       expect(find.text('Name: John Doe'), findsOneWidget);

//       // Tap on the first list item.
//       await tester.tap(find.text('Name: John Doe'));
      
//       // Trigger a frame.
//       await tester.pumpAndSettle();

//       // Verify the details page.
//       expect(find.text('Name: John Doe'), findsOneWidget);
//       expect(find.text('Age: 20'), findsOneWidget);
//       expect(find.text('Percentage: 85.5%'), findsOneWidget);
//     });
//   });
// }
