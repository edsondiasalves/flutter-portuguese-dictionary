import 'dart:async';

import 'package:bloc/bloc.dart';

import 'bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  @override
  ProfileState get initialState => ProfileInitial();

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileInitializeEvent) {
      yield ProfileLoadingState();
      await new Future.delayed(const Duration(seconds: 2));
      yield ProfileLoadedState();
    }
  }
}
