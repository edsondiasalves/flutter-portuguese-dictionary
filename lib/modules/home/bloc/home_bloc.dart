import 'package:bloc/bloc.dart';
import 'package:portuguese_dictionary/services/home_service.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeService? homeService;

  HomeBloc({this.homeService}) : super(HomeInitial()) {
    on<HomeInitializeEvent>((event, emit) async {
      emit(HomeLoadingState());
      final articles = await homeService!.getHomeArticles();
      emit(HomeLoadedState(articles: articles));
    });
  }
}
