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
      yield ProfileInitial();
    } else if (event is ProfileLoginEvent) {
      yield ProfileLoginState();
    } else if (event is ProfileRegisterEvent) {
      yield ProfileRegisterState();
    }
  }
}
