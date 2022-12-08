import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class SaveTvWatchlist {
  final TvRepository repository;

  SaveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveTvWatchlist(tv);
  }
}
