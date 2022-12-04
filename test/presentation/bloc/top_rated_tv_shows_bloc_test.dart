import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_shows.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../provider/tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTvShows])
void main() {
  late TopRatedTvShowsBloc nowPlayingTvShowsBloc;
  late MockGetTopRatedTvShows mockGetTopRatedTvShows;

  setUp(() {
    mockGetTopRatedTvShows = MockGetTopRatedTvShows();
    nowPlayingTvShowsBloc = TopRatedTvShowsBloc(
      mockGetTopRatedTvShows,
    );
  });

  test('initial state should be empty', () {
    expect(nowPlayingTvShowsBloc.state, TopRatedTvShowsEmpty());
  });

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return nowPlayingTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShows()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TopRatedTvShowsLoading(),
      TopRatedTvShowsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );

  blocTest<TopRatedTvShowsBloc, TopRatedTvShowsState>(
    'Should emit [Loading, Error] when fetch tv_shows is unsuccessful',
    build: () {
      when(mockGetTopRatedTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return nowPlayingTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShows()),
    expect: () => [
      TopRatedTvShowsLoading(),
      TopRatedTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTvShows.execute());
    },
  );
}
