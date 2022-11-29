import 'package:ditonton/data/models/tv_show_table.dart';
import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:ditonton/domain/entities/tv_show_episode.dart';
import 'package:ditonton/domain/entities/tv_show_season_detail.dart';

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

final testTvShowEpisodeList = [
  TvShowEpisode(
    episodeNumber: 1,
    id: 1971015,
    name: "The Heirs of the Dragon",
    overview:
        "Viserys hosts a tournament to celebrate the birth of his second child. Rhaenyra welcomes her uncle Daemon back to the Red Keep.",
    stillPath: "/3V447myclihccqnSiVFVdlnNjZs.jpg",
  ),
  TvShowEpisode(
      episodeNumber: 2,
      id: 3846963,
      name: "The Rogue Prince",
      overview:
          "Princess Rhaenyra dives deep into the prophecies about House Targaryen while confronting a realm that resists the idea of a woman on the Iron Throne, and Prince Daemon, embittered over being passed over as the heir to Westeros, prepares to go to war.",
      stillPath: "/uyWlPCKMPcjxjiKY6xFKtdbkFSR.jpg")
];

final testTvShowSeasonDetail = TvShowSeasonDetail(
  name: "Season 1",
  overview: "",
  id: 134965,
  posterPath: "/z2yahl2uefxDCl0nogcRBstwruJ.jpg",
  seasonNumber: 1,
  episodes: testTvShowEpisodeList,
);
