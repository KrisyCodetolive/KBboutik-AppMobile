import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // pour formater la date
import 'package:cloud_firestore/cloud_firestore.dart';

import '../sheets/productDetailsSheet.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // ✅ Gestion sécurisée des champs
    final String name = product['nomProduit'] ?? 'Nom inconnu';
    final int quantity = product['quantité'] ?? 0;
    final String ProductUrl = product['productUrl'] ?? "------";

    // Gestion du Timestamp Firestore
    final Timestamp? timestamp = product['date'] as Timestamp?;
    final String dateText = timestamp != null
        ? DateFormat('dd/MM/yyyy – HH:mm').format(timestamp.toDate())
        : 'Pas de date';

    final String mediaUrl = product['mediaUrl'] ?? '';

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => ProductDetailsSheet(product: product),
        );
      },
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image ou icône fallback
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: mediaUrl.isNotEmpty
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    mediaUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image),
                  ),
                )
                    : const Icon(Icons.image),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nom et quantité
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '$quantity',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Date
                    Text(
                      dateText,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                    // Media URL affiché (texte cliquable si besoin)
                    Text(
                      ProductUrl,
                      style: const TextStyle(fontSize: 12, color: Colors.blue),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
