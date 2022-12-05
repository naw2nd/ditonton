import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_show_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_tv_show_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tv_show_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv_show_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import 'tv_show_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvShowWatchListStatus,
  SaveTvShowWatchlist,
  RemoveTvShowWatchlist,
])
void main() {
  late TvShowWatchlistBloc tvShowWatchlistBloc;
  late MockGetTvShowWatchListStatus mockGetTvShowWatchlistStatus;
  late MockSaveTvShowWatchlist mockSaveTvShowWatchlist;
  late MockRemoveTvShowWatchlist mockRemoveTvShowWatchlist;

  setUp(() {
    mockGetTvShowWatchlistStatus = MockGetTvShowWatchListStatus();
    mockSaveTvShowWatchlist = MockSaveTvShowWatchlist();
    mockRemoveTvShowWatchlist = MockRemoveTvShowWatchlist();

    tvShowWatchlistBloc = TvShowWatchlistBloc(
      getTvShowWatchlistStatus: mockGetTvShowWatchlistStatus,
      saveTvShowWatchlist: mockSaveTvShowWatchlist,
      removeTvShowWatchlist: mockRemoveTvShowWatchlist,
    );
  });

  final tId = 1;

  test('initial state should be empty', () {
    expect(tvShowWatchlistBloc.state, TvShowWatchlistEmpty());
  });

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should get watchlist status',
    build: () {
      when(mockGetTvShowWatchlistStatus.execute(tId))
          .thenAnswer((_) async => true);
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnGetTvShowWatchlistStatus(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvShowWatchlistLoading(),
      TvShowWatchlistHasData(true, ''),
    ],
    verify: (bloc) {
      verify(mockGetTvShowWatchlistStatus.execute(tId));
    },
  );

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should added to tv_show watchlist',
    build: () {
      when(mockSaveTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return tvShowWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnSaveTvShowWatchlist(testTvShowDetail));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvShowWatchlistLoading(),
      TvShowWatchlistHasData(true, 'Added to Watchlist'),
    ],
    verify: (bloc) {
      mockSaveTvShowWatchlist.execute(testTvShowDetail);
    },
  );

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should removed to tv_show watchlist',
    build: () {
      when(mockRemoveTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed to Watchlist'));
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveTvShowWatchlist(testTvShowDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvShowWatchlistLoading(),
      TvShowWatchlistHasData(false, 'Removed to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveTvShowWatchlist.execute(testTvShowDetail));
    },
  );

  blocTest<TvShowWatchlistBloc, TvShowWatchlistState>(
    'Should emit [Loading, Error] when add watchlist tv_show is unsuccessful',
    build: () {
      when(mockSaveTvShowWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSaveTvShowWatchlist(testTvShowDetail)),
    expect: () => [
      TvShowWatchlistLoading(),
      TvShowWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveTvShowWatchlist.execute(testTvShowDetail));
    },
  );
}
