// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'now_playing_tv_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvs])
void main() {
  late NowPlayingTvBloc nowPlayingTvBloc;
  late MockGetNowPlayingTvs mockGetNowPlayingTvs;

  setUp(() {
    mockGetNowPlayingTvs = MockGetNowPlayingTvs();
    nowPlayingTvBloc = NowPlayingTvBloc(mockGetNowPlayingTvs);
  });

  group(
    'Now playing Tv bloc',
    () {
      blocTest<NowPlayingTvBloc, NowPlayingTvState>(
        'Should emit [Loading, HasData] when now playing Tv data is gotten successfully',
        build: () {
          when(mockGetNowPlayingTvs.execute())
              .thenAnswer((_) async => Right(testTvList));
          return nowPlayingTvBloc;
        },
        act: (bloc) => bloc.add(GetNowPlayingTvEvent()),
        expect: () => [
          NowPlayingTvLoading(),
          NowPlayingTvHasData(testTvList),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingTvs.execute());
        },
      );

      blocTest<NowPlayingTvBloc, NowPlayingTvState>(
        'Should emit [Loading, Empty] when now playing Tv data is empty',
        build: () {
          when(mockGetNowPlayingTvs.execute())
              .thenAnswer((_) async => Right([]));
          return nowPlayingTvBloc;
        },
        act: (bloc) => bloc.add(GetNowPlayingTvEvent()),
        expect: () => [
          NowPlayingTvLoading(),
          NowPlayingTvEmpty(),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingTvs.execute());
        },
      );

      blocTest<NowPlayingTvBloc, NowPlayingTvState>(
        'Should emit [Loading, Error] when get now playing Tvs is unsuccessful',
        build: () {
          when(mockGetNowPlayingTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return nowPlayingTvBloc;
        },
        act: (bloc) => bloc.add(GetNowPlayingTvEvent()),
        expect: () => [
          NowPlayingTvLoading(),
          const NowPlayingTvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetNowPlayingTvs.execute());
        },
      );
    },
  );
}
