import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsSheet({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final String name = product['nomProduit'] ?? 'Nom inconnu';
    final String description = product['description'] ?? 'Aucune description';
    final int quantity = product['quantité'] ?? 0;
    final String price = product['prix'] ?? "non précisé";
    final String mediaUrl = product['mediaUrl'] ?? '';
    final String productUrl = product['productUrl'] ?? '';

    final Timestamp? timestamp = product['date'] as Timestamp?;
    final String dateText = timestamp != null
        ? DateFormat('dd/MM/yyyy à HH:mm').format(timestamp.toDate())
        : '';

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 12,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Barre de drag
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            /// 🖼 Image
            if (mediaUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  mediaUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                  const Icon(Icons.broken_image, size: 80),
                ),
              )
            else
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.image, size: 80),
              ),

            const SizedBox(height: 16),

            /// 🏷 Nom
            Text(
              name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            /// 💰 Prix & quantité
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prix : ${price} FCFA',
                  style: const TextStyle(fontSize: 16),
                ),
                Chip(
                  label: Text('Qté : $quantity'),
                  backgroundColor: Colors.green.shade100,
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// 📝 Description
            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(description),

            const SizedBox(height: 12),

            /// 🔗 URL cliquable
            if (productUrl.isNotEmpty)
              InkWell(
                onTap: () async {
                  final uri = Uri.parse(productUrl);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                child: Text(
                  productUrl,
                  style: const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

            const SizedBox(height: 12),

            /// 📅 Date
            if (dateText.isNotEmpty)
              Text(
                'Ajouté le $dateText',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
