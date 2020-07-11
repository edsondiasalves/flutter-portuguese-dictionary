import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileInitializeEvent extends ProfileEvent {
  @override
  List<Object> get props => [null];
}
