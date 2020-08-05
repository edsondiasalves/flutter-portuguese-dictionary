import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/article.dart';
import 'package:portuguese_dictionary/modules/home/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/home/home.dart';

class HomeBlockMock extends MockBloc<HomeEvent, HomeState> implements HomeBloc {
}

void main() {
  HomeBloc homeBloc;
  const ASSET_FLAG_NAME = 'assets/images/br_flag.png';

  setUp(() {
    homeBloc = HomeBlockMock();
  });

  tearDown(() {
    homeBloc.close();
  });

  group('Home Widget', () {
    testWidgets('Shows the home loading indicator',
        (WidgetTester tester) async {
      //Arrange
      when(homeBloc.state).thenAnswer((_) => HomeLoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: homeBloc,
          child: Home(),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Shows the home articles', (WidgetTester tester) async {
      //Arrange
      when(homeBloc.state).thenAnswer((_) => HomeLoadedState(
            articles: [
              Article(imageUrl: ASSET_FLAG_NAME, title: 'b', content: 'c'),
              Article(imageUrl: ASSET_FLAG_NAME, title: 'b', content: 'c'),
            ],
          ));

      await tester.pumpWidget(
        BlocProvider.value(
          value: homeBloc,
          child: Home(),
        ),
      );

      //Act
      await tester.pump();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
