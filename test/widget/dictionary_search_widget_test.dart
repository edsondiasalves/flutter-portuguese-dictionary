import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/main.dart';

void main() {
  MyApp myApp;

  setUp(() {
    myApp = MyApp();
  });

  tearDown(() {
    myApp = null;
  });

  group('Dictionary Search Widget', () {
    testWidgets('Shows a loading', (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(myApp);

      //Assert
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.byType(SpinKitFadingCircle), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('Tap the action button for the first time',
        (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(myApp);

      //Act
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      //Assert
      expect(find.byType(SpinKitFadingCircle), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    testWidgets('Tap the action button for the second time',
        (WidgetTester tester) async {
      //Arrange
      await tester.pumpWidget(myApp);

      //Act
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      //Assert
      expect(find.byType(SpinKitFadingCircle), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(1));
    });
  });
}
