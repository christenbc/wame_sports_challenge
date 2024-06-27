part of 'home_bloc.dart';

enum HomeStatus { initial, success, failure }

final class HomeState extends Equatable {
  final List<Country> countries;

  final HomeStatus status;

  const HomeState({
    this.countries = const <Country>[],
    this.status = HomeStatus.initial,
  });

  @override
  String toString() {
    return '''HomeState { status: $status,  countries: ${countries.length} }''';
  }

  @override
  List<Object?> get props => [countries, status];

  HomeState copyWith({
    HomeStatus? status,
    List<Country>? countries,
  }) {
    return HomeState(
      status: status ?? this.status,
      countries: countries ?? this.countries,
    );
  }
}
