import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testapp/module/product_card_widget.dart';
import 'package:testapp/providers/product_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[400],
        title: const Text('PRODUCTS'),
      ),
      body: Consumer<ProductProvider>(
        builder: (context, productProvider, child) {
          if (productProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (productProvider.error.isNotEmpty) {
            return Center(
              child: Text(productProvider.error),
            );
          } else if (productProvider.products.isEmpty) {
            return const Center(
              child: Text('No products found.'),
            );
          } else {
            return ListView.separated(
              itemCount: productProvider.products.length,
              itemBuilder: (context, index) {
                final product = productProvider.products[index];
                return ProductCardWidget(product: product);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(height: 12),
            );
          }
        },
      ),
    );
  }
}
