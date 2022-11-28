import 'package:ditonton/data/models/tv_show_table.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';

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
    airDate: DateTime.utc(2020,1,1),
    episodeCount: 2,
    id: 1,
    name: 'season 1 name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 1,
  ),
  TvSeason(
    airDate: DateTime.utc(2020,1,1),
    episodeCount: 2,
    id: 2,
    name: 'season 2 name',
    overview: 'overview',
    posterPath: 'posterPath',
    seasonNumber: 2,
  ),
];

// final testTvShowTable = TvShowTable.fromEntity(testTvShowDetail);

final testTvShowTable = TvShowTable(
  id: 1,
  name: 'name',
  backdropPath: 'backdropPath',
  overview: 'overview',
);

final testTvShowMap = {
  'id': 1,
  'overview': 'overview',
  'backdropPath': 'backdrop_path',
  'name': 'name',
  'voteAverage': 3.0
};

final testWatchlistTvShow = TvShow.watchlist(
  id: 1,
  name: 'name',
  backdropPath: 'backdropPath',
  overview: 'overview',
);
