import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/repositories/movie/movie_repository.dart';

class RemoveMovieWatchlist {
  final MovieRepository repository;

  RemoveMovieWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.removeMovieWatchlist(movie);
  }
}
