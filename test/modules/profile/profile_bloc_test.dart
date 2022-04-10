import 'package:bloc_test/bloc_test.dart';
import 'package:portuguese_dictionary/modules/profile/bloc/bloc.dart';
import 'package:test/test.dart';

void main() {
  group('ProfileBloc', () {
    late ProfileBloc profileBloc;

    setUp(() {
      profileBloc = ProfileBloc();
    });

    tearDown(() {
      profileBloc.close();
    });

    blocTest(
      'Initialize Profile',
      build: () => profileBloc,
      act: (dynamic bloc) => bloc.add(ProfileInitializeEvent()),
      expect: () => [
        ProfileInitial(),
      ],
    );

    blocTest(
      'On login event',
      build: () => profileBloc,
      act: (dynamic bloc) => bloc.add(ProfileLoginEvent()),
      expect: () => [
        ProfileLoginState(),
      ],
    );

    blocTest(
      'On register event',
      build: () => profileBloc,
      act: (dynamic bloc) => bloc.add(ProfileRegisterEvent()),
      expect: () => [
        ProfileRegisterState(),
      ],
    );
  });
}
