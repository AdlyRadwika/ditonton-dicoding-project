// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvs])
void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTvs mockGetPopularTvs;

  setUp(() {
    mockGetPopularTvs = MockGetPopularTvs();
    popularTvBloc = PopularTvBloc(mockGetPopularTvs);
  });

  group(
    'Popular Tv bloc',
    () {
      blocTest<PopularTvBloc, PopularTvState>(
        'Should emit [Loading, HasData] when popular Tv data is gotten successfully',
        build: () {
          when(mockGetPopularTvs.execute())
              .thenAnswer((_) async => Right(testTvList));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(GetPopularTvEvent()),
        expect: () => [
          PopularTvLoading(),
          PopularTvHasData(testTvList),
        ],
        verify: (bloc) {
          verify(mockGetPopularTvs.execute());
        },
      );

      blocTest<PopularTvBloc, PopularTvState>(
        'Should emit [Loading, Empty] when popular Tv data is empty',
        build: () {
          when(mockGetPopularTvs.execute()).thenAnswer((_) async => Right([]));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(GetPopularTvEvent()),
        expect: () => [
          PopularTvLoading(),
          PopularTvEmpty(),
        ],
        verify: (bloc) {
          verify(mockGetPopularTvs.execute());
        },
      );

      blocTest<PopularTvBloc, PopularTvState>(
        'Should emit [Loading, Error] when get popular Tvs is unsuccessful',
        build: () {
          when(mockGetPopularTvs.execute())
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return popularTvBloc;
        },
        act: (bloc) => bloc.add(GetPopularTvEvent()),
        expect: () => [
          PopularTvLoading(),
          const PopularTvError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetPopularTvs.execute());
        },
      );
    },
  );
}
