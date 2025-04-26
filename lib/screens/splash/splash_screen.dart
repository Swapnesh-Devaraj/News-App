import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/blocs/news_event.dart';
import '../../blocs/news_bloc.dart';
import '../listing/listing_screen.dart';
import 'package:news_app/widgets/splash_content.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    // Trigger news loading
    context.read<NewsBloc>().add(LoadNews());

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const ListingScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SplashContent(),
    );
  }
}
