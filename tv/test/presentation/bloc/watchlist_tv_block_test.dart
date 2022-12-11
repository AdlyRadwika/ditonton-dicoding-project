// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'watchlist_tv_block_test.mocks.dart';

@GenerateMocks([SaveWatchlistTv, RemoveWatchlistTv, MockGetWatchlistStatusTv, GetWatchlistTvs])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockSaveTvWatchlist mockSaveWatchlistTv;
  late MockRemoveTvWatchlist mockRemoveWatchlistTv;
  late MockGetWatchlistStatusTv mockGetWatchlistStatusTv;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockSaveWatchlistTv = MockSaveTvWatchlist();
    mockRemoveWatchlistTv = MockRemoveTvWatchlist();
    mockGetWatchlistStatusTv = MockGetWatchlistStatusTv();
    mockGetWatchlistTvs = MockGetWatchlistTvs() ;
    watchlistTvBloc = WatchlistTvBloc(
      mockSaveWatchlistTv,
      mockRemoveWatchlistTv,
      mockGetWatchlistStatusTv,
      mockGetWatchlistTvs
    );
  });

  group('Watchlist Tv bloc', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Success] when save watchlist function is success',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistTv(testTvDetail)),
      expect: () => [
        SaveWatchlistTvLoading(),
        const SaveWatchlistTvSuccess('Added to Watchlist'),
        const GetWatchlistTvStatusData(true),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Error] when save watchlist function is failed',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(SaveWatchlistTv(testTvDetail)),
      expect: () => [
        SaveWatchlistTvLoading(),
        const SaveWatchlistTvError('Database Failure'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Success] when remove watchlist function is success',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTv(testTvDetail)),
      expect: () => [
        RemoveWatchlistTvLoading(),
        const RemoveWatchlistTvSuccess('Removed from Watchlist'),
        const GetWatchlistTvStatusData(false),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Error] when remove watchlist function is failed',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Database Failure')));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(RemoveWatchlistTv(testTvDetail)),
      expect: () => [
        RemoveWatchlistTvLoading(),
        const RemoveWatchlistTvError('Database Failure'),
      ],
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, Data] when get status watchlist Tv',
    build: () {
      when(mockGetWatchlistStatusTv.execute(testTv.id))
          .thenAnswer((_) async => true);
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTvStatus(testTv.id)),
    expect: () => [
      GetWatchlistTvStatusLoading(),
      const GetWatchlistTvStatusData(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistStatusTv.execute(testTv.id));
    },
  );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Right(testTvList));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTv()),
    expect: () => [
      GetWatchlistTvLoading(),
      GetWatchlistTvHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, Empty] when data is empty',
    build: () {
      when(mockGetWatchlistTvs.execute()).thenAnswer((_) async => Right([]));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTv()),
    expect: () => [
      GetWatchlistTvLoading(),
      GetWatchlistTvEmpty(),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );

  blocTest<WatchlistTvBloc, WatchlistTvState>(
    'Should emit [Loading, Error] when get Tvs is unsuccessful',
    build: () {
      when(mockGetWatchlistTvs.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return watchlistTvBloc;
    },
    act: (bloc) => bloc.add(GetWatchlistTv()),
    expect: () => [
      GetWatchlistTvLoading(),
      const GetWatchlistTvError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );
  },
  );
}