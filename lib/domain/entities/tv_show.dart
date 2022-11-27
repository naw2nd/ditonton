import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  TvShow({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
  });

  final String? backdropPath;
  final int id;
  final String? name;
  final String? overview;
  final double? voteAverage;

  TvShow.watchlist({
    required this.voteAverage,
    required this.id,
    required this.overview,
    required this.backdropPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        backdropPath,
        id,
        name,
        overview,
        voteAverage,
      ];
}
