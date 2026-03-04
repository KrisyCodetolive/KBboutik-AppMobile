import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/OrderCard.dart';

class DeliveryPage extends StatefulWidget {
  const DeliveryPage({super.key});
  @override
  State<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {

  bool isLoading = true;

  final List<Map<String, dynamic>> orders = [
    {
      "lieu": "Abidjan - Cocody",
      "nombreProduits": 3,
      "total": 45000,
      "status": "en attente",
      "date": Timestamp.now(),
    },
    {
      "lieu": "Yopougon",
      "nombreProduits": 2,
      "total": 30000,
      "status": "confirmé",
      "date": Timestamp.now(),
    },
  ];

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      print("Chargement terminé");

      setState(() {
        isLoading = false;
      });

    } catch (e) {

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors du chargement : $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Livraisons')),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: loadProducts, // 🔥 IMPORTANT
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];

            return OrderCard(
              order: order,
              labelBtn: "livraison",
              onCancel: () {
                debugPrint("Annuler ${order['lieu']}");
              },
              onRefuse: () {
                debugPrint("Refuser ${order['lieu']}");
              },
            );
          },
        ),
      ),
    );
  }
}