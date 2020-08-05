import 'package:equatable/equatable.dart';
import 'package:portuguese_dictionary/model/article.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoadedState extends HomeState {
  final List<Article> articles;

  const HomeLoadedState({this.articles});

  @override
  List<Object> get props => [articles];
}
