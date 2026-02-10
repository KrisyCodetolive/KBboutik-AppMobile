import 'package:flutter/material.dart';

import '../data/product_store.dart';
import '../forms/addProductForm.dart';
import '../widgets/ProductCard.dart';
import '../widgets/addProductButton.dart';
//import '../widgets/addProductButton.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produits')),

      body: products.isEmpty
          ? const Center(child: Text('Aucun produit ajouté'))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(product: products[index]);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddProductForm(),
          );
          // 🔴 TRÈS IMPORTANT
          setState(() {});
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
