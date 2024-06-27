import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:wame_sports_challenge_christen/api/api.dart';
import 'package:wame_sports_challenge_christen/models/models.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchCountries>(_onCountriesFetched);
  }

  Future<void> _onCountriesFetched(FetchCountries event, Emitter<HomeState> emit) async {
    try {
      if (state.status == HomeStatus.initial) {
        final countries = await RapidAPI.fetchCountries();
        return emit(state.copyWith(
          status: HomeStatus.success,
          countries: countries,
        ));
      }
    } catch (_) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
