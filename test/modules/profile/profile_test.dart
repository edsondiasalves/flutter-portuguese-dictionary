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

  group('Profile Widget', () {
    testWidgets('Shows the Profile tab', (WidgetTester tester) async {
      //Arrange
      when(profileBloc.state).thenAnswer((_) => ProfileLoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: profileBloc,
          child: Profile(),
        ),
      );

      //Act
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byKey(Key('Profile_Initializing')), findsOneWidget);
    });
  });
}
