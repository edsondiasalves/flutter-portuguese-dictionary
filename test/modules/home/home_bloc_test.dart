import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:portuguese_dictionary/model/model.dart';
import 'package:portuguese_dictionary/modules/home/bloc/bloc.dart';
import 'package:portuguese_dictionary/services/home_service.dart';
import 'package:test/test.dart';

class HomeServiceMock extends Mock implements HomeService {
  @override
  Future<List<Article>> getHomeArticles() async =>
      super.noSuchMethod(Invocation.method(#getHomeArticles, []), returnValue: [Article()]);
}

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    HomeService homeService;

    setUp(() {
      homeService = HomeServiceMock();
      when(homeService.getHomeArticles()).thenAnswer((_) => Future.value([]));
      homeBloc = HomeBloc(homeService: homeService);
    });

    tearDown(() {
      homeBloc.close();
    });

    blocTest(
      'Initialize Home',
      build: () => homeBloc,
      act: (dynamic bloc) => bloc.add(HomeInitializeEvent()),
      expect: () => [HomeLoadingState(), HomeLoadedState(articles: [])],
    );
  });
}
