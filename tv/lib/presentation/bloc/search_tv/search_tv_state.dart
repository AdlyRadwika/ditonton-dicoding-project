// ignore_for_file: prefer_const_constructors_in_immutables
part of 'search_tv_bloc.dart';

abstract class SearchTVState extends Equatable {
  const SearchTVState();

  @override
  List<Object> get props => [];
}

class SearchTvEmpty extends SearchTVState {}

class SearchTvLoading extends SearchTVState {}

class SearchTvError extends SearchTVState {
  final String message;

  SearchTvError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvHasData extends SearchTVState {
  final List<Tv> result;

  SearchTvHasData(this.result);

  @override
  List<Object> get props => [result];
}
