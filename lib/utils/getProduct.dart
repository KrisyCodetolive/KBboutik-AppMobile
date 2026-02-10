import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Map<String, dynamic>>> getProducts() async {
  try {
    // Récupère les documents de la collection 'products'
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Produits')
        .orderBy('date', descending: true)
        .get()
        .timeout(const Duration(seconds: 10));


    // Transforme les documents en liste de Map
    final products = querySnapshot.docs.map((doc) {
      final data = doc.data();
      data['id'] = doc.id;
      print("$data['productUrl'] : 111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111");
      return data;
    }).toList();

    return products;
  } catch (e) {
    print('Erreur lors de la récupération des produits : $e');
    return [];

  }
}
