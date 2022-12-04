// ignore_for_file: prefer_const_constructors_in_immutables, unnecessary_this

import 'package:core/domain/entities/tv/tv.dart';
import 'package:equatable/equatable.dart';

class TvModel extends Equatable {
  TvModel({
    required this.genreIds,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  final List<int> genreIds;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final double voteAverage;

  factory TvModel.fromJson(Map<String, dynamic> json) => TvModel(
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "vote_average": voteAverage,
      };

  Tv toEntity() {
    return Tv(
      genreIds: this.genreIds,
      id: this.id,
      name: this.name,
      overview: this.overview,
      posterPath: this.posterPath,
      voteAverage: this.voteAverage,
    );
  }

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
