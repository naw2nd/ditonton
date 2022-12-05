import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_show_detail.dart';
import 'package:ditonton/presentation/bloc/tv_show_detail/tv_show_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/tv_show_dummy_objects.dart';
import 'tv_show_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvShowDetail])
void main() {
  late TvShowDetailBloc tvShowDetailBloc;
  late MockGetTvShowDetail mockGetTvShowDetail;

  setUp(() {
    mockGetTvShowDetail = MockGetTvShowDetail();
    tvShowDetailBloc = TvShowDetailBloc(
      getTvShowDetail: mockGetTvShowDetail,
    );
  });

  final tId = 1;

  test('initial state should be empty', () {
    expect(tvShowDetailBloc.state, TvShowDetailEmpty());
  });

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShowDetail(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailHasData(testTvShowDetail),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(tId));
    },
  );

  blocTest<TvShowDetailBloc, TvShowDetailState>(
    'Should emit [Loading, Error] when fetch tv_shows is unsuccessful',
    build: () {
      when(mockGetTvShowDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvShowDetailBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvShowDetail(tId)),
    expect: () => [
      TvShowDetailLoading(),
      TvShowDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvShowDetail.execute(tId));
    },
  );
}
