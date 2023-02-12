import 'package:flutter/material.dart';
import 'package:image_showcase_application/provider/image_provider.dart';
import 'package:image_showcase_application/screen/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ListenableProvider(
      create:  (context) => ApiImageProvider(),
      child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    ),
      );
  }
}

