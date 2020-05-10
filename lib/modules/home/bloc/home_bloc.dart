import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => HomeInitial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is HomeInitializeEvent) {
      yield HomeLoadingState();
      await new Future.delayed(const Duration(seconds: 2));
      yield HomeLoadedState();
    }
  }
}
