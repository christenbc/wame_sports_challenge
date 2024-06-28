import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wame_sports_challenge_christen/api/api.dart';
import 'package:wame_sports_challenge_christen/models/models.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(const DetailState()) {
    on<FetchCountryDetails>(_onCountryDetailsFetched);
  }

  Future<void> _onCountryDetailsFetched(FetchCountryDetails event, Emitter<DetailState> emit) async {
    try {
      if (state.status == DetailStatus.initial) {
        final countries = await RapidAPI.fetchCountryDetails(country: event.country);
        return emit(state.copyWith(
          status: DetailStatus.success,
          countryDetails: countries,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: DetailStatus.failure,
        failure: Failure(message: 'Country\'s details could not be fetched. Reason: $e'),
      ));
    }
  }
}
