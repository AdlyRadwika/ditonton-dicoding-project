import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Tv extends Equatable {
  Tv({
    required this.genreIds,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  List<int>? genreIds;
  int id;
  String? name;
  String? overview;
  String? posterPath;
  double? voteAverage;

  @override
  List<Object?> get props => [
        genreIds,
        id,
        name,
        overview,
        posterPath,
        voteAverage,
      ];
}
