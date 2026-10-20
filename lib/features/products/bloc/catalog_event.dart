part of 'catalog_bloc.dart';

enum CatalogSort { featured, priceAscending, priceDescending }

sealed class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}

final class CatalogSearchChanged extends CatalogEvent {
  const CatalogSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

final class CatalogCategorySelected extends CatalogEvent {
  const CatalogCategorySelected(this.category);

  final String? category;

  @override
  List<Object?> get props => [category];
}

final class CatalogSavedOnlyToggled extends CatalogEvent {
  const CatalogSavedOnlyToggled();
}

final class CatalogSortSelected extends CatalogEvent {
  const CatalogSortSelected(this.sort);

  final CatalogSort sort;

  @override
  List<Object?> get props => [sort];
}

final class CatalogReset extends CatalogEvent {
  const CatalogReset();
}
