import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../data/dummy_data/movie_dummy_objects.dart';
import 'watchlist_movie_block_test.mocks.dart';

@GenerateMocks([
  SaveWatchlistMovie,
  RemoveWatchlistMovie,
  MockGetWatchlistStatusMovie,
  GetWatchlistMovies
])
void main() {
  late WatchlistMovieBloc watchlistMovieBloc;
  late MockSaveMovieWatchlist mockSaveWatchlistMovie;
  late MockRemoveMovieWatchlist mockRemoveWatchlistMovie;
  late MockGetWatchlistStatusMovie mockGetWatchlistStatusMovie;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockSaveWatchlistMovie = MockSaveMovieWatchlist();
    mockRemoveWatchlistMovie = MockRemoveMovieWatchlist();
    mockGetWatchlistStatusMovie = MockGetWatchlistStatusMovie();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
        mockSaveWatchlistMovie,
        mockRemoveWatchlistMovie,
        mockGetWatchlistStatusMovie,
        mockGetWatchlistMovies);
  });

  group(
    'Watchlist movie bloc',
    () {
      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Success] when save watchlist function is success',
        build: () {
          when(mockSaveWatchlistMovie.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Added to Watchlist'));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(SaveWatchlistMovie(testMovieDetail)),
        expect: () => [
          SaveWatchlistMovieLoading(),
          const SaveWatchlistMovieSuccess('Added to Watchlist'),
          const GetWatchlistMovieStatusData(true),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistMovie.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Error] when save watchlist function is failed',
        build: () {
          when(mockSaveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(SaveWatchlistMovie(testMovieDetail)),
        expect: () => [
          SaveWatchlistMovieLoading(),
          const SaveWatchlistMovieError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistMovie.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Success] when remove watchlist function is success',
        build: () {
          when(mockRemoveWatchlistMovie.execute(testMovieDetail))
              .thenAnswer((_) async => const Right('Removed from Watchlist'));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
        expect: () => [
          RemoveWatchlistMovieLoading(),
          const RemoveWatchlistMovieSuccess('Removed from Watchlist'),
          const GetWatchlistMovieStatusData(false),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Error] when remove watchlist function is failed',
        build: () {
          when(mockRemoveWatchlistMovie.execute(testMovieDetail)).thenAnswer(
              (_) async => Left(DatabaseFailure('Database Failure')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(RemoveWatchlistMovie(testMovieDetail)),
        expect: () => [
          RemoveWatchlistMovieLoading(),
          const RemoveWatchlistMovieError('Database Failure'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistMovie.execute(testMovieDetail));
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, Data] when get status watchlist movie',
        build: () {
          when(mockGetWatchlistStatusMovie.execute(testMovie.id))
              .thenAnswer((_) async => true);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovieStatus(testMovie.id)),
        expect: () => [
          GetWatchlistMovieStatusLoading(),
          const GetWatchlistMovieStatusData(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatusMovie.execute(testMovie.id));
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right(testMovieList));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovie()),
        expect: () => [
          GetWatchlistMovieLoading(),
          GetWatchlistMovieHasData(testMovieList),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, Empty] when data is empty',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right([]));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovie()),
        expect: () => [
          GetWatchlistMovieLoading(),
          GetWatchlistMovieEmpty(),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );

      blocTest<WatchlistMovieBloc, WatchlistMovieState>(
        'Should emit [Loading, Error] when get movies is unsuccessful',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc.add(GetWatchlistMovie()),
        expect: () => [
          GetWatchlistMovieLoading(),
          const GetWatchlistMovieError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        },
      );
    },
  );
}
