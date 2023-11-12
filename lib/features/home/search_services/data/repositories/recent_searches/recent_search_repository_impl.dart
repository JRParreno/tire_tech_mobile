import 'package:tire_tech_mobile/features/home/search_services/data/repositories/recent_searches/recent_search_repository.dart';

class RecentSearchRepositoryImpl extends RecentSearchRepository {
  @override
  List<String> getRecentSearches() {
    return recentSearches.reversed.toList();
  }

  @override
  void saveSearchString(String query) {
    recentSearches.add(query);

    if (recentSearches.length > 5) {
      recentSearches.removeAt(0);
    }
  }

  @override
  void clearRecentSearch() {
    recentSearches.clear();
  }
}
