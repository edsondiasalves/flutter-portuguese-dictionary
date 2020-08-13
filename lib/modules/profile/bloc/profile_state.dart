import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoginState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileRegisterState extends ProfileState {
  @override
  List<Object> get props => [];
}
