import 'package:equatable/equatable.dart';

class TvShow extends Equatable {
  TvShow({
    required this.posterPath,
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
  });

  final String? posterPath;
  final int id;
  final String? name;
  final String? overview;
  double? voteAverage;

  TvShow.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  @override
  List<Object?> get props => [
        posterPath,
        id,
        name,
        overview,
        voteAverage,
      ];
}
