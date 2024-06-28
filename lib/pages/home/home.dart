import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wame_sports_challenge_christen/blocs/blocs.dart';
import 'package:wame_sports_challenge_christen/pages/home/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  /// An infinite scrollable page where countries all around the world
  /// are listed alphabetically.
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) context.read<HomeBloc>().add(FetchCountries());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.failure.message ?? 'Countries could not be fetched'),
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

          return state.status == HomeStatus.initial
              ? const Center(child: CircularProgressIndicator())
              : state.status == HomeStatus.failure
                  ? const Center(child: Text('Failed to fetch countries'))
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: countries.length,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return index >= countries.length
                            ? const CircularProgressIndicator.adaptive()
                            : CountryCard(country: country);
                      },
                    );
        },
      ),
    );
  }
}
