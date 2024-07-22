import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:wame_sports_challenge_christen/blocs/blocs.dart';
import 'package:wame_sports_challenge_christen/models/models.dart';
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
  final PagingController<int, Country> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => context.read<HomeBloc>().add(FetchCountries(pageKey)));
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.status == HomeStatus.success) {
            final isLastPage = state.hasReachedMax;
            if (isLastPage) {
              _pagingController.appendLastPage(state.pagedCountries);
            } else {
              final nextPageKey = (_pagingController.itemList?.length ?? 0) + state.pagedCountries.length;
              _pagingController.appendPage(state.pagedCountries, nextPageKey);
            }
          } else if (state.status == HomeStatus.failure) {
            _pagingController.error = state.failure.message;
          }
        },
        child: RefreshIndicator(
          onRefresh: () => Future.sync(
            () => _pagingController.refresh(),
          ),
          child: PagedListView<int, Country>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<Country>(
              itemBuilder: (context, item, index) => CountryCard(country: item),
              firstPageErrorIndicatorBuilder: (context) => Text('Error: ${_pagingController.error}'),
              // newPageErrorIndicatorBuilder: (context) => Text('Error: ${_pagingController.error}'),
            ),
          ),
        ),
      ),
    );
  }
}
