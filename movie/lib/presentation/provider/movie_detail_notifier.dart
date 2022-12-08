import 'package:movie/movie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieDetailNotifier extends ChangeNotifier {
  static const movieWatchlistAddSuccessMessage = 'Added to Watchlist';
  static const movieWatchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetMovieWatchlistStatus getMovieWatchlistStatus;
  final SaveMovieWatchlist saveMovieWatchlist;
  final RemoveMovieWatchlist removeMovieWatchlist;

  MovieDetailNotifier({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getMovieWatchlistStatus,
    required this.saveMovieWatchlist,
    required this.removeMovieWatchlist,
  });

  late MovieDetail _movie;
  MovieDetail get movie => _movie;

  RequestState _movieState = RequestState.Empty;
  RequestState get movieState => _movieState;

  List<Movie> _movieRecommendations = [];
  List<Movie> get movieRecommendations => _movieRecommendations;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedToMovieWatchlist = false;
  bool get isAddedToMovieWatchlist => _isAddedToMovieWatchlist;

  Future<void> fetchMovieDetail(int id) async {
    _movieState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getMovieDetail.execute(id);
    final recommendationResult = await getMovieRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _movieState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (movie) {
        _recommendationState = RequestState.Loading;
        _movie = movie;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (movies) {
            _recommendationState = RequestState.Loaded;
            _movieRecommendations = movies;
          },
        );
        _movieState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addMovieWatchlist(MovieDetail movie) async {
    final result = await saveMovieWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadMovieWatchlistStatus(movie.id);
  }

  Future<void> removeFromMovieWatchlist(MovieDetail movie) async {
    final result = await removeMovieWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadMovieWatchlistStatus(movie.id);
  }

  Future<void> loadMovieWatchlistStatus(int id) async {
    final result = await getMovieWatchlistStatus.execute(id);
    _isAddedToMovieWatchlist = result;
    notifyListeners();
  }
}
