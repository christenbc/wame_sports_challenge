import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wame_sports_challenge_christen/api/api.dart';
import 'package:wame_sports_challenge_christen/blocs/blocs.dart';
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
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Countries could not be fetched'),
              backgroundColor: Colors.red,
            ));
          } else if (state.status == HomeStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Countries fetched successfully'),
              duration: Duration(seconds: 1),
            ));
          }
        },
        builder: (context, state) {
          final countries = state.countries;
          return ListView.builder(
            itemCount: countries.length,
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final country = countries[index];
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Card(
                  child: ListTile(
                    title: Text(
                      country.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    trailing: Text(
                      country.code ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
