import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_shows.dart';
import 'package:ditonton/presentation/bloc/now_playing_tv_shows/now_playing_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import 'now_playing_tv_shows_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvShows])
void main() {
  late NowPlayingTvShowsBloc nowPlayingTvShowsBloc;
  late MockGetNowPlayingTvShows mockGetNowPlayingTvShows;

  setUp(() {
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    nowPlayingTvShowsBloc = NowPlayingTvShowsBloc(
      getNowPlayingTvShows: mockGetNowPlayingTvShows,
    );
  });


  test('initial state should be empty', () {
    expect(nowPlayingTvShowsBloc.state, NowPlayingTvShowsEmpty());
  });

  blocTest<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return nowPlayingTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchNowPlayingTvShows()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      NowPlayingTvShowsLoading(),
      NowPlayingTvShowsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvShows.execute());
    },
  );

  blocTest<NowPlayingTvShowsBloc, NowPlayingTvShowsState>(
    'Should emit [Loading, Error] when fetch tv_shows is unsuccessful',
    build: () {
      when(mockGetNowPlayingTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchNowPlayingTvShows()),
    expect: () => [
      NowPlayingTvShowsLoading(),
      NowPlayingTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingTvShows.execute());
    },
  );
}
