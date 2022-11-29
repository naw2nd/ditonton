import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season_detail.dart';
import 'package:ditonton/presentation/provider/tv_show_season_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import 'tv_show_season_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowSeasonDetail,
])
void main() {
  late TvShowSeasonDetailNotifier provider;
  late int listenerCallCount;
  late MockGetTvShowSeasonDetail mockGetTvShowSeasonDetail;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowSeasonDetail = MockGetTvShowSeasonDetail();
    provider = TvShowSeasonDetailNotifier(
      getTvShowSeasonDetail: mockGetTvShowSeasonDetail,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
  final tSeasonNumber = 1;

  void _arrangeUsecase() {
    when(mockGetTvShowSeasonDetail.execute(tId, tSeasonNumber))
        .thenAnswer((_) async => Right(testTvShowSeasonDetail));
  }

  group('Get TvShowSeason Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockGetTvShowSeasonDetail.execute(tId, tSeasonNumber));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvShowSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvShowSeasonState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvShow when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvShowSeasonState, RequestState.Loaded);
      expect(provider.tvShowSeason, testTvShowSeasonDetail);
      expect(listenerCallCount, 2);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowSeasonDetail.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSeasonDetail(tId, tSeasonNumber);
      // assert
      expect(provider.tvShowSeasonState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
