import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Fonction pour modifier un produit par son ID
Future<void> editById({
  required String docId, // ID du document Firestore
  required Map<String, dynamic> updatedData, // champs à mettre à jour
  required BuildContext context, // pour afficher un SnackBar
}) async {
  try {

    //loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const
      Center(child: CircularProgressIndicator(
        backgroundColor: Colors.blue,
      )),

    );

    final docRef = FirebaseFirestore.instance.collection('Produits').doc(docId);

    await docRef.update(updatedData);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produit mis à jour avec succès ✅'),
      ),
    );
  } catch (e) {
    debugPrint('Erreur update produit: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Erreur lors de la mise à jour: $e'),
      ),
    );
  }
}
