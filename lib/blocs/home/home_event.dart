part of 'home_bloc.dart';

@immutable
sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class FetchCountries extends HomeEvent {}

final class PaginateCountries extends HomeEvent {
  // TODO
}
