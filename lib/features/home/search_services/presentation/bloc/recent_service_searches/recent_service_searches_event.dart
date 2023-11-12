part of 'recent_service_searches_bloc.dart';

@immutable
class RecentServiceSearchesEvent extends Equatable {
  const RecentServiceSearchesEvent();

  @override
  List<Object> get props => [];
}

class GetRecentSearchesEvent extends RecentServiceSearchesEvent {}

class AddRecentSearchEvent extends RecentServiceSearchesEvent {
  final String query;
  const AddRecentSearchEvent(this.query);

  @override
  List<Object> get props => [query];
}

class ClearRecentSearchEvent extends RecentServiceSearchesEvent {}
