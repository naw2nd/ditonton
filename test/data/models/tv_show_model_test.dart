import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvShowModel = TvShowModel(
    backdropPath: 'backdropPath',
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
  );

  final tTvShow = TvShow(
      backdropPath: 'backdropPath',
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1);

  test('should be a subclass of Tv Show entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });
}
