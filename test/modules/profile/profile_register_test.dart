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

  group('Profile Register', () {
    testWidgets('Shows the register page', (WidgetTester tester) async {
      //Arrange
      await _pumpProfileRegisterWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();

      //Assert
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('User name'), findsNWidgets(1));
      expect(find.text('Login'), findsNWidgets(2));
      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('Should return to the welcome page',
        (WidgetTester tester) async {
      //Arrange
      await _pumpProfileRegisterWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      //Assert
      expect(profileBloc.state, profileState);
    });

    testWidgets('Should go to the login page', (WidgetTester tester) async {
      //Arrange
      await _pumpProfileRegisterWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Already have an account ?'));
      await tester.pumpAndSettle();

      //Assert
      expect(profileBloc.state, profileState);
    });
  });
}

Future _pumpProfileRegisterWidget(
    WidgetTester tester, ProfileBloc profileBloc) async {
  await tester.pumpWidget(
    BlocProvider.value(
      value: profileBloc,
      child: MaterialApp(
        home: Scaffold(
          body: ProfileRegister(),
        ),
      ),
    ),
  );
}
