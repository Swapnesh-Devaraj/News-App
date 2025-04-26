import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class LoadNews extends NewsEvent {}

class LoadMoreNews extends NewsEvent {
  final int page;
  final int pageSize;

  const LoadMoreNews({required this.page, required this.pageSize});

  @override
  List<Object> get props => [page, pageSize];
}

class RefreshNews extends NewsEvent {}
