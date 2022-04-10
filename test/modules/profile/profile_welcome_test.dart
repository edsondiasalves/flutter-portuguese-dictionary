import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/profile/profile.dart';

class ProfileBlockMock extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

void main() {
  late ProfileBloc profileBloc;
  late ProfileState profileState;
  setUp(() {
    profileBloc = ProfileBlockMock();
    profileState = ProfileInitial();

    whenListen(
      profileBloc,
      Stream.fromIterable([profileState]),
      initialState: profileState,
    );
  });

  tearDown(() {
    profileBloc.close();
  });

  group('Profile Welcome', () {
    testWidgets('Shows the welcome page', (WidgetTester tester) async {
      //Arrange
      await _pumpProfileWelcomeWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Dicionário Português'), findsOneWidget);
      expect(find.text('Brasil vs Portugal'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);
      expect(find.text('Quick login with Touch ID'), findsOneWidget);
    });

    testWidgets('Should go to the login page', (WidgetTester tester) async {
      //Arrange
      await _pumpProfileWelcomeWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      //Assert
      expect(profileBloc.state, profileState);
    });

    testWidgets('Should go to the register page', (WidgetTester tester) async {
      //Arrange
      await _pumpProfileWelcomeWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      //Assert
      expect(profileBloc.state, profileState);
    });
  });
}

Future _pumpProfileWelcomeWidget(
    WidgetTester tester, ProfileBloc profileBloc) async {
  await tester.pumpWidget(
    BlocProvider.value(
      value: profileBloc,
      child: MaterialApp(
        home: Scaffold(
          body: ProfileWelcome(),
        ),
      ),
    ),
  );
}
