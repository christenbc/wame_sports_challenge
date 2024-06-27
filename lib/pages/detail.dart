import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wame_sports_challenge_christen/blocs/blocs.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: BlocConsumer<DetailBloc, DetailState>(
          listener: (context, state) {
            if (state.status == DetailStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$title\'s details  could not be fetched'),
                backgroundColor: Colors.red,
              ));
            } else if (state.status == DetailStatus.success) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('$title\'s details fetched successfully'),
                duration: const Duration(seconds: 1),
              ));
            }
          },
          builder: (context, state) {
            final countryDetails = state.countryDetails;
            final flagUrl = countryDetails?.flagImageUri;
            return Column(
              children: [
                ListTile(
                  title: const Text('Capital'),
                  trailing: Text(countryDetails?.capital ?? ''),
                ),
                ListTile(
                  title: const Text('Number of regions'),
                  trailing: Text(countryDetails?.numRegions?.toString() ?? ''),
                ),
                ListTile(
                  title: const Text('Calling code'),
                  trailing: Text(countryDetails?.callingCode ?? ''),
                ),
                if (flagUrl?.isNotEmpty == true)
                  if (flagUrl!.endsWith('svg'))
                    SvgPicture.network(
                      flagUrl,
                      alignment: Alignment.topCenter,
                      // height: 120,
                      placeholderBuilder: (BuildContext context) => Container(
                        padding: const EdgeInsets.all(30.0),
                        child: const CircularProgressIndicator(),
                      ),
                    )
                  else
                    Image.network(
                      flagUrl,
                      alignment: Alignment.topCenter,
                      // height: 120,
                    ),
              ],
            );
          },
        ),
      ),
    );
  }
}
