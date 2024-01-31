import 'package:derviza_app/model/product.dart'; // Changed 'article' to 'product'

import 'package:derviza_app/repository/product_repo.dart'; // Changed 'article_repo' to 'product_repo'

class MockProductRepository implements ProductFirestoreService {
  @override
  Stream<List<Product>> getProducts() async*{ // Changed 'getArticles' to 'getProducts'
    // Return a list of mock products for testing.
    yield [
      Product(
    index: '1',
    crop: 'Wheat',
    description: 'High-quality wheat for baking.',
    price: 10,
    temperatureRange: 60,
    moistureLevels: 12,
    sunlightExposure: 8,
    ratings: 4.5,
    seller: 'Farmers Co-op',
    imagesUrl: [
      'https://example.com/wheat1.jpg',
      'https://example.com/wheat2.jpg',
    ],
  ),
      Product(
    index: '2',
    crop: 'Corn',
    description: 'Fresh corn harvested this season.',
    price: 8,
    temperatureRange: 75,
    moistureLevels: 15,
    sunlightExposure: 7,
    ratings: 4.2,
    seller: 'Green Fields Farm',
    imagesUrl: [
      'https://example.com/corn1.jpg',
      'https://example.com/corn2.jpg',
    ],
  ),
    ];
  }

  Future<void> addProduct(Product product) async { // Changed 'Article' to 'Product'
    // Mock implementation for adding a product.
    // You can perform validation or check for errors here if needed.
  }

  Future<void> updateProduct(Product product) async { // Changed 'Article' to 'Product'
    // Mock implementation for updating a product.
    // You can perform validation or check for errors here if needed.
  }
}
