import 'package:bloc_test/bloc_test.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';
import 'package:test/test.dart';

void main() {
  group('ProfileBloc', () {
    ProfileBloc profileBloc;

    setUp(() {
      profileBloc = ProfileBloc();
    });

    tearDown(() {
      profileBloc.close();
    });

    test('Initial state', () {
      expect(profileBloc.initialState, ProfileInitial());
    });

    blocTest(
      'Initialize Profile',
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileInitializeEvent()),
      expect: [
        ProfileInitial(),
      ],
    );

    blocTest(
      'On login event',
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileLoginEvent()),
      expect: [
        ProfileInitial(), ProfileLoginState(),
      ],
    );

    blocTest(
      'On register event',
      build: () => profileBloc,
      act: (bloc) => bloc.add(ProfileRegisterEvent()),
      expect: [
        ProfileInitial(), ProfileRegisterState(),
      ],
    );
  });
}
