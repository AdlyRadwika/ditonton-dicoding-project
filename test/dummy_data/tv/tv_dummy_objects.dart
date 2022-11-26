import 'package:ditonton/data/models/tv/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

final testTv = Tv(
  backdropPath: '/3XjDhPzj7Myr8yzsTO8UB6E2oAu.jpg',
  genreIds: [18, 80],
  id: 31586,
  overview:
      'After years of blood, sweat and tears, a woman of humble origin ends up becoming a drug trafficking legend, with all that that means...',
  popularity: 933.214,
  posterPath: '/uBTlJDdPpRxYTfUnKw4wbuIGSEK.jpg',
  name: 'La Reina del Sur',
  voteAverage: 7.773,
  voteCount: 1434,
  originCountry: ["US"],
  originalLanguage: "es",
  originalName: "La Reina del Sur",
);

final testTvList = [testTv];

final testTvDetail = TvDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 18, name: 'Drama'), Genre(id: 80, name: 'Crime')],
  id: 1,
  overview: 'overview',
  posterPath: 'posterPath',
  name: 'name',
  voteAverage: 1,
  voteCount: 1,
  createdBy: ['createdBy'],
  episodeRunTime: [1 , 2],
  homepage: 'homepage',
  inProduction: true,
  languages: [],
  numberOfEpisodes: 1,
  numberOfSeasons: 1,
  originCountry: ['originCountry'],
  originalLanguage: 'originalLanguage',
  originalName: 'originalName',
  popularity: 1,
  productionCountries: [],
  status: 'status',
  tagline: 'tagline',
  type: 'type',
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
