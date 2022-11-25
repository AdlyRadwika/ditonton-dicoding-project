import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/repositories/tv/tv_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetOnTheAirTVs {
  final TvRepository repository;

  GetOnTheAirTVs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getOnTheAirTVs();
  }
}
