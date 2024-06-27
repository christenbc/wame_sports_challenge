part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure }

final class HomeState extends Equatable {
  final List<Country> countries;
  final bool hasReachedMax;
  final HomeStatus status;

  const HomeState({
    this.countries = const <Country>[],
    this.hasReachedMax = false,
    this.status = HomeStatus.initial,
  });

  @override
  String toString() {
    return '''HomeState { status: $status, hasReachedMax: $hasReachedMax, countries: ${countries.length} }''';
  }

  @override
  List<Object?> get props => [countries, hasReachedMax, status];

  HomeState copyWith({
    HomeStatus? status,
    List<Country>? countries,
    bool? hasReachedMax,
  }) {
    return HomeState(
      status: status ?? this.status,
      countries: countries ?? this.countries,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
