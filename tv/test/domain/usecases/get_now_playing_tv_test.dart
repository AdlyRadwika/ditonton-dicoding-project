import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetNowPlayingTvs usecase;
  late MockTvRepository mocktvRepository;

  setUp(() {
    mocktvRepository = MockTvRepository();
    usecase = GetNowPlayingTvs(mocktvRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of tvs from the repository', () async {
    // arrange
    when(mocktvRepository.getNowPlayingTvs())
        .thenAnswer((_) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
