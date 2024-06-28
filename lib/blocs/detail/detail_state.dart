part of 'detail_bloc.dart';

enum DetailStatus { initial, success, failure }

class DetailState extends Equatable {
  final CountryDetails? countryDetails;
  final DetailStatus status;
  final Failure failure;

  const DetailState({
    this.countryDetails,
    this.status = DetailStatus.initial,
    this.failure = const Failure(),
  });

  @override
  String toString() {
    return '''DetailState { status: $status, countryDetails: $countryDetails, failure_message: ${failure.message} }''';
  }

  @override
  List<Object?> get props => [countryDetails, status];

  DetailState copyWith({
    CountryDetails? countryDetails,
    DetailStatus? status,
    Failure? failure,
  }) {
    return DetailState(
      countryDetails: countryDetails ?? this.countryDetails,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
