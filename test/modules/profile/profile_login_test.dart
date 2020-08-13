import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';
import 'package:portuguese_dictionary/modules/profile/profile.dart';

class ProfileBlockMock extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

void main() {
  ProfileBloc profileBloc;

  setUp(() {
    profileBloc = ProfileBlockMock();
  });

  tearDown(() {
    profileBloc.close();
  });

  group('Profile Login', () {
    testWidgets('Shows the login page', (WidgetTester tester) async {
      //Arrange
      when(profileBloc.state).thenAnswer((_) => ProfileInitial());

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
      when(profileBloc.state).thenAnswer((_) => ProfileInitial());

      await _pumpProfileLoginWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      //Assert
      verify(profileBloc.add(ProfileInitializeEvent())).called(1);
    });

    testWidgets('Should go to the register page', (WidgetTester tester) async {
      //Arrange
      when(profileBloc.state).thenAnswer((_) => ProfileInitial());

      await _pumpProfileLoginWidget(tester, profileBloc);

      //Act
      await tester.pumpAndSettle();
      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      //Assert
      verify(profileBloc.add(ProfileRegisterEvent())).called(1);
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
