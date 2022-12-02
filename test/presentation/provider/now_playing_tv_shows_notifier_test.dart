import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_now_playing_tv_shows.dart';
import 'package:ditonton/presentation/provider/now_playing_tv_shows_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'now_playing_tv_shows_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvShows])
void main() {
  late MockGetNowPlayingTvShows mockGetNowPlayingTvShows;
  late NowPlayingTvShowsNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTvShows = MockGetNowPlayingTvShows();
    notifier = NowPlayingTvShowsNotifier(mockGetNowPlayingTvShows)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvShow = TvShow(
    posterPath: 'backdropPath',
    id: 1,
    name: 'name',
    overview: 'overview',
    voteAverage: 3.0,
  );

  final tTvShowList = <TvShow>[tTvShow];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetNowPlayingTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change tvShows data when data is gotten successfully', () async {
    // arrange
    when(mockGetNowPlayingTvShows.execute())
        .thenAnswer((_) async => Right(tTvShowList));
    // act
    await notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvShows, tTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetNowPlayingTvShows.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchNowPlayingTvShows();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
