import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

class TvShowModel extends Equatable {
  const TvShowModel({
    required this.posterPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
  });

  final String? posterPath;
  final int id;
  final String name;
  final String overview;
  final double voteAverage;

  factory TvShowModel.fromJson(Map<String, dynamic> json) =>
      TvShowModel(
        posterPath: json["poster_path"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        voteAverage: json["vote_average"].toDouble(),
        
      );

  Map<String, dynamic> toJson() => {
        "poster_path": posterPath,
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
      };

  TvShow toEntity() => TvShow(
        posterPath: posterPath,
        id: id,
        name: name,
        overview: overview,
        voteAverage: voteAverage,
      );

  @override
  List<Object?> get props => [
        posterPath,
        id,
        name,
        overview,
        voteAverage,
      ];
}