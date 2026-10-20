import 'package:creddinv_task/data/models/product.dart';
import 'package:creddinv_task/data/sources/extended_catalog.dart';

/// Static catalog. Photos live in the app bundle so the list works offline.
abstract final class LocalProductData {
  static const products = <Product>[
    Product(
      id: 'heart-denim-shirt',
      name: 'Heart Denim Shirt',
      description: 'Cropped-sleeve denim shirt with an all-over heart print.',
      priceInCents: 5200,
      imageAsset: 'assets/images/oxford_shirt.jpg',
      category: 'Tops',
      fabric: 'Cotton denim',
      fit: 'Cropped',
    ),
    Product(
      id: 'fringe-poncho',
      name: 'Fringe Knit Poncho',
      description: 'Open-weave cream poncho finished with a long fringe hem.',
      priceInCents: 7800,
      imageAsset: 'assets/images/merino_crewneck.jpg',
      category: 'Knitwear',
      fabric: 'Open-knit wool',
      fit: 'Relaxed',
    ),
    Product(
      id: 'slim-chinos',
      name: 'Slim Chinos',
      description: 'Tapered cotton chinos with a clean break at the ankle.',
      priceInCents: 6400,
      imageAsset: 'assets/images/pleated_trousers.jpg',
      category: 'Bottoms',
      fabric: 'Cotton twill',
      fit: 'Slim',
    ),
    Product(
      id: 'court-sneakers',
      name: 'Court Sneakers',
      description: 'Low-top sneakers in warm tan with a thick contrast sole.',
      priceInCents: 12000,
      imageAsset: 'assets/images/leather_sneakers.jpg',
      category: 'Footwear',
      fabric: 'Leather',
      fit: 'Low-top',
    ),
    Product(
      id: 'camel-wrap-coat',
      name: 'Camel Wrap Coat',
      description: 'Belted wool coat with a wide collar and a long line.',
      priceInCents: 19800,
      imageAsset: 'assets/images/wool_overcoat.jpg',
      category: 'Outerwear',
      fabric: 'Wool',
      fit: 'Long',
    ),
    Product(
      id: 'kraft-tote',
      name: 'Kraft Tote',
      description: 'Structured everyday tote with long handles.',
      priceInCents: 2800,
      imageAsset: 'assets/images/canvas_tote.jpg',
      category: 'Accessories',
      fabric: 'Canvas',
      fit: 'Structured',
    ),
    ...ExtendedCatalog.products,
  ];
}
