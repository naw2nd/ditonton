import 'package:tv_shows/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvSeasonModel extends Equatable {
  const TvSeasonModel({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final DateTime? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;

  factory TvSeasonModel.fromJson(Map<String, dynamic> json) => TvSeasonModel(
        airDate:
            json["air_date"] != null ? DateTime.parse(json["air_date"]) : null,
        episodeCount: json["episode_count"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );



  TvSeason toEntity() => TvSeason(
        airDate: airDate,
        episodeCount: episodeCount,
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
        seasonNumber: seasonNumber,
      );

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
