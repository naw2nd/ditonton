import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/common/exception.dart';
import 'package:core/common/failure.dart';
import 'package:tv_shows/data/models/tv_season_model.dart';
import 'package:tv_shows/data/models/tv_show_detail_model.dart';
import 'package:tv_shows/data/models/tv_show_episode_model.dart';
import 'package:tv_shows/data/models/tv_show_model.dart';
import 'package:tv_shows/data/models/tv_show_season_detail_response.dart';
import 'package:tv_shows/data/repositories/tv_show_repository_impl.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  const tTvShowModel = TvShowModel(
      posterPath: 'posterPath',
      id: 1,
      overview: 'overview',
      voteAverage: 7.2,
      name: 'name');

  final tTvShow = TvShow(
    posterPath: 'posterPath',
    id: 1,
    overview: 'overview',
    voteAverage: 7.2,
    name: 'name',
  );

  final tTvShowModelList = <TvShowModel>[tTvShowModel];
  final tTvShowList = <TvShow>[tTvShow];

  group('Now Playing TvShows', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getNowPlayingTvShows();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingTvShows();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingTvShows();
      // assert
      verify(mockRemoteDataSource.getNowPlayingTvShows());
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TvShows', () {
    test('should return movie list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getPopularTvShows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvShows();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvShows();
      // assert
      expect(
          result, const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated TvShows', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTvShows())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvShows();
      // assert
      expect(
          result, const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get TvShow Detail', () {
    const tId = 1;

    final testSeasonList = [
      TvSeasonModel(
        airDate: DateTime.utc(2020, 1, 1),
        episodeCount: 2,
        id: 1,
        name: 'season 1 name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 1,
      ),
      TvSeasonModel(
        airDate: DateTime.utc(2020, 1, 1),
        episodeCount: 2,
        id: 2,
        name: 'season 2 name',
        overview: 'overview',
        posterPath: 'posterPath',
        seasonNumber: 2,
      ),
    ];
    final tTvShowResponse = TvShowDetailResponse(
      backdropPath: 'backdropPath',
      id: 1,
      name: 'name',
      overview: 'overview',
      posterPath: 'posterPath',
      voteAverage: 3,
      seasons: testSeasonList,
    );
    test(
        'should return TvShow data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenAnswer((_) async => tTvShowResponse);
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(Right(testTvShowDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TvShow Recommendations', () {
    final tTvShowList = <TvShowModel>[];
    const tId = 1;

    test('should return data (movie list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenAnswer((_) async => tTvShowList);
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvShowList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowRecommendations(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowRecommendations(tId));
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach TvShows', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenAnswer((_) async => tTvShowModelList);
      // act
      final result = await repository.searchTvShows(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvShowList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvShows(tQuery);
      // assert
      expect(result, const Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTvShows(tQuery))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvShows(tQuery);
      // assert
      expect(
          result, const Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTvShowWatchlist(testTvShowDetail);
      // assert
      expect(result, const Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertTvShowWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTvShowWatchlist(testTvShowDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeTvShowWatchlist(testTvShowDetail);
      // assert
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeTvShowWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTvShowWatchlist(testTvShowDetail);
      // assert
      expect(result, const Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tId = 1;
      when(mockLocalDataSource.getTvShowById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToTvShowWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist movies', () {
    test('should return list of TvShows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => [testTvShowTable]);
      // act
      final result = await repository.getWatchlistTvShows();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvShow]);
    });
  });

  group('Get TvShow Season Detail', () {
    const tId = 1;
    const tSeasonNumber = 1;

    final tTvShowEpisodeList = [
      const TvShowEpisodeModel(
        episodeNumber: 1,
        id: 1971015,
        name: "The Heirs of the Dragon",
        overview:
            "Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.",
        stillPath: "/3V447myclihccqnSiVFVdlnNjZs.jpg",
      ),
      const TvShowEpisodeModel(
          episodeNumber: 2,
          id: 3846963,
          name: "The Rogue Prince",
          overview:
              "Princess Rhaenyra dives deep into the prophecies about House Targaryen while confronting a realm that resists the idea of a woman on the Iron Throne, and Prince Daemon, embittered over being passed over as the heir to Westeros, prepares to go to war.",
          stillPath: "/uyWlPCKMPcjxjiKY6xFKtdbkFSR.jpg")
    ];

    final tTvShowSeasonDetail = TvShowSeasonDetailResponse(
      name: "Season 1",
      overview: "",
      id: 134965,
      posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
      seasonNumber: 1,
      episodes: tTvShowEpisodeList,
    );

    test(
        'should return TvShow Season data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowSeasonDetail(tId, tSeasonNumber))
          .thenAnswer((_) async => tTvShowSeasonDetail);
      // act
      final result = await repository.getTvShowSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvShowSeasonDetail(tId, tSeasonNumber));
      expect(result, equals(Right(testTvShowSeasonDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowSeasonDetail(tId, tSeasonNumber))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvShowSeasonDetail(tId, tSeasonNumber);
      // assert
      verify(mockRemoteDataSource.getTvShowSeasonDetail(tId, tSeasonNumber));
      expect(result, equals(const Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTvShowDetail(tId))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvShowDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvShowDetail(tId));
      expect(result,
          equals(const Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
