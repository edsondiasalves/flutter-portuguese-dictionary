import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';
import 'package:portuguese_dictionary/services/services.dart';

class MockHomeService extends Mock implements HomeService {}

class MockDefinitionService extends Mock implements DefinitionService {}

void main() {
  MockHomeService mockHomeService;
  MockDefinitionService mockDefinitionService;
  setUp(() {
    mockHomeService = MockHomeService();
    mockDefinitionService = MockDefinitionService();

    when(mockHomeService.getHomeArticles()).thenAnswer((_) => Future.value([]));
    when(mockDefinitionService.getAllEntries())
        .thenAnswer((_) => Future.value([]));
  });

  group('Intro Widget', () {
    testWidgets('Shows the intro information', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(MaterialApp(home: Intro()));

        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Image), findsNWidgets(2));
        expect(find.text('Português do Brasil'), findsOneWidget);
        expect(find.text('Vs'), findsOneWidget);
        expect(find.text('Português de Portugal'), findsOneWidget);
      });
    });

    testWidgets('Calls multitab after intro time', (WidgetTester tester) async {
      //Arrange

      await tester.pumpWidget(
        MaterialApp(
          home: Intro(),
          routes: {
            Routes.multitab: (context) => Multitab(
                  homeService: mockHomeService,
                  definitionService: mockDefinitionService,
                ),
          },
        ),
      );

      //Act
      await tester.pump(Duration(seconds: 3));

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
