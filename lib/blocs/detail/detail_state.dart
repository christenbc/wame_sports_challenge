part of 'detail_bloc.dart';

enum DetailStatus { initial, success, failure }

class DetailState extends Equatable {
  final CountryDetails? countryDetails;
  final DetailStatus status;

  const DetailState({
    this.countryDetails,
    this.status = DetailStatus.initial,
  });

  @override
  String toString() {
    return '''DetailState { status: $status, countryDetails: $countryDetails }''';
  }

  @override
  List<Object?> get props => [countryDetails, status];

  DetailState copyWith({
    CountryDetails? countryDetails,
    DetailStatus? status,
  }) {
    return DetailState(
      countryDetails: countryDetails ?? this.countryDetails,
      status: status ?? this.status,
    );
  }
}
