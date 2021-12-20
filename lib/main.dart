import 'package:demo_application/providers/currrency-provider.dart';
import 'package:demo_application/screens/home-screen/home-screen.dart';
import 'package:demo_application/screens/detail-screen/detail-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CurrrencyProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        backgroundColor: Colors.white,
      ),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(title: 'ARMKub'),
        DetailScreen.routeName: (context) => const DetailScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
