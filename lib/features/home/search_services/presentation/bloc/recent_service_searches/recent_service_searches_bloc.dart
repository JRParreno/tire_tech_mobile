import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tire_tech_mobile/core/bloc/view_status.dart';
import 'package:tire_tech_mobile/features/home/search_services/data/repositories/recent_searches/recent_search_repository.dart';

part 'recent_service_searches_event.dart';
part 'recent_service_searches_state.dart';

class RecentServiceSearchesBloc
    extends Bloc<RecentServiceSearchesEvent, RecentServiceSearchesState> {
  final RecentSearchRepository _recentSearchRepository;

  RecentServiceSearchesBloc(this._recentSearchRepository)
      : super(RecentServiceSearchesState.empty()) {
    on<GetRecentSearchesEvent>(_getRecentSearchesEvent);
    on<AddRecentSearchEvent>(_addRecentSearchEvent);
    on<ClearRecentSearchEvent>(_clearRecentSearchEvent);
  }

  void _clearRecentSearchEvent(
      ClearRecentSearchEvent event, Emitter<RecentServiceSearchesState> emit) {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    try {
      _recentSearchRepository.clearRecentSearch();

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          recentSearches: [],
        ),
      );
    } catch (e) {
      emit(state.copyWith(viewStatus: ViewStatus.failed));
    }
  }

  Future<void> _getRecentSearchesEvent(GetRecentSearchesEvent event,
      Emitter<RecentServiceSearchesState> emit) async {
    emit(state.copyWith(viewStatus: ViewStatus.loading));

    try {
      await Future.delayed(const Duration(seconds: 1), () {
        final results = _recentSearchRepository.getRecentSearches();

        emit(
          state.copyWith(
            viewStatus: ViewStatus.successful,
            recentSearches: results,
          ),
        );
      });
    } catch (e) {
      emit(state.copyWith(viewStatus: ViewStatus.failed));
    }
  }

  void _addRecentSearchEvent(
      AddRecentSearchEvent event, Emitter<RecentServiceSearchesState> emit) {
    try {
      _recentSearchRepository.saveSearchString(event.query);
      final results = _recentSearchRepository.getRecentSearches();

      emit(
        state.copyWith(
          viewStatus: ViewStatus.successful,
          recentSearches: results,
        ),
      );
    } catch (e) {
      emit(state.copyWith(viewStatus: ViewStatus.failed));
    }
  }
}
