import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: "Overview",
    posterPath: "/path.jpg",
    name: "Name",
    voteAverage: 1.0,
  );
  final tTvResponseModel =
      TvResponse(tvList: <TvModel>[tTvModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv/now_playing.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "overview": "Overview",
            "poster_path": "/path.jpg",
            "name": "Name",
            "vote_average": 1.0,
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
