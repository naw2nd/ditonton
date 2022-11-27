import 'package:ditonton/domain/entities/tv_season.dart';
import 'package:equatable/equatable.dart';

class TvShowDetail extends Equatable {
  TvShowDetail({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.seasons,
  });

  final String? backdropPath;
  final int id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final double? voteAverage;
  final List<TvSeason>? seasons;

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
