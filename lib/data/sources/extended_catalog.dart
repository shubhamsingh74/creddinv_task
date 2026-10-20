import 'package:creddinv_task/data/models/product.dart';

/// Later arrivals. Prices stay between the tote and the wrap coat so featured
/// sort extremes do not move.
abstract final class ExtendedCatalog {
  static const products = <Product>[
    Product(
      id: 'ivory-crew-tee',
      name: 'Ivory Crew Tee',
      description:
          'Midweight jersey tee with a set-in sleeve and a clean neck.',
      priceInCents: 3600,
      imageAsset: 'assets/images/ivory_tee.jpg',
      category: 'Tops',
      fabric: 'Cotton jersey',
      fit: 'Regular',
    ),
    Product(
      id: 'patched-indigo-jeans',
      name: 'Patched Indigo Jeans',
      description:
          'Straight indigo denim with a knee opening and sewn patches.',
      priceInCents: 8200,
      imageAsset: 'assets/images/indigo_jeans.jpg',
      category: 'Bottoms',
      fabric: 'Cotton denim',
      fit: 'Straight',
    ),
    Product(
      id: 'crimson-ball-gown',
      name: 'Crimson Ball Gown',
      description: 'Sleeveless gown with a fitted bodice and a full skirt.',
      priceInCents: 18400,
      imageAsset: 'assets/images/crimson_gown.jpg',
      category: 'Dresses',
      fabric: 'Satin',
      fit: 'Full skirt',
    ),
    Product(
      id: 'check-scarf',
      name: 'Check Scarf',
      description: 'Long check scarf in camel, ink, and cream.',
      priceInCents: 3200,
      imageAsset: 'assets/images/check_scarf.jpg',
      category: 'Accessories',
      fabric: 'Woven wool',
      fit: 'Wrap',
    ),
    Product(
      id: 'windowpane-suit',
      name: 'Windowpane Suit',
      description: 'Three-piece suit in a blue windowpane wool.',
      priceInCents: 17600,
      imageAsset: 'assets/images/windowpane_suit.jpg',
      category: 'Tailoring',
      fabric: 'Wool blend',
      fit: 'Tailored',
    ),
    Product(
      id: 'double-monk-straps',
      name: 'Double Monk Straps',
      description: 'Almond-toe calf shoes closed with two monk straps.',
      priceInCents: 14200,
      imageAsset: 'assets/images/monk_straps.jpg',
      category: 'Footwear',
      fabric: 'Calf leather',
      fit: 'Almond toe',
    ),
  ];
}
