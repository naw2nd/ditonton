import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:equatable/equatable.dart';

class TvShowModel extends Equatable {
  TvShowModel({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
  });

  final String? backdropPath;
  final int id;
  final String name;
  final String overview;
  final double voteAverage;

  factory TvShowModel.fromJson(Map<String, dynamic> json) =>
      TvShowModel(
        backdropPath: json["backdrop_path"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        voteAverage: json["vote_average"].toDouble(),
        
      );

  Map<String, dynamic> toJson() => {
        "backdrop_path": backdropPath,
        "id": id,
        "name": name,
        "overview": overview,
        "vote_average": voteAverage,
       
      };

  TvShow toEntity() => TvShow(
        backdropPath: backdropPath,
        id: id,
        name: name,
        overview: overview,
        voteAverage: voteAverage,
      );

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        name,
        overview,
        voteAverage,
      ];
}