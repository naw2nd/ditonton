import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/common/failure.dart';
import 'package:tv_shows/domain/usecases/get_watchlist_tv_shows.dart';
import 'package:tv_shows/presentation/bloc/watchlist_tv_shows/watchlist_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import 'watchlist_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late WatchlistTvShowsBloc watchlistTvShowsBloc;
  late MockGetWatchlistTvShows mockGetWatchlistTvShows;

  setUp(() {
    mockGetWatchlistTvShows = MockGetWatchlistTvShows();
    watchlistTvShowsBloc = WatchlistTvShowsBloc(
      getWatchlistTvShows: mockGetWatchlistTvShows,
    );
  });

  test('initial state should be empty', () {
    expect(watchlistTvShowsBloc.state, WatchlistTvShowsEmpty());
  });

  blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return watchlistTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchWatchlistTvShows()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      WatchlistTvShowsLoading(),
      WatchlistTvShowsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );

  blocTest<WatchlistTvShowsBloc, WatchlistTvShowsState>(
    'Should emit [Loading, Error] when fetch watchlist tv_shows is unsuccessful',
    build: () {
      when(mockGetWatchlistTvShows.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return watchlistTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchWatchlistTvShows()),
    expect: () => [
      WatchlistTvShowsLoading(),
      const WatchlistTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvShows.execute());
    },
  );
}
