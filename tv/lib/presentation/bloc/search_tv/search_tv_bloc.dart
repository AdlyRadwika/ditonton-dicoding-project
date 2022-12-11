import 'package:bloc/bloc.dart';
import 'package:tv/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_event.dart';
part 'search_tv_state.dart';

class SearchTvBloc extends Bloc<SearchTvEvent, SearchTVState> {
  final SearchTvs _searchTvs;


  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  SearchTvBloc(this._searchTvs) : super(SearchTvEmpty()) {
    on<OnTvQueryChanged>((event, emit) async {
      final query = event.query;
  
      emit(SearchTvLoading());
      final result = await _searchTvs.execute(query);
  
      result.fold(
        (failure) {
          emit(SearchTvError(failure.message));
        },
        (data) {
          emit(SearchTvHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));

    on<OnTvQueryEmpty>((event, emit) async {
  
      emit(SearchTvEmpty());

    });
    
  }
}
