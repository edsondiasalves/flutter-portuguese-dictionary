import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileInitializeEvent extends ProfileEvent {}

class ProfileLoginEvent extends ProfileEvent {}

class ProfileRegisterEvent extends ProfileEvent {}
