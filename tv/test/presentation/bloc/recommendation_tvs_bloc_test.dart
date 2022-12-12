// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'recommendation_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail, GetTvRecommendations])
void main() {
  late RecommendationTvsBloc recommendationTvsBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    recommendationTvsBloc = RecommendationTvsBloc(mockGetTvRecommendations);
  });

  group(
    'Tv recommendation bloc',
    () {
      blocTest<RecommendationTvsBloc, RecommendationTvsState>(
        'Should emit [Loading, HasData] when Tvs recommendation data is gotten successfully',
        build: () {
          when(mockGetTvRecommendations.execute(testTv.id))
              .thenAnswer((_) async => Right(testTvList));
          return recommendationTvsBloc;
        },
        act: (bloc) => bloc.add(GetRecommendationTvEvent(testTv.id)),
        expect: () => [
          RecommendationTvsLoading(),
          RecommendationTvsData(testTvList),
        ],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(testTv.id));
        },
      );

      blocTest<RecommendationTvsBloc, RecommendationTvsState>(
        'Should emit [Loading, Empty] when Tvs recommendation data is empty',
        build: () {
          when(mockGetTvRecommendations.execute(testTv.id))
              .thenAnswer((_) async => Right([]));
          return recommendationTvsBloc;
        },
        act: (bloc) => bloc.add(GetRecommendationTvEvent(testTv.id)),
        expect: () => [
          RecommendationTvsLoading(),
          RecommendationTvsEmpty(),
        ],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(testTv.id));
        },
      );

      blocTest<RecommendationTvsBloc, RecommendationTvsState>(
        'Should emit [Loading, Error] when get recommendation Tvs is unsuccessful',
        build: () {
          when(mockGetTvRecommendations.execute(testTv.id))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return recommendationTvsBloc;
        },
        act: (bloc) => bloc.add(GetRecommendationTvEvent(testTv.id)),
        expect: () => [
          RecommendationTvsLoading(),
          const RecommendationTvsError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(testTv.id));
        },
      );
    },
  );
}
