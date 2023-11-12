abstract class RecentSearchRepository {
  List<String> recentSearches = [];

  List<String> getRecentSearches();
  void saveSearchString(String query);
  void clearRecentSearch();
}
