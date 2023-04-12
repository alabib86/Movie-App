import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app/Providers/favourite_provider.dart';
import 'package:movies_app/Providers/latest_movies_provider.dart';
import 'package:movies_app/Providers/top_rated_movies_provider.dart';
import 'package:provider/provider.dart';
import 'Providers/comparison_provider.dart';
import 'Providers/upcoming_movies_provider.dart';
import 'Screens/home_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UpcomingMoviesProvider()),
          ChangeNotifierProvider(create: (context) => TopRatedProvider()),
          ChangeNotifierProvider(create: (context) => LatestMoviesProvider()),
          ChangeNotifierProvider(create: (context) => FavouriteProvider()),
          ChangeNotifierProvider(create: (context) => ComparisonProvider()),
        ],
        child: MaterialApp(
          title: 'Movies App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashScreen(),
        ));
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    FavouriteProvider();
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => const MyHomePage(title: 'Movies App'),
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}
