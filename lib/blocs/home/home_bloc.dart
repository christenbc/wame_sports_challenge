import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:wame_sports_challenge_christen/api/api.dart';
import 'package:wame_sports_challenge_christen/models/models.dart';
import 'package:stream_transform/stream_transform.dart';

part 'home_event.dart';
part 'home_state.dart';

// The [basic](https://rapidapi.com/wirefreethought/api/geodb-cities/pricing) tier of the selected API only allows 1 request per second
const throttleDuration = Duration(milliseconds: 1000);

// This will prevent spamming the API from the UI.
// Any events added while an event is processing are ignored.
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<FetchCountries>(
      _onCountriesFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onCountriesFetched(FetchCountries event, Emitter<HomeState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == HomeStatus.initial) {
        final countries = await RapidAPI.fetchCountries();
        return emit(state.copyWith(
          status: HomeStatus.success,
          countries: countries,
          hasReachedMax: false,
        ));
      }
      final countries = await RapidAPI.fetchCountries(offset: state.countries.length);
      emit(countries.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: HomeStatus.success,
              countries: List.of(state.countries)..addAll(countries),
              hasReachedMax: false,
            ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.failure,
        failure: Failure(message: 'Countries could not be fetched. Reason: $e'),
      ));
    }
  }
}
