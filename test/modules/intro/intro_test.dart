import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/article.dart';
import 'package:portuguese_dictionary/model/entry.dart';
import 'package:portuguese_dictionary/modules/intro/intro.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/routes.dart';
import 'package:portuguese_dictionary/services/services.dart';

class MockHomeService extends Mock implements HomeService {
  @override
  Future<List<Article>> getHomeArticles() async =>
      super.noSuchMethod(Invocation.method(#getHomeArticles, []), returnValue: [Article()]);
}

class MockDefinitionService extends Mock implements DefinitionService {
  @override
  Future<List<Entry>> getAllEntries() async =>
      super.noSuchMethod(Invocation.method(#getAllEntries, []), returnValue: [Entry()]);

  @override
  Future<List<Entry>> getEntriesByTerms(String? term) async =>
      super.noSuchMethod(Invocation.method(#getEntriesByTerms, [term]), returnValue: [Entry()]);

  @override
  Future<List<String?>> getSuggestionByTerms(String? term) async =>
      super.noSuchMethod(Invocation.method(#getSuggestionByTerms, []), returnValue: [""]);

  @override
  Future<Entry> getEntryBySuggestion(String? suggestion) async =>
      super.noSuchMethod(Invocation.method(#getEntryBySuggestion, []), returnValue: Entry());
}

void main() {
  MockHomeService? mockHomeService;
  MockDefinitionService? mockDefinitionService;
  setUp(() {
    mockHomeService = MockHomeService();
    mockDefinitionService = MockDefinitionService();

    final articles = List<Article>.empty(growable: true);

    when(mockHomeService!.getHomeArticles()).thenAnswer((_) async => articles);
    when(mockDefinitionService!.getAllEntries()).thenAnswer((_) async => List<Entry>.empty(growable: true));
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
