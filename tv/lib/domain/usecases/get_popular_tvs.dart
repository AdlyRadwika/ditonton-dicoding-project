import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';

class GetPopularTvs {
  final TvRepository repository;

  GetPopularTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTvs();
  }
}
