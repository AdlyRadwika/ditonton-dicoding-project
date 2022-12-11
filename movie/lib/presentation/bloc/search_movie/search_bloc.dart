// ignore_for_file: unused_field

import 'package:bloc/bloc.dart';
import 'package:movie/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchMovieBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;


  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchMovieBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
  
      emit(SearchLoading());
      final result = await _searchMovies.execute(query);
  
      result.fold(
        (failure) {
          emit(SearchError(failure.message));
        },
        (data) {
          emit(SearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnQueryEmpty>((event, emit) async {
  
      emit(SearchEmpty());

    });
    
  }
}
