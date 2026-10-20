import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.priceInCents,
    required this.imageAsset,
    required this.category,
    required this.fabric,
    required this.fit,
  }) : assert(priceInCents >= 0, 'Price cannot be negative');

  final String id;
  final String name;
  final String description;

  /// USD minor units. Avoid floating-point money.
  final int priceInCents;
  final String imageAsset;
  final String category;
  final String fabric;
  final String fit;

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    priceInCents,
    imageAsset,
    category,
    fabric,
    fit,
  ];
}
