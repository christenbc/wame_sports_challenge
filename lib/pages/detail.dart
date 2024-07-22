import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wame_sports_challenge_christen/blocs/blocs.dart';
import 'package:wame_sports_challenge_christen/pages/home/widgets/widgets.dart';

class DetailPage extends StatelessWidget {
  /// An page which displays additional information about the country
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
                content: Text(state.failure.message ?? '$title\'s details  could not be fetched'),
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
                Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: IntrinsicColumnWidth(),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        const PaddedTableCell(child: Text('Capital')),
                        PaddedTableCell(child: Text(countryDetails?.capital ?? '')),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        const PaddedTableCell(child: Text('Number of regions')),
                        PaddedTableCell(child: Text(countryDetails?.numRegions?.toString() ?? '')),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        const PaddedTableCell(child: Text('Calling code')),
                        PaddedTableCell(child: Text(countryDetails?.callingCode ?? '')),
                      ],
                    ),
                  ],
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
