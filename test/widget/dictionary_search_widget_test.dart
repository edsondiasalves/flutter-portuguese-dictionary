import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/main.dart';
import 'package:portuguese_dictionary/service/definition_service.dart';
import 'package:portuguese_dictionary/widget/bloc/bloc.dart';

void main() {
  group('Dictionary Search Widget', () {
    SearchBloc bloc;

    setUp(() {
      bloc = SearchBloc(definitionService: DefinitionService());
    });

    testWidgets('Shows a loading', (WidgetTester tester) async {
      await tester.pumpWidget(BlocProvider.value(
        value: bloc,
        child: MyApp(),
      ));

      final scaffold = find.byType(Scaffold);

      expect(scaffold, findsOneWidget);
    });
  });
}
