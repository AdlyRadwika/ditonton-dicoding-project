import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../data/dummy_data/movie_dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail, GetMovieRecommendations])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  group('Movie detail bloc', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Data] when get movie detail is success',
      build: () {
        when(mockGetMovieDetail.execute(testMovie.id))
            .thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(GetMovieDetailEvent(testMovie.id)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(testMovie.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when get movie detail is failed',
      build: () {
        when(mockGetMovieDetail.execute(testMovie.id))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(GetMovieDetailEvent(testMovie.id)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailError("Server Failure"),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(testMovie.id));
      },
    );
    },
  );
}