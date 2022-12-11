import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  NowPlayingMovieBloc(this._getNowPlayingMovies) : super(NowPlayingMovieInitial()) {
    on<NowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMovieLoading());

      final nowPlayingMovies = await _getNowPlayingMovies.execute();

      nowPlayingMovies.fold(
        (failure) {
          emit(NowPlayingMovieError(failure.message));
        },
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(NowPlayingMovieEmpty());
          } else {
            emit(NowPlayingMovieHasData(moviesData));
          }
        },
      );
    });
  }
}
