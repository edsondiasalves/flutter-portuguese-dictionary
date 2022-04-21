import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/bottom_bar.dart';
import 'package:portuguese_dictionary/model/model.dart';
import 'package:portuguese_dictionary/modules/home/home.dart';
import 'package:portuguese_dictionary/modules/modules.dart';
import 'package:portuguese_dictionary/multitab.dart';
import 'package:portuguese_dictionary/services/definition_service.dart';
import 'package:portuguese_dictionary/services/home_service.dart';

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

  group('Multitab', () {
    testWidgets('Shows the multitab widget', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Multitab(
              homeService: mockHomeService,
              definitionService: mockDefinitionService,
            ),
          ),
        );

        expect(find.byType(BottomBar), findsOneWidget);
      });
    });

    testWidgets('Loads only the first tab', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Multitab(
              homeService: mockHomeService,
              definitionService: mockDefinitionService,
            ),
          ),
        );

        expect(find.byType(BottomBar), findsOneWidget);

        expect(find.byKey(Key('offstage0')), findsOneWidget);
        expect(find.byType(Home), findsOneWidget);
        expect(find.byKey(Key('multitab_home')), findsOneWidget);

        expect(find.byKey(Key('offstage1')), findsOneWidget);
        expect(find.byType(Search), findsNothing);
        expect(find.byKey(Key('multitab_search')), findsNothing);

        expect(find.byKey(Key('offstage2')), findsOneWidget);
        expect(find.byType(Profile), findsNothing);
        expect(find.byKey(Key('multitab_profile')), findsNothing);
      });
    });

    testWidgets('Tapping on the first tab only loads the Home module', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Multitab(
              homeService: mockHomeService,
              definitionService: mockDefinitionService,
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.home));
        await tester.pump();

        expect(find.byKey(Key('offstage0')), findsOneWidget);
        expect(find.byType(Home), findsOneWidget);
        expect(find.byKey(Key('multitab_home')), findsOneWidget);

        expect(find.byKey(Key('offstage1')), findsOneWidget);
        expect(find.byType(Search), findsNothing);
        expect(find.byKey(Key('multitab_search')), findsNothing);

        expect(find.byKey(Key('offstage2')), findsOneWidget);
        expect(find.byType(Profile), findsNothing);
        expect(find.byKey(Key('multitab_profile')), findsNothing);
      });
    });

    testWidgets('Tapping on the second tab only loads the Search module', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Multitab(
              homeService: mockHomeService,
              definitionService: mockDefinitionService,
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.search));
        await tester.pump();

        expect(find.byKey(Key('offstage0')), findsOneWidget);
        expect(find.byType(Home), findsNothing);
        expect(find.byKey(Key('multitab_home')), findsNothing);

        expect(find.byKey(Key('offstage1')), findsOneWidget);
        expect(find.byType(Search), findsOneWidget);
        expect(find.byKey(Key('multitab_search')), findsOneWidget);

        expect(find.byKey(Key('offstage2')), findsOneWidget);
        expect(find.byType(Profile), findsNothing);
        expect(find.byKey(Key('multitab_profile')), findsNothing);
      });
    });

    testWidgets('Tapping on the third tab only loads the Profile module', (WidgetTester tester) async {
      //Arrange
      await tester.runAsync(() async {
        await tester.pumpWidget(
          MaterialApp(
            home: Multitab(
              homeService: mockHomeService,
              definitionService: mockDefinitionService,
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.person));
        await tester.pump();

        expect(find.byKey(Key('offstage0')), findsOneWidget);
        expect(find.byType(Home), findsNothing);
        expect(find.byKey(Key('multitab_home')), findsNothing);

        expect(find.byKey(Key('offstage1')), findsOneWidget);
        expect(find.byType(Search), findsNothing);
        expect(find.byKey(Key('multitab_search')), findsNothing);

        expect(find.byKey(Key('offstage2')), findsOneWidget);
        expect(find.byType(Profile), findsOneWidget);
        expect(find.byKey(Key('multitab_profile')), findsOneWidget);
      });
    });
  });
}
