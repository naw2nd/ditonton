import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_movie_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_movie_watchlist.dart';
import 'package:ditonton/domain/usecases/save_movie_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/movie_dummy_objects.dart';
import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieWatchListStatus,
  SaveMovieWatchlist,
  RemoveMovieWatchlist,
])
void main() {
  late MovieWatchlistBloc tvShowWatchlistBloc;
  late MockGetMovieWatchListStatus mockGetMovieWatchlistStatus;
  late MockSaveMovieWatchlist mockSaveMovieWatchlist;
  late MockRemoveMovieWatchlist mockRemoveMovieWatchlist;

  setUp(() {
    mockGetMovieWatchlistStatus = MockGetMovieWatchListStatus();
    mockSaveMovieWatchlist = MockSaveMovieWatchlist();
    mockRemoveMovieWatchlist = MockRemoveMovieWatchlist();

    tvShowWatchlistBloc = MovieWatchlistBloc(
      getMovieWatchlistStatus: mockGetMovieWatchlistStatus,
      saveMovieWatchlist: mockSaveMovieWatchlist,
      removeMovieWatchlist: mockRemoveMovieWatchlist,
    );
  });

  final tId = 1;

  test('initial state should be empty', () {
    expect(tvShowWatchlistBloc.state, MovieWatchlistEmpty());
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should get watchlist status',
    build: () {
      when(mockGetMovieWatchlistStatus.execute(tId))
          .thenAnswer((_) async => true);
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnGetMovieWatchlistStatus(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData(true, ''),
    ],
    verify: (bloc) {
      verify(mockGetMovieWatchlistStatus.execute(tId));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should added to movie watchlist',
    build: () {
      when(mockSaveMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return tvShowWatchlistBloc;
    },
    act: (bloc) {
      bloc.add(OnSaveMovieWatchlist(testMovieDetail));
    },
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData(true, 'Added to Watchlist'),
    ],
    verify: (bloc) {
      mockSaveMovieWatchlist.execute(testMovieDetail);
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should removed to movie watchlist',
    build: () {
      when(mockRemoveMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed to Watchlist'));
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnRemoveMovieWatchlist(testMovieDetail)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData(false, 'Removed to Watchlist'),
    ],
    verify: (bloc) {
      verify(mockRemoveMovieWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'Should emit [Loading, Error] when add watchlist movie is unsuccessful',
    build: () {
      when(mockSaveMovieWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowWatchlistBloc;
    },
    act: (bloc) => bloc.add(OnSaveMovieWatchlist(testMovieDetail)),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSaveMovieWatchlist.execute(testMovieDetail));
    },
  );
}
