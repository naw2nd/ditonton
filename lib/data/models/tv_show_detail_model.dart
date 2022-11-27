import 'package:ditonton/data/models/tv_season_model.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowDetailResponse extends Equatable {
  TvShowDetailResponse({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.seasons,
  });

  final String backdropPath;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final double voteAverage;
  final List<TvSeasonModel> seasons;

  factory TvShowDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvShowDetailResponse(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        seasons: List<TvSeasonModel>.from((json["seasons"] as List)
            .map((x) => TvSeasonModel.fromJson(x))
            .where((element) => element.airDate != null)),
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "overview": overview,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "seasons": List<dynamic>.from(seasons.map((x) => x.toJson())),
      };

  TvShowDetail toEntity() => TvShowDetail(
        backdropPath: backdropPath,
        id: id,
        name: name,
        overview: overview,
        posterPath: posterPath,
        voteAverage: voteAverage,
        seasons: this.seasons.map((season) => season.toEntity()).toList(),
      );

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        name,
        overview,
        posterPath,
        voteAverage,
        seasons,
      ];
}
