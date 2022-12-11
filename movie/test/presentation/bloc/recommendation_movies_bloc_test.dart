import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../data/dummy_data/movie_dummy_objects.dart';
import 'recommendation_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late RecommendationMoviesBloc recommendationMoviesBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMoviesBloc = RecommendationMoviesBloc(mockGetMovieRecommendations);
  });

  group('Movie recommendation bloc', () {
    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, HasData] when movies recommendation data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(testMovie.id))
            .thenAnswer((_) async => Right(testMovieList));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(GetRecommendationMovieEvent(testMovie.id)),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(testMovie.id));
      },
    );

      blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
        'Should emit [Loading, Empty] when movies recommendation data is empty',
        build: () {
          when(mockGetMovieRecommendations.execute(testMovie.id))
              .thenAnswer((_) async => Right([]));
          return recommendationMoviesBloc;
        },
        act: (bloc) => bloc.add(GetRecommendationMovieEvent(testMovie.id)),
        expect: () => [
          RecommendationMoviesLoading(),
          RecommendationMoviesEmpty(),
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(testMovie.id));
        },
      );

      blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
        'Should emit [Loading, Error] when get recommendation movies is unsuccessful',
        build: () {
          when(mockGetMovieRecommendations.execute(testMovie.id))
              .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
          return recommendationMoviesBloc;
        },
        act: (bloc) => bloc.add(GetRecommendationMovieEvent(testMovie.id)),
        expect: () => [
          RecommendationMoviesLoading(),
          const RecommendationMoviesError('Server Failure'),
        ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(testMovie.id));
        },
      );
    },
  );
}