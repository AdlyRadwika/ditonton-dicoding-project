import 'package:dartz/dartz.dart';
import 'package:movie/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();
  Future<Either<Failure, List<Movie>>> getPopularMovies();
  Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  Future<Either<Failure, MovieDetail>> getMovieDetail(int id);
  Future<Either<Failure, List<Movie>>> getMovieRecommendations(int id);
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, String>> saveMovieWatchlist(MovieDetail movie);
  Future<Either<Failure, String>> removeMovieWatchlist(MovieDetail movie);
  Future<bool> isAddedToMovieWatchlist(int id);
  Future<Either<Failure, List<Movie>>> getWatchlistMovies();
}
