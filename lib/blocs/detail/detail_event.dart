part of 'detail_bloc.dart';

sealed class DetailEvent extends Equatable {
  const DetailEvent();

  @override
  List<Object> get props => [];
}

final class FetchCountryDetails extends DetailEvent {
  final Country country;

  const FetchCountryDetails({required this.country});
}
