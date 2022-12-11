// ignore_for_file: prefer_const_constructors_in_immutables

part of 'search_tv_bloc.dart';
 
abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();
 
  @override
  List<Object> get props => [];
}
 
class OnTvQueryChanged extends SearchTvEvent {
  final String query;
 
  OnTvQueryChanged(this.query);
 
  @override
  List<Object> get props => [query];
}

class OnTvQueryEmpty extends SearchTvEvent {}