import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowTable extends Equatable {
  final int id;
  final String? backdropPath;
  final String? name;
  final String? overview;
  final double? voteAverage;

  TvShowTable({
    required this.id,
    required this.name,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
  });

  factory TvShowTable.fromEntity(TvShowDetail tvShow) => TvShowTable(
        id: tvShow.id,
        name: tvShow.name,
        backdropPath: tvShow.backdropPath,
        overview: tvShow.overview,
        voteAverage: tvShow.voteAverage,
      );

  factory TvShowTable.fromMap(Map<String, dynamic> map) => TvShowTable(
        id: map['id'],
        name: map['name'],
        backdropPath: map['backdropPath'],
        overview: map['overview'],
        voteAverage: map['voteAverage'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'backdropPath': backdropPath,
        'overview': overview,
        'voteAverage': voteAverage,
      };

  TvShow toEntity() => TvShow.watchlist(
        id: id,
        backdropPath: backdropPath,
        overview: overview,
        name: name,
        voteAverage: voteAverage,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        backdropPath,
        overview,
        voteAverage,
      ];
}
