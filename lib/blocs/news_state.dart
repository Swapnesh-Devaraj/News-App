import 'package:equatable/equatable.dart';
import '../models/news_model.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsModel> news;
  final bool hasReachedMax;
  final int totalFound;

  const NewsLoaded({
    required this.news,
    required this.hasReachedMax,
    required this.totalFound,
  });

  NewsLoaded copyWith({
    List<NewsModel>? news,
    bool? hasReachedMax,
    int? totalFound,
  }) {
    return NewsLoaded(
      news: news ?? this.news,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      totalFound: totalFound ?? this.totalFound,
    );
  }

  @override
  List<Object> get props => [news, hasReachedMax, totalFound];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object> get props => [message];
}
