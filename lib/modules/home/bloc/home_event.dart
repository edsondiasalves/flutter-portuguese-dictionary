import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeInitializeEvent extends HomeEvent {
  @override
  List<Object> get props => [null];
}
