library movies;

export 'package:movies/presentation/bloc/now_playing_movies/now_playing_movies_bloc.dart';
export 'package:movies/presentation/bloc/popular_movies/popular_movies_bloc.dart';
export 'package:movies/presentation/bloc/search_movies/search_movies_bloc.dart';
export 'package:movies/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
export 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
export 'package:movies/presentation/bloc/movie_recommendations/movie_recommendations_bloc.dart';
export 'package:movies/presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';
export 'package:movies/presentation/bloc/watchlist_movies/watchlist_movies_bloc.dart';

export 'package:movies/presentation/pages/popular_movies_page.dart';
export 'package:movies/presentation/pages/top_rated_movies_page.dart';
export 'package:movies/presentation/pages/movie_dashboard_page.dart';
export 'package:movies/presentation/pages/movie_detail_page.dart';

export 'package:movies/presentation/widgets/movie_card.dart';

export 'package:movies/domain/usecases/get_now_playing_movies.dart';
export 'package:movies/domain/usecases/get_popular_movies.dart';
export 'package:movies/domain/usecases/get_top_rated_movies.dart';
export 'package:movies/domain/usecases/get_movie_detail.dart';
export 'package:movies/domain/usecases/get_movie_recommendations.dart';
export 'package:movies/domain/usecases/get_movie_watchlist_status.dart';
export 'package:movies/domain/usecases/get_watchlist_movies.dart';
export 'package:movies/domain/usecases/remove_movie_watchlist.dart';
export 'package:movies/domain/usecases/save_movie_watchlist.dart';
export 'package:movies/domain/usecases/search_movies.dart';

export 'package:movies/domain/repositories/movie_repository.dart';
export 'package:movies/data/datasources/movie_local_data_source.dart';
export 'package:movies/data/datasources/movie_remote_data_source.dart';

export 'package:movies/data/repositories/movie_repository_impl.dart';

export 'package:movies/data/models/movie_table.dart';
