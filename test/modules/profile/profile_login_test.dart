import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/profile/profile.dart';

class ProfileBlockMock extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

void main() {
  group('Profile Login', () {
    late ProfileBloc profileBloc = ProfileBlockMock();
    final profileBlocState = ProfileInitial();

    setUp(() {
      whenListen(
        profileBloc,
        Stream.fromIterable([profileBlocState]),
        initialState: profileBlocState,
      );
    });

    tearDown(() {
      profileBloc.close();
    });

    testWidgets('Shows the login page', (WidgetTester tester) async {
      //Arrange
      await _pumpProfileLoginWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Login'), findsNWidgets(2));
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('Should return to the welcome page',
        (WidgetTester tester) async {
      //Arrange
      await _pumpProfileLoginWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      //Assert
      expect(profileBloc.state, profileBlocState);
    });

    testWidgets('Should go to the register page', (WidgetTester tester) async {
      //Arrange
      await _pumpProfileLoginWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      //Assert
      expect(profileBloc.state, profileBlocState);
    });
  });
}

Future _pumpProfileLoginWidget(
    WidgetTester tester, ProfileBloc profileBloc) async {
  await tester.pumpWidget(
    BlocProvider.value(
      value: profileBloc,
      child: MaterialApp(
        home: Scaffold(
          body: ProfileLogin(),
        ),
      ),
    ),
  );
}
