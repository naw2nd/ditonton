import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_shows.dart';
import 'package:ditonton/presentation/bloc/popular_tv_shows_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../provider/tv_show_list_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late PopularTvShowsBloc popularTvShowsBloc;
  late MockGetPopularTvShows mockGetPopularTvShows;

  setUp(() {
    mockGetPopularTvShows = MockGetPopularTvShows();
    popularTvShowsBloc = PopularTvShowsBloc(
      mockGetPopularTvShows,
    );
  });


  test('initial state should be empty', () {
    expect(popularTvShowsBloc.state, PopularTvShowsEmpty());
  });

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShows()),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      PopularTvShowsLoading(),
      PopularTvShowsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );

  blocTest<PopularTvShowsBloc, PopularTvShowsState>(
    'Should emit [Loading, Error] when fetch tv_shows is unsuccessful',
    build: () {
      when(mockGetPopularTvShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShows()),
    expect: () => [
      PopularTvShowsLoading(),
      PopularTvShowsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvShows.execute());
    },
  );
}
