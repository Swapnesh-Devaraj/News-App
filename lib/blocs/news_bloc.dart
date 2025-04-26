import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';
import '../repositories/news_repository.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;
  static const int _pageSize = 20;

  NewsBloc({required this.repository}) : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
    on<LoadMoreNews>(_onLoadMoreNews);
    on<RefreshNews>(_onRefreshNews);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    await emit.forEach<NewsResponse>(
      repository.getNewsWithCacheFirst(page: 1, pageSize: _pageSize),
      onData: (response) => NewsLoaded(
        news: response.news,
        hasReachedMax: response.news.length >= response.totalFound ||
            response.hasLimitWarning,
        totalFound: response.totalFound,
      ),
      onError: (error, stackTrace) => NewsError(error.toString()),
    );
  }

  Future<void> _onLoadMoreNews(
      LoadMoreNews event, Emitter<NewsState> emit) async {
    try {
      if (state is NewsLoaded) {
        final currentState = state as NewsLoaded;
        if (currentState.hasReachedMax) return;

        final response = await repository.getNews(
          page: event.page,
          pageSize: event.pageSize,
        );

        if (response.news.isEmpty) {
          emit(currentState.copyWith(hasReachedMax: true));
          return;
        }

        final newNews = [...currentState.news, ...response.news];
        final hasReachedMax =
            newNews.length >= response.totalFound || response.hasLimitWarning;

        emit(NewsLoaded(
          news: newNews,
          hasReachedMax: hasReachedMax,
          totalFound: response.totalFound,
        ));
      }
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }

  Future<void> _onRefreshNews(
      RefreshNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    try {
      final response = await repository.getNews(page: 1, pageSize: _pageSize);
      emit(NewsLoaded(
        news: response.news,
        hasReachedMax: response.news.length >= response.totalFound ||
            response.hasLimitWarning,
        totalFound: response.totalFound,
      ));
    } catch (e) {
      emit(NewsError(e.toString()));
    }
  }
}
