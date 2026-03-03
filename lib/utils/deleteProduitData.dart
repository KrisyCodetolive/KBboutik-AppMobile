import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteProduitData(String productId) async {
  if (productId.isEmpty) return;

  try {
    await FirebaseFirestore.instance
        .collection('Produits') // remplace par le nom exact de ta collection
        .doc(productId)
        .delete();
    print("Produit supprimé avec succès !");
  } catch (e) {
    print("Erreur lors de la suppression du produit : $e");
  }
}
