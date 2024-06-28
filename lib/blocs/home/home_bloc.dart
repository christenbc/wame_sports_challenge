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
const throttleDuration = Duration(milliseconds: 1500);

// This will prevent spamming the API from the UI.
// Any events added while an event is processing are ignored.
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
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

  @override
  HomeState? fromJson(Map<String, dynamic> json) {
    try {
      return HomeState(
        countries: (json['countries'] as List).map((e) => Country.fromJson(e)).toList(),
        hasReachedMax: json['hasReachedMax'] as bool,
        status: HomeStatus.values[json['status'] as int],
        failure: Failure(message: json['failure_message'] as String),
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(HomeState state) {
    try {
      return {
        'countries': state.countries.map((e) => e.toJson()).toList(),
        'hasReachedMax': state.hasReachedMax,
        'status': state.status.index,
        'failure_message': state.failure.message,
      };
    } catch (_) {
      return null;
    }
  }
}
