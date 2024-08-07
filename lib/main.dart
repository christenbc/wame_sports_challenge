import 'package:flutter/material.dart';
import 'package:wame_sports_challenge_christen/api/api.dart';
import 'package:wame_sports_challenge_christen/blocs/blocs.dart';
import 'package:wame_sports_challenge_christen/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RapidAPI.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wame Sports Challenge Christen',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        useMaterial3: true,
      ),
      home: BlocProvider<HomeBloc>(
        create: (context) => HomeBloc(),
        child: const HomePage(title: 'Countries of the world'),
      ),
    );
  }
}
