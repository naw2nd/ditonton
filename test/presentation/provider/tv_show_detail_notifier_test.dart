// ignore_for_file: unused_import

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/domain/usecases/get_tv_show_watvhlist_status.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_show_watchlist.dart';
import 'package:ditonton/presentation/provider/tv_show_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendations,
  GetTvShowWatchListStatus,
  SaveTvShowWatchlist,
  RemoveTvShowWatchlist,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;
  late MockGetTvShowWatchListStatus mockGetTvShowWatchlistStatus;
  late MockSaveTvShowWatchlist mockSaveTvShowWatchlist;
  late MockRemoveTvShowWatchlist mockRemoveTvShowWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    mockGetTvShowWatchlistStatus = MockGetTvShowWatchListStatus();
    mockSaveTvShowWatchlist = MockSaveTvShowWatchlist();
    mockRemoveTvShowWatchlist = MockRemoveTvShowWatchlist();
    provider = TvShowDetailNotifier(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendations,
      getTvShowWatchListStatus: mockGetTvShowWatchlistStatus,
      saveTvShowWatchlist: mockSaveTvShowWatchlist,
      removeTvShowWatchlist: mockRemoveTvShowWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTvShow = TvShow(
    posterPath: 'backdropPath',
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 3.0,
  );
  final tTvShows = <TvShow>[tTvShow];

  void _arrangeUsecase() {
    when(mockGetTvShowDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvShowRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tTvShows));
  }

  group('Get TvShow Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowDetail.execute(tId));
      verify(mockGetTvShowRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tvShow when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShow, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test(
        'should change recommendation tvShows when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShows);
    });
  });

  group('Get TvShow Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      verify(mockGetTvShowRecommendations.execute(tId));
      expect(provider.tvShowRecommendations, tTvShows);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvShowRecommendations, tTvShows);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetTvShowWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetTvShowWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockSaveTvShowWatchlist.execute(testTvShowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetTvShowWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvShowDetail);
      // assert
      verify(mockRemoveTvShowWatchlist.execute(testTvShowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetTvShowWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockGetTvShowWatchlistStatus.execute(testTvShowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvShowWatchlistStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tTvShows));
      // act
      await provider.fetchTvShowDetail(tId);
      // assert
      expect(provider.tvShowState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
