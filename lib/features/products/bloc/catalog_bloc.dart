import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:creddinv_task/data/models/product.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

/// View query for the shop: search, category, saved-only, and sort.
/// The loaded catalog stays in the product bloc.
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(const CatalogState()) {
    on<CatalogSearchChanged>(_onSearch);
    on<CatalogCategorySelected>(_onCategory);
    on<CatalogSavedOnlyToggled>(_onSavedOnly);
    on<CatalogSortSelected>(_onSort);
    on<CatalogReset>(_onReset);
  }

  void _onSearch(CatalogSearchChanged event, Emitter<CatalogState> emit) {
    emit(state.copyWith(query: event.query));
  }

  void _onCategory(CatalogCategorySelected event, Emitter<CatalogState> emit) {
    emit(state.copyWith(category: event.category, savedOnly: false));
  }

  void _onSavedOnly(CatalogSavedOnlyToggled event, Emitter<CatalogState> emit) {
    final next = !state.savedOnly;
    emit(
      state.copyWith(savedOnly: next, category: next ? null : state.category),
    );
  }

  void _onSort(CatalogSortSelected event, Emitter<CatalogState> emit) {
    emit(state.copyWith(sort: event.sort));
  }

  void _onReset(CatalogReset event, Emitter<CatalogState> emit) {
    emit(const CatalogState());
  }
}
