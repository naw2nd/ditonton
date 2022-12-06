import 'dart:convert';

import 'package:tv_shows/data/models/tv_show_model.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_shows/data/models/tv_show_response.dart';

import '../../json_reader.dart';

void main() {
  const tTvShowModel = TvShowModel(
    posterPath: '/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg',
    id: 90462,
    name: 'Chucky',
    overview: 'overview',
    voteAverage: 7.9,
  );

  const tTvShowResponseModel =
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
            "poster_path": "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
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
