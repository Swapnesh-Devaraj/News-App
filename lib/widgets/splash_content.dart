import 'package:flutter/material.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.newspaper,
            size: 100,
            color: Colors.blue,
          ),
          SizedBox(height: 24),
          Text(
            'News App',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
