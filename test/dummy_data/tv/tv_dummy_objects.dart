import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
  genreIds: [18, 80],
  id: 31586,
  overview:
      'After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...',
  posterPath: '/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg',
  name: 'La Reina del Sur',
  voteAverage: 7.773,
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  genres: [Genre(id: 18, name: 'Drama'), Genre(id: 80, name: 'Crime')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
  voteAverage: 1,
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
);

final testWatchlistTv = Tv.watchlist(
  id: 1,
  name: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvTable = TvTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
