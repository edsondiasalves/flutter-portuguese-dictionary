import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/modules/home/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/home/home.dart';

class HomeBlockMock extends MockBloc<HomeEvent, HomeState> implements HomeBloc {
}

void main() {
  HomeBloc homeBloc;

  setUp(() {
    homeBloc = HomeBlockMock();
  });

  tearDown(() {
    homeBloc.close();
  });

  group('Home Widget', () {
    testWidgets('Shows the home tab', (WidgetTester tester) async {
      //Arrange
      when(homeBloc.state).thenAnswer((_) => HomeLoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: homeBloc,
          child: Home(),
        ),
      );

      //Act
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byKey(Key('Home_Initializing')), findsOneWidget);
    });
  });
}
