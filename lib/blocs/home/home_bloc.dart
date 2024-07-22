import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:wame_sports_challenge_christen/api/api.dart';
import 'package:wame_sports_challenge_christen/models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchCountries>(_onCountriesFetched);
  }

  static const _pageSize = 5;

  Future<void> _onCountriesFetched(FetchCountries event, Emitter<HomeState> emit) async {
    if (state.hasReachedMax) return;
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final newCountries = await RapidAPI.fetchCountries(offset: event.pageKey, pageSize: _pageSize);
      final isLastPage = newCountries.length < _pageSize;
      emit(state.copyWith(
        status: HomeStatus.success,
        pagedCountries: newCountries,
        hasReachedMax: isLastPage,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        failure: Failure(message: 'Countries could not be fetched. Reason: $e'),
      ));
    }
  }
}
