import 'package:bloc_test/bloc_test.dart';
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
    testWidgets('Shows the welcome page', (WidgetTester tester) async {
      //Arrange
      when(profileBloc.state).thenAnswer((_) => ProfileInitial());

      await tester.pumpWidget(
        BlocProvider.value(
          value: profileBloc,
          child: Profile(),
        ),
      );

      //Act
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(ProfileWelcome), findsOneWidget);
    });

    testWidgets('Shows the login page', (WidgetTester tester) async {
      //Arrange
      when(profileBloc.state).thenAnswer((_) => ProfileLoginState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: profileBloc,
          child: Profile(),
        ),
      );

      //Act
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(ProfileLogin), findsOneWidget);
    });

    testWidgets('Shows the login page', (WidgetTester tester) async {
      //Arrange
      when(profileBloc.state).thenAnswer((_) => ProfileRegisterState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: profileBloc,
          child: Profile(),
        ),
      );

      //Act
      await tester.pumpAndSettle();

      //Assert
      expect(find.byType(ProfileRegister), findsOneWidget);
    });
  });
}
