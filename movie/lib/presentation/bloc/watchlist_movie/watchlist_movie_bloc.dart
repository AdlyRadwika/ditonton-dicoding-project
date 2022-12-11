import 'package:movie/movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final SaveMovieWatchlist _saveWatchlist;
  final RemoveMovieWatchlist _removeWatchlist;
  final GetMovieWatchlistStatus _getWatchListStatus;
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistMovieBloc(this._saveWatchlist, this._removeWatchlist, this._getWatchListStatus, this._getWatchlistMovies) : super(WatchlistMovieInitial()) {
    on<SaveWatchlistMovie>((event, emit) async {
      emit(SaveWatchlistMovieLoading());
      final result = await _saveWatchlist.execute(event.movieDetail);

      result.fold(
        (failure) {
          emit(SaveWatchlistMovieError(failure.message));
        },
        (movieData) {
          emit(SaveWatchlistMovieSuccess(movieData));
          emit(GetWatchlistMovieStatusData(true));
        },
      );
    });

    on<RemoveWatchlistMovie>((event, emit) async {
        emit(RemoveWatchlistMovieLoading());
        final result = await _removeWatchlist.execute(event.movieDetail);

        result.fold(
          (failure) {
            emit(RemoveWatchlistMovieError(failure.message));
          },
          (movieData) {
            emit(RemoveWatchlistMovieSuccess(movieData));
            emit(GetWatchlistMovieStatusData(false));
          },
        );
      });
    
    on<GetWatchlistMovieStatus>((event, emit) async {
      emit(GetWatchlistMovieStatusLoading());

      final result = await _getWatchListStatus.execute(event.idMovie);

      emit(GetWatchlistMovieStatusData(result));
    });

    on<GetWatchlistMovie>((event, emit) async {
      emit(GetWatchlistMovieLoading());

      final watchlistMovie = await _getWatchlistMovies.execute();

      watchlistMovie.fold(
        (failure) {
          emit(GetWatchlistMovieError(failure.message));
        },
        (moviesData) {
          if (moviesData.isEmpty) {
            emit(GetWatchlistMovieEmpty());
          } else {
            emit(GetWatchlistMovieHasData(moviesData));
          }
        },
      );
    });
  }
}