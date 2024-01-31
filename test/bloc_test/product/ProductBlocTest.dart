// import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:derviza_app/bloc/product/product_bloc.dart'; // Changed 'article' to 'product'
import 'package:derviza_app/bloc/product/product_event.dart'; // Changed 'article' to 'product'
import 'package:derviza_app/bloc/product/product_state.dart'; // Changed 'article' to 'product'
import 'package:derviza_app/model/product.dart'; // Changed 'article' to 'product'
import 'package:flutter_test/flutter_test.dart';

import 'MockRepoProduct.dart';

void main() {
  group('ProductBloc', () { // Changed 'ArticleBloc' to 'ProductBloc'
    late ProductBloc productBloc; // Changed 'ArticleBloc' to 'ProductBloc'

    setUp(() {
      productBloc = ProductBloc(MockProductRepository()); // Changed 'Article' to 'Product' and 'MockArticleRepository' to 'MockProductRepository'
    });

    tearDown(() {
      productBloc.close();
    });

    blocTest<ProductBloc, ProductState>( // Changed 'ArticleBloc' to 'ProductBloc' and 'ArticleState' to 'ProductState'
      'emits [ProductLoading, ProductLoaded] when LoadProducts event is added', // Changed 'LoadArticles' to 'LoadProducts'
      build: () => productBloc, // Changed 'articleBloc' to 'productBloc'
      act: (bloc) => bloc.add(LoadProduct()), // Changed 'LoadArticles' to 'LoadProducts'
      expect: () => [
        ProductLoading(), // Changed 'ArticleLoading' to 'ProductLoading'
        ProductLoaded([ // Changed 'ArticleLoaded' to 'ProductLoaded'
          Product( // Changed 'Article' to 'Product'
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
          Product( // Changed 'Article' to 'Product'
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
        ]),
      ],
    );

    // Add more tests for other events and states as needed.
  });
}
