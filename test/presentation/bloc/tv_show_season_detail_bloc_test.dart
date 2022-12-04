import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_show_season_detail.dart';
import 'package:ditonton/presentation/bloc/tv_show_season_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import '../provider/tv_show_season_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTvShowSeasonDetail])
void main() {
  late TvShowSeasonDetailBloc tvShowDetailBloc;
  late MockGetTvShowSeasonDetail mockGetTvShowSeasonDetail;

  setUp(() {
    mockGetTvShowSeasonDetail = MockGetTvShowSeasonDetail();
    tvShowDetailBloc = TvShowSeasonDetailBloc(
      mockGetTvShowSeasonDetail,
    );
  });

  final tId = 1;
  final tSeasonNumber = 1;

  test('initial state should be empty', () {
    expect(tvShowDetailBloc.state, TvShowSeasonDetailEmpty());
  });

  blocTest<TvShowSeasonDetailBloc, TvShowSeasonDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowSeasonDetail.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Right(testTvShowSeasonDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShowSeasonDetail(tId, tSeasonNumber)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvShowSeasonDetailLoading(),
      TvShowSeasonDetailHasData(testTvShowSeasonDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvShowSeasonDetail.execute(tId, tSeasonNumber));
    },
  );

  blocTest<TvShowSeasonDetailBloc, TvShowSeasonDetailState>(
    'Should emit [Loading, Error] when fetch tv_show_seasons is unsuccessful',
    build: () {
      when(mockGetTvShowSeasonDetail.execute(tId, tSeasonNumber))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShowSeasonDetail(tId, tSeasonNumber)),
    expect: () => [
      TvShowSeasonDetailLoading(),
      TvShowSeasonDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvShowSeasonDetail.execute(tId, tSeasonNumber));
    },
  );
}
