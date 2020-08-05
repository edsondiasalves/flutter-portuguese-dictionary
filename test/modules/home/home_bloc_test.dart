import 'package:bloc_test/bloc_test.dart';
import 'package:portuguese_dictionary/modules/home/bloc/bloc.dart';
import 'package:test/test.dart';

void main() {
  group('HomeBloc', () {
    HomeBloc homeBloc;

    setUp(() {
      homeBloc = HomeBloc();
    });

    tearDown(() {
      homeBloc.close();
    });

    test('Initial state', () {
      expect(homeBloc.initialState, HomeInitial());
    });

    blocTest(
      'Initialize Home',
      build: () => homeBloc,
      act: (bloc) => bloc.add(HomeInitializeEvent()),
      expect: [
        HomeInitial(),
        HomeLoadingState(),
      ],
    );
  });
}
