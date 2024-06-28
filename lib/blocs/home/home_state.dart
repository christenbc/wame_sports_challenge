part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure }

final class HomeState extends Equatable {
  final List<Country> countries;
  final bool hasReachedMax;
  final HomeStatus status;
  final Failure failure;

  const HomeState({
    this.countries = const <Country>[],
    this.hasReachedMax = false,
    this.status = HomeStatus.initial,
    this.failure = const Failure(),
  });

  @override
  String toString() {
    return '''HomeState { status: $status, hasReachedMax: $hasReachedMax, countries: ${countries.length}, failure_message: ${failure.message} }''';
  }

  @override
  List<Object?> get props => [countries, hasReachedMax, status, failure];

  HomeState copyWith({
    HomeStatus? status,
    List<Country>? countries,
    bool? hasReachedMax,
    Failure? failure,
  }) {
    return HomeState(
      status: status ?? this.status,
      countries: countries ?? this.countries,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      failure: failure ?? this.failure,
    );
  }
}
