import 'dart:convert';

import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/data/models/tv_show_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: '/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg',
    id: 90462,
    name: 'Chucky',
    overview: 'overview',
    voteAverage: 7.9,
  );

  final tTvShowResponseModel =
      TvShowResponse(tvShowList: <TvShowModel>[tTvShowModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing_tv_shows.json'));
      // act
      final result = TvShowResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvShowResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvShowResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
            "id": 90462,
            "name": "Chucky",
            "overview": "overview",
            "vote_average": 7.9,
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
