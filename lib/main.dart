import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/news_bloc.dart';
import 'repositories/news_repository.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  // await dotenv.load(fileName: ".env");

  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(repository: NewsRepository(prefs)));
}

class MyApp extends StatelessWidget {
  final NewsRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(repository: repository),
      child: MaterialApp(
        title: 'News App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
