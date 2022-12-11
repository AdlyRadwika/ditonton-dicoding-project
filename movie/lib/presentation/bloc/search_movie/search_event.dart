// ignore_for_file: prefer_const_constructors_in_immutables

part of 'search_bloc.dart';
 
abstract class SearchEvent extends Equatable {
  const SearchEvent();
 
  @override
  List<Object> get props => [];
}
 
class OnQueryChanged extends SearchEvent {
  final String query;
 
  OnQueryChanged(this.query);
 
  @override
  List<Object> get props => [query];
}

class OnQueryEmpty extends SearchEvent {}