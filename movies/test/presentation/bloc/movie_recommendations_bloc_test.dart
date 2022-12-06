import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_recommendations_bloc_test.mocks.dart';


@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieRecommendationsBloc popularMoviesBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    popularMoviesBloc = MovieRecommendationsBloc(
      getMovieRecommendations: mockGetMovieRecommendations,
    );
  });

  const tId = 1;
  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(popularMoviesBloc.state, MovieRecommendationsEmpty());
  });

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tMovieList));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnFetchMovieRecommendatios(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieRecommendationsLoading(),
      MovieRecommendationsHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );

  blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
    'Should emit [Loading, Error] when fetch movie recommendations is unsuccessful',
    build: () {
      when(mockGetMovieRecommendations.execute(tId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularMoviesBloc;
    },
    act: (bloc) => bloc.add(OnFetchMovieRecommendatios(tId)),
    expect: () => [
      MovieRecommendationsLoading(),
      const MovieRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(tId));
    },
  );
}
