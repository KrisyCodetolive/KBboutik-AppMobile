import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kbboutik_v04/utils/deleteProduit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/webwiewsPage.dart';

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
    final String productId = product['id'] ?? '';

    final Timestamp? timestamp = product['date'] as Timestamp?;
    final String dateText = timestamp != null
        ? DateFormat('dd/MM/yyyy à HH:mm').format(timestamp.toDate())
        : '';

    /// 📋 Copier l’URL
    void openInAppWebView(BuildContext context, String url) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => WebViewPage(url: url),
        ),
      );
    }
    /// 📋 Copier l’URL
    void copyUrl(String url) {
      Clipboard.setData(ClipboardData(text: url));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lien copié 📋")),
      );
    }

    /// 🌍 Ouvrir l’URL
    Future<void> openUrl(String url) async {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    }

    final bool isValidUrl = productUrl.startsWith('https');

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
                  'Prix : $price FCFA',
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

            /// 🔗 URL sélectionnable / cliquable
            if (productUrl.isNotEmpty)
              GestureDetector(
                onTap: isValidUrl
                    ? () => openInAppWebView(context, productUrl)
                    : null,
                onLongPress: isValidUrl
                    ? () => copyUrl(productUrl)
                    : null,
                child: SelectableText(
                  productUrl,
                  style: TextStyle(
                    fontSize: 12,
                    color: isValidUrl ? Colors.blue : Colors.grey,
                    decoration: isValidUrl ? TextDecoration.underline : null,
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
            ElevatedButton(
                onPressed: ()=> {

                  deleteProduit(context, productId, mediaUrl)
                },
                child: const Text('Supprimer' , style: const TextStyle(color: Colors.red),)),

            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
