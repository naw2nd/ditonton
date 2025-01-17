import 'package:tv_shows/data/models/tv_show_model.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tTvShowModel = TvShowModel(
    posterPath: 'posterPath',
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 1,
  );

  final tTvShow = TvShow(
      posterPath: 'posterPath',
      id: 1,
      name: 'name',
      overview: 'overview',
      voteAverage: 1);

  test('should be a subclass of Tv Show entity', () async {
    final result = tTvShowModel.toEntity();
    expect(result, tTvShow);
  });
}
