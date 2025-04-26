import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import '../../blocs/news_bloc.dart';
import '../../models/news_model.dart';
import '../details/details_screen.dart';
import 'news_card.dart';
import 'package:news_app/widgets/shimmers/shimmer_news_card.dart';
import 'package:news_app/blocs/news_event.dart';
import 'package:news_app/blocs/news_state.dart';
import 'package:news_app/widgets/error_view.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({super.key});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent / 2) {
      _loadMoreNews();
    }
  }

  void _loadMoreNews() {
    final state = context.read<NewsBloc>().state;
    if (state is NewsLoaded && !state.hasReachedMax) {
      _currentPage++;
      context.read<NewsBloc>().add(
            LoadMoreNews(page: _currentPage, pageSize: 20),
          );
    }
  }

  Future<void> _refreshNews() async {
    context.read<NewsBloc>().add(RefreshNews());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsInitial) {
              return _buildLoadingView();
            }

            if (state is NewsError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context.read<NewsBloc>().add(LoadNews());
                },
              );
            }

            if (state is NewsLoaded) {
              return GridView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.news.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.news.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final news = state.news[index];
                  return NewsCard(news: news);
                },
              );
            }

            return _buildLoadingView();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: 6, // Show 6 shimmer cards while loading
      itemBuilder: (context, index) {
        return const ShimmerNewsCard();
      },
    );
  }
}
