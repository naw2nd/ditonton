import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv_shows/domain/entities/tv_show.dart';
import 'package:tv_shows/domain/usecases/search_tv_shows.dart';
import 'package:tv_shows/presentation/bloc/search_tv_shows/search_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([SearchTvShows])
void main() {
  late SearchTvShowsBloc searchTvShowsBloc;
  late MockSearchTvShows mockSearchTvShows;

  setUp(() {
    mockSearchTvShows = MockSearchTvShows();
    searchTvShowsBloc = SearchTvShowsBloc(
      searchTvShows: mockSearchTvShows,
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
  const tQuery = 'name';

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
    act: (bloc) => bloc.add(OnQuerySearchTvShows(tQuery)),
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
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnQuerySearchTvShows(tQuery)),
    expect: () => [
      SearchTvShowsLoading(),
      const SearchTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTvShows.execute(tQuery));
    },
  );
}
