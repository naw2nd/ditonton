import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/search_tv_shows.dart';
import 'package:ditonton/presentation/bloc/search_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../provider/tv_show_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late SearchTvShowsBloc searchTvShowsBloc;
  late MockSearchTvShows mockSearchTvShows;

  setUp(() {
    mockSearchTvShows = MockSearchTvShows();
    searchTvShowsBloc = SearchTvShowsBloc(
      mockSearchTvShows,
    );
  });

  final tTvShowModel = TvShow(
    posterPath: 'backdropPath',
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 3.0,
  );
  final tTvShowList = <TvShow>[tTvShowModel];
  final tQuery = 'name';

  test('initial state should be empty', () {
    expect(searchTvShowsBloc.state, SearchTvShowsEmpty());
  });

  blocTest<SearchTvShowsBloc, SearchTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Right(tTvShowList));
      return searchTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnQuerySearch(tQuery)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      SearchTvShowsLoading(),
      SearchTvShowsHasData(tTvShowList),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );

  blocTest<SearchTvShowsBloc, SearchTvShowsState>(
    'Should emit [Loading, Error] when search tv_shows is unsuccessful',
    build: () {
      when(mockSearchTvShows.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return searchTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnQuerySearch(tQuery)),
    expect: () => [
      SearchTvShowsLoading(),
      SearchTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );
}
