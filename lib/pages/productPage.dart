import 'package:flutter/material.dart';
import '../utils/getProduct.dart';
import '../widgets/ProductCard.dart';
import '../forms/addProductForm.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Map<String, dynamic>> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Charge les produits au démarrage
    loadProducts();
  }

  // Fonction pour charger les produits depuis Firestore
  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Timeout pour éviter loader infini
      final result = await getProducts().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print("Timeout lors de la récupération des produits");
          return [];
        },
      );

      setState(() {
        products = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors du chargement des produits : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Produits')),

      // Pull-to-refresh
      body: RefreshIndicator(
        onRefresh: loadProducts,
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : products.isEmpty
            ? const Center(child: Text('Aucun produit ajouté'))
            : ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];



            return ProductCard(product: products[index]);
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddProductForm(),
          );

          // Recharge la liste après ajout
          await loadProducts();
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
