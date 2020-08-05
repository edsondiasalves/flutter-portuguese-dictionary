import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:portuguese_dictionary/services/home_service.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService homeService;

  HomeBloc({this.homeService});

  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeInitializeEvent) {
      yield HomeLoadingState();
      final articles = await homeService.getHomeArticles();
      yield HomeLoadedState(articles: articles);
    }
  }
}
