import 'package:flutter/material.dart';

import '../widgets/BtnAction.dart';


class OrderDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback onCancel;
  final VoidCallback onAction;
  final String actionLabel; // "Confirmer" ou "Livrer"

  const OrderDetailsSheet({
    super.key,
    required this.order,
    required this.onCancel,
    required this.onAction,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final String clientName = order['clientName'] ?? 'Nom inconnu';
    final String phone = order['phone'] ?? 'Non précisé';
    final String location = order['location'] ?? 'Non précisé';
    final String productName = order['productName'] ?? 'Produit inconnu';
    final int quantity = order['quantity'] ?? 0;
    final String color = order['color'] ?? 'Non précisé';

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

            /// 🔹 Barre drag
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            /// 👤 Section Client
            Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person, size: 30),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clientName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(phone),
                      Text(location, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 📦 Produit
            const Text(
              "Détails de la commande",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    _infoRow("Produit", productName),
                    _infoRow("Quantité", quantity.toString()),
                    _infoRow("Couleur", color),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// 🔘 Boutons
            BtnAction(
              label: actionLabel,
              onCancel: onCancel,
              onPressed: onAction,
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  /// 🔹 Widget réutilisable pour aligner les infos
  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }
}