import 'package:flutter/material.dart';
import 'package:wame_sports_challenge_christen/api/api.dart';
import 'package:wame_sports_challenge_christen/models/models.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () => RapidAPI.fetchCountries(),
            child: const Text('Fetch countries'),
          ),
          ElevatedButton(
            onPressed: () => RapidAPI.fetchCountryDetails(country: const Country(code: "US")),
            child: const Text('Fetch country details'),
          )
        ],
      ),
    );
  }
}
