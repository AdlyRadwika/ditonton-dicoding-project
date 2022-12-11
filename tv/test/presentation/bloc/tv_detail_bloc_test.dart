import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';

import '../../dummy_data/tv_dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail, GetTvRecommendations])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
  });

  group('Tv detail bloc', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, Data] when get Tv detail is success',
      build: () {
        when(mockGetTvDetail.execute(testTv.id))
            .thenAnswer((_) async => Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(testTv.id)),
      expect: () => [
        TvDetailLoading(),
        TvDetailData(testTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(testTv.id));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, Error] when get Tv detail is failed',
      build: () {
        when(mockGetTvDetail.execute(testTv.id))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetTvDetailEvent(testTv.id)),
      expect: () => [
        TvDetailLoading(),
        const TvDetailError("Server Failure"),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(testTv.id));
      },
    );
    },
  );
}