import 'dart:convert';
import 'dart:io';

import 'package:core/common/exception.dart';
import 'package:tv_shows/data/datasources/tv_show_remote_data_source.dart';
import 'package:tv_shows/data/models/tv_show_detail_model.dart';
import 'package:tv_shows/data/models/tv_show_response.dart';
import 'package:tv_shows/data/models/tv_show_season_detail_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late TvShowRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  const tTvId = 1;
  const tTvSeasonNumber = 1;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvShowRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Now Playing Tv Shows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/now_playing_tv_shows.json')))
        .tvShowList;

    test('should return list of Tv Show Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/now_playing_tv_shows.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getNowPlayingTvShows();
      // assert
      expect(result, equals(tTvShowList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/on_the_air?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getNowPlayingTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular Tv Shows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/popular_tv_shows.json')))
        .tvShowList;

    test('should return list of tv shows when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/popular_tv_shows.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getPopularTvShows();
      // assert
      expect(result, tTvShowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/popular?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Top Rated Tv Shows', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/top_rated_tv_shows.json')))
        .tvShowList;

    test('should return list of tv shows when response code is 200 ', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/top_rated_tv_shows.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTopRatedTvShows();
      // assert
      expect(result, tTvShowList);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/top_rated?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvShows();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show detail', () {
    const tId = 1;
    final tTvShowDetail = TvShowDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_detail.json')));

    test('should return tv show detail when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_show_detail.json'), 200));
      // act
      final result = await dataSource.getTvShowDetail(tId);
      // assert
      expect(result, equals(tTvShowDetail));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/tv/$tId?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv show recommendations', () {
    final tTvShowList = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/tv_show_recommendations.json')))
        .tvShowList;
    const tId = 1;

    test('should return list of Tv Show Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_show_recommendations.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTvShowRecommendations(tId);
      // assert
      expect(result, equals(tTvShowList));
    });

    test('should throw Server Exception when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/tv/$tId/recommendations?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowRecommendations(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv shows', () {
    final tSearchResult = TvShowResponse.fromJson(
            json.decode(readJson('dummy_data/search_throne_tv_show.json')))
        .tvShowList;
    const tQuery = 'throne';

    test('should return list of movies when response code is 200', () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/search_throne_tv_show.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.searchTvShows(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse('$baseUrl/search/tv?$apiKey&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvShows(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Tv Show Season Detail', () {
    final tTvShowList = TvShowSeasonDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_show_season_detail.json')));

    test('should return tv shows deatil when response is success (200)',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl/tv/$tTvId/season/$tTvSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tv_show_season_detail.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // act
      final result = await dataSource.getTvShowSeasonDetail(1, 1);
      // assert
      expect(result, tTvShowList);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(
              '$baseUrl/tv/$tTvId/season/$tTvSeasonNumber?$apiKey')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvShowSeasonDetail(1, 1);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
