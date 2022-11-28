import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/entities/tv_show_detail.dart';
import 'package:equatable/equatable.dart';

class TvShowTable extends Equatable {
  final int id;
  final String? backdropPath;
  final String? name;
  final String? overview;

  TvShowTable({
    required this.id,
    required this.name,
    required this.backdropPath,
    required this.overview,
  });

  factory TvShowTable.fromEntity(TvShowDetail tvShow) => TvShowTable(
        id: tvShow.id,
        name: tvShow.name,
        backdropPath: tvShow.backdropPath,
        overview: tvShow.overview,
      );

  factory TvShowTable.fromMap(Map<String, dynamic> map) => TvShowTable(
        id: map['id'],
        name: map['name'],
        backdropPath: map['backdropPath'],
        overview: map['overview'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'backdropPath': backdropPath,
        'overview': overview,
      };

  TvShow toEntity() => TvShow.watchlist(
        id: id,
        backdropPath: backdropPath,
        overview: overview,
        name: name,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        backdropPath,
        overview,
      ];
}
