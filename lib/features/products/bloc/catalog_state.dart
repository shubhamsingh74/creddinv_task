part of 'catalog_bloc.dart';

const Object _keepCategory = Object();

final class CatalogState extends Equatable {
  const CatalogState({
    this.query = '',
    this.category,
    this.savedOnly = false,
    this.sort = CatalogSort.featured,
  });

  final String query;
  final String? category;
  final bool savedOnly;
  final CatalogSort sort;

  bool get isFiltering =>
      query.trim().isNotEmpty || category != null || savedOnly;

  List<Product> apply(List<Product> products, Set<String> savedIds) {
    final needle = query.trim().toLowerCase();
    final matched = <Product>[
      for (final product in products)
        if (_matches(product, needle, savedIds)) product,
    ];

    final sorted = [...matched];
    switch (sort) {
      case CatalogSort.featured:
        break;
      case CatalogSort.priceAscending:
        sorted.sort((a, b) => a.priceInCents.compareTo(b.priceInCents));
      case CatalogSort.priceDescending:
        sorted.sort((a, b) => b.priceInCents.compareTo(a.priceInCents));
    }
    return List.unmodifiable(sorted);
  }

  CatalogState copyWith({
    String? query,
    Object? category = _keepCategory,
    bool? savedOnly,
    CatalogSort? sort,
  }) {
    return CatalogState(
      query: query ?? this.query,
      category: identical(category, _keepCategory)
          ? this.category
          : category as String?,
      savedOnly: savedOnly ?? this.savedOnly,
      sort: sort ?? this.sort,
    );
  }

  bool _matches(Product product, String needle, Set<String> savedIds) {
    final matchesSaved = !savedOnly || savedIds.contains(product.id);
    final matchesCategory = category == null || product.category == category;
    if (!matchesSaved || !matchesCategory) return false;
    if (needle.isEmpty) return true;
    final haystack =
        '${product.name} ${product.description} ${product.category}'
            .toLowerCase();
    return haystack.contains(needle);
  }

  @override
  List<Object?> get props => [query, category, savedOnly, sort];
}
