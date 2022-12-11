import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail _getMovieDetail;


  MovieDetailBloc(this._getMovieDetail) : super(MovieDetailInitial()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(MovieDetailLoading());

      final detailResult = await _getMovieDetail.execute(event.idMovie);

      detailResult.fold(
        (failure) {
          emit(MovieDetailError(failure.message));
        },
        (movie) {
          emit(MovieDetailData(movie));
        },
      );
    });
  }
  }
