import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wame_sports_challenge_christen/blocs/blocs.dart';
import 'package:wame_sports_challenge_christen/models/models.dart';
import 'package:wame_sports_challenge_christen/pages/pages.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({
    super.key,
    required this.country,
  });

  final Country country;

  @override
  Widget build(BuildContext context) {
    final countryName = country.name ?? '';
    final countryCode = country.code ?? '';
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<DetailBloc>(
                  create: (context) => DetailBloc()..add(FetchCountryDetails(country: country)),
                  child: DetailPage(title: countryName),
                ),
              ),
            );
          },
          child: ListTile(
            title: Text(
              countryName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            trailing: Text(
              countryCode,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}
