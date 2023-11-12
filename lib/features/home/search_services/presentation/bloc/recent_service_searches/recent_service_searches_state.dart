part of 'recent_service_searches_bloc.dart';

class RecentServiceSearchesState extends Equatable {
  const RecentServiceSearchesState({
    required this.recentSearches,
    this.viewStatus = ViewStatus.none,
  });

  final List<String> recentSearches;
  final ViewStatus viewStatus;

  factory RecentServiceSearchesState.empty() {
    return const RecentServiceSearchesState(
      recentSearches: [],
      viewStatus: ViewStatus.none,
    );
  }

  @override
  List<Object> get props => [
        recentSearches,
        viewStatus,
      ];

  RecentServiceSearchesState copyWith({
    List<String>? recentSearches,
    ViewStatus? viewStatus,
  }) {
    return RecentServiceSearchesState(
      recentSearches: recentSearches ?? this.recentSearches,
      viewStatus: viewStatus ?? this.viewStatus,
    );
  }
}
