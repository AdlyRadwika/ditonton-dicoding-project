import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
        required this.genres,
        required this.id,
        required this.name,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.overview,
        required this.posterPath,
        required this.voteAverage,
  });

    final List<Genre> genres;
    final int id;
    final String name;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final String overview;
    final String posterPath;
    final double voteAverage;

  @override
  List<Object?> get props => [
        genres,
        id,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        overview,
        posterPath,
        voteAverage,
      ];
}
