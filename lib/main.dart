import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'views/tv_home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live TV Streaming',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const TvHomeView(),
    );
  }
}