import 'package:bloc/bloc.dart';

import 'bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitializeEvent>((event, emit) async {
      emit(ProfileInitial());
    });

    on<ProfileLoginEvent>((event, emit) async {
      emit(ProfileLoginState());
    });

    on<ProfileRegisterEvent>((event, emit) async {
      emit(ProfileRegisterState());
    });
  }
}
