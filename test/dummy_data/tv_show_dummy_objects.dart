import 'package:ditonton/data/models/tv_show_table.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';

final testTvShow = TvShow(
  posterPath: 'posterPath',
  id: 1,
  name: 'name',
  overview: 'overview',
  voteAverage: 3.0,
);

final testTvShowList = [testTvShow];

final testTvShowDetail = TvShowDetail(
  backdropPath: 'backdropPath',
  id: 1,
  name: 'name',
  overview: 'overview',
  posterPath: 'posterPath',
  voteAverage: 3.0,
  seasons: testSeasonList,
);
final testSeasonList = [
  TvSeason(
    airDate: DateTime.utc(2020, 1, 1),
    episodeCount: 2,
    id: 1,
    name: 'season 1 name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  ),
  TvSeason(
    airDate: DateTime.utc(2020, 1, 1),
    episodeCount: 2,
    id: 2,
    name: 'season 2 name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 2,
  ),
];

final testTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvShowMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
  'voteAverage': 3.0
};

final testWatchlistTvShow = TvShow.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);
