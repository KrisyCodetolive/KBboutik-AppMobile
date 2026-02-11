import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sheets/editProductSheet.dart';
import '../sheets/productDetailsSheet.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({super.key, required this.product});

  /// 🔗 Ouvrir l'URL dans le navigateur
  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("Impossible d'ouvrir l'URL");
    }
  }

  /// 📋 Copier l'URL
  void _copyUrl(BuildContext context, String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Lien copié 📋")),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 🔐 Gestion sécurisée des champs
    final String name = product['nomProduit'] ?? 'Nom inconnu';
    final int quantity = product['quantité'] ?? 0;
    final String productUrl = product['productUrl'] ?? "------";
    final String mediaUrl = product['mediaUrl'] ?? '';

    // 📅 Date Firestore
    final Timestamp? timestamp = product['date'] as Timestamp?;
    final String dateText = timestamp != null
        ? DateFormat('dd/MM/yyyy – HH:mm').format(timestamp.toDate())
        : 'Pas de date';

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
              // 🖼 Image
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
                    errorBuilder: (_, __, ___) =>
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
                    // 🏷 Nom + quantité
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
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (_) => EditProductSheet(product: product),
                            );
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
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

                    // 📅 Date
                    Text(
                      dateText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // 🔗 URL produit (cliquable + copiable)
                    GestureDetector(
                      onTap: productUrl.startsWith("https")
                          ? () => _openUrl(productUrl)
                          : null,
                      onLongPress: productUrl.startsWith("https")
                          ? () => _copyUrl(context, productUrl)
                          : null,
                      child: SelectableText(
                        productUrl,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: productUrl.startsWith("https")
                              ? Colors.blue
                              : Colors.grey,
                          decoration: productUrl.startsWith("https")
                              ? TextDecoration.underline
                              : null,
                        ),
                      ),
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
