import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Future<void> addProductToFirestore(
    int productCounter,
    TextEditingController nameController,
    TextEditingController descriptionController,
    TextEditingController quantityController,
    TextEditingController priceController,
    BuildContext context,
    ) async {
  try {
    // 🔹 Affiche le loader
    showDialog(
      context: context,
      barrierDismissible: false, // empêche de fermer le loader en appuyant dehors
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final product = {
      'nomProduit': nameController.text,
      'description': descriptionController.text,
      'quantité': int.tryParse(quantityController.text) ?? 0,
      'prix': priceController.text,
      'url': '',
      'cover': "chemin/vers/image",
      'spProduit': ["couleur", "rouge", "vert", "orange"],
      'date': DateTime.now(),
    };

    DocumentReference docRef = await FirebaseFirestore.instance.collection('Produits').add(product);
    String idProduit = docRef.id;
    await docRef.update({
      'url': 'https://kbboutik.vercel.app?productId=$idProduit'
    });


    // 🔹 Ferme le loader
    Navigator.of(context).pop();

    // Message de confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produit ajouté avec succès !')),
    );
  } catch (e) {
    // 🔹 Ferme le loader si erreur
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur: $e')),
    );
  }
}

