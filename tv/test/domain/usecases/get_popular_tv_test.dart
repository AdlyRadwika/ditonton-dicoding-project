import 'package:dartz/dartz.dart';
import 'package:tv/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetPopularTvs usecase;
  late MockTvRepository mocktvRpository;

  setUp(() {
    mocktvRpository = MockTvRepository();
    usecase = GetPopularTvs(mocktvRpository);
  });

  final ttvs = <Tv>[];

  group('GetPopulartvs Tests', () {
    group('execute', () {
      test(
          'should get list of tvs from the repository when execute function is called',
          () async {
        // arrange
        when(mocktvRpository.getPopularTvs())
            .thenAnswer((_) async => Right(ttvs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(ttvs));
      });
    });
  });
}
