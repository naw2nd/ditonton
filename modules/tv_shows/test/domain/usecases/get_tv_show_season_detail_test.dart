import 'package:dartz/dartz.dart';
import 'package:tv_shows/domain/usecases/get_tv_show_season_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowSeasonDetail usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowSeasonDetail(mockTvShowRepository);
  });

  const tId = 1;
  const tSeasonNumber = 1;
  test('should get tv show season detail from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowSeasonDetail(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(testTvShowSeasonDetail));
    // act
    final result = await usecase.execute(tId, tSeasonNumber);
    // assert
    expect(result, Right(testTvShowSeasonDetail));
  });
}
