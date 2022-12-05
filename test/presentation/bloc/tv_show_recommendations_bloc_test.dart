import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:ditonton/presentation/bloc/tv_show_recommendations/tv_show_recommendations_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import 'tv_show_recommendations_bloc_test.mocks.dart';


@GenerateMocks([GetTvShowRecommendations])
void main() {
  late TvShowRecommendationsBloc popularTvShowsBloc;
  late MockGetTvShowRecommendations mockGetTvShowRecommendations;

  setUp(() {
    mockGetTvShowRecommendations = MockGetTvShowRecommendations();
    popularTvShowsBloc = TvShowRecommendationsBloc(
      getTvShowRecommendations: mockGetTvShowRecommendations,
    );
  });

  final tId = 1;

  test('initial state should be empty', () {
    expect(popularTvShowsBloc.state, TvShowRecommendationsEmpty());
  });

  blocTest<TvShowRecommendationsBloc, TvShowRecommendationsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Right(testTvShowList));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShowRecommendatios(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvShowRecommendationsLoading(),
      TvShowRecommendationsHasData(testTvShowList),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(tId));
    },
  );

  blocTest<TvShowRecommendationsBloc, TvShowRecommendationsState>(
    'Should emit [Loading, Error] when fetch tv_show recommendations is unsuccessful',
    build: () {
      when(mockGetTvShowRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return popularTvShowsBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShowRecommendatios(tId)),
    expect: () => [
      TvShowRecommendationsLoading(),
      TvShowRecommendationsError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvShowRecommendations.execute(tId));
    },
  );
}
