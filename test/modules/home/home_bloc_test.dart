import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/modules/home/bloc/bloc.dart';
import 'package:portuguese_dictionary/services/home_service.dart';
import 'package:test/test.dart';

class HomeServiceMock extends Mock implements HomeService {}

void main() {
  group('HomeBloc', () {
    HomeBloc homeBloc;
    HomeService homeService;

    setUp(() {
      homeService = HomeServiceMock();
      when(homeService.getHomeArticles()).thenAnswer((_) => Future.value([]));
      homeBloc = HomeBloc(homeService: homeService);
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
        HomeLoadedState(articles: [])
      ],
    );
  });
}
