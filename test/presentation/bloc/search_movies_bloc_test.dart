import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie_search_bloc.dart';
import 'package:ditonton/presentation/bloc/now_playing_movies_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie_dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';
import '../provider/movie_list_notifier_test.mocks.dart';
import '../provider/movie_search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMoviesBloc searchMoviesBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchMoviesBloc = SearchMoviesBloc(
      mockSearchMovies,
    );
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  final tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(searchMoviesBloc.state, SearchMoviesEmpty());
  });

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(OnQuerySearch(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchMoviesLoading(),
      SearchMoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchMoviesBloc, SearchMoviesState>(
    'Should emit [Loading, Error] when search movies is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchMoviesBloc;
    },
    act: (bloc) => bloc.add(OnQuerySearch(tQuery)),
    expect: () => [
      SearchMoviesLoading(),
      SearchMoviesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
