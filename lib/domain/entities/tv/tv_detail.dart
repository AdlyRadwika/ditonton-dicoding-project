import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
        required this.adult,
        required this.backdropPath,
        required this.createdBy,
        required this.episodeRunTime,
        required this.firstAirDate,
        required this.genres,
        required this.homepage,
        required this.id,
        required this.inProduction,
        required this.languages,
        required this.lastAirDate,
        required this.name,
        required this.numberOfEpisodes,
        required this.numberOfSeasons,
        required this.originCountry,
        required this.originalLanguage,
        required this.originalName,
        required this.overview,
        required this.popularity,
        required this.posterPath,
        required this.productionCountries,
        required this.status,
        required this.tagline,
        required this.type,
        required this.voteAverage,
        required this.voteCount,
  });

    final bool adult;
    final String backdropPath;
    final List<dynamic> createdBy;
    final List<int> episodeRunTime;
    final DateTime firstAirDate;
    final List<Genre> genres;
    final String homepage;
    final int id;
    final bool inProduction;
    final List<String> languages;
    final DateTime lastAirDate;
    final String name;
    final int numberOfEpisodes;
    final int numberOfSeasons;
    final List<String> originCountry;
    final String originalLanguage;
    final String originalName;
    final String overview;
    final double popularity;
    final String posterPath;
    final List<dynamic> productionCountries;
    final String status;
    final String tagline;
    final String type;
    final double voteAverage;
    final int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCountries,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}
