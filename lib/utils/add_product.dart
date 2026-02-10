import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kbboutik_v04/utils/supabase_storage.dart';

Future<void> addProductToFirestore(
    int productCounter,
    TextEditingController nameController,
    TextEditingController descriptionController,
    TextEditingController quantityController,
    TextEditingController priceController,
    File? selectedFile,
    BuildContext context,
    ) async {
  try {
    // 🔹 Loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    // 🔹 Upload média vers Supabase
    String mediaUrl = '';

    if (selectedFile != null) {
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}_${selectedFile.path.split('/').last}';

      final uploadedUrl =
      await uploadMedia(selectedFile, fileName, context);

      // ❌ Upload échoué → STOP TOTAL
      if (uploadedUrl == null) {
        throw Exception('Échec de l’upload du média vers Supabase');
      }

      mediaUrl = uploadedUrl;
    }

    // 🔹 Enregistrement Firestore (SEULEMENT si tout est OK)
    final product = {
      'nomProduit': nameController.text.trim(),
      'description': descriptionController.text.trim(),
      'quantité': int.tryParse(quantityController.text) ?? 0,
      'prix': priceController.text.trim(),
      'mediaUrl': mediaUrl,
      'productUrl': '',
      'date': DateTime.now(),
    };

    DocumentReference docRef = await FirebaseFirestore.instance
        .collection('Produits')
        .add(product);

    final productUrl =
        'https://kbboutik.vercel.app?productId=${docRef.id}';

    await docRef.update({
      'productUrl': productUrl,
    });

    // 🔹 Fermer loader
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Produit ajouté avec succès 🎉')),
    );
  } catch (e, stack) {
    // 🔹 Fermer loader
    Navigator.of(context).pop();

    // 🔥 LOG DEBUG (console)
    debugPrint('❌ Erreur ajout produit : $e');
    debugPrintStack(stackTrace: stack);

    // 🔴 Message visible
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Erreur lors de l’ajout du produit.\nDétails : $e',
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}



