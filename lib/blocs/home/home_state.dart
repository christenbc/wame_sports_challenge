part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, failure }

final class HomeState extends Equatable {
  final List<Country> pagedCountries;
  final bool hasReachedMax;
  final HomeStatus status;
  final Failure failure;

  const HomeState({
    this.pagedCountries = const <Country>[],
    this.hasReachedMax = false,
    this.status = HomeStatus.initial,
    this.failure = const Failure(),
  });

  @override
  String toString() {
    return '''HomeState { status: $status, hasReachedMax: $hasReachedMax, failure_message: ${failure.message} }''';
  }

  @override
  List<Object?> get props => [pagedCountries, hasReachedMax, status, failure];

  HomeState copyWith({
    HomeStatus? status,
    List<Country>? pagedCountries,
    bool? hasReachedMax,
    Failure? failure,
  }) {
    return HomeState(
      status: status ?? this.status,
      pagedCountries: pagedCountries ?? this.pagedCountries,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failure: failure ?? this.failure,
    );
  }
}
