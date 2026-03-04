import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kbboutik_v04/widgets/BtnAction.dart';

import '../sheets/orderDétailsSheet.dart';

class OrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final VoidCallback? onCancel;
  final VoidCallback? onRefuse;
  final String labelBtn;

  const OrderCard({
    super.key,
    required this.order,
    required this.labelBtn,
    this.onCancel,
    this.onRefuse,
  });

  Color _statusColor(String status) {
    switch (status) {
      case "validée":
        return Colors.green;
      case "annulée":
        return Colors.orange;
      case "refusée":
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String lieu = order['lieuLivraison'] ?? "Lieu inconnu";
    final String nombreProduits = order['quantité'] ?? 0;
    final int total = order['prix'] ?? 0;
    final String status = order['status'] ?? "en attente";

    final Timestamp? timestamp = order['createdAt'] as Timestamp?;
    final String dateText = timestamp != null
        ? DateFormat('dd/MM/yyyy – HH:mm').format(timestamp.toDate())
        : 'Pas de date';

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            builder: (_) => OrderDetailsSheet(
              order: order,
              actionLabel: labelBtn,
              onCancel: () => Navigator.pop(context),
              onAction: () {
                Navigator.pop(context);
                print(labelBtn);
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 Lieu + Status
              Row(
                children: [
                  Expanded(
                    child: Text(
                      lieu,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: status == "confirmé"
                          ? Colors.green
                          : Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              /// 📅 Date
              Text(
                dateText,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 6),

              /// 💰 Total
              Text(
                "Prix : ${NumberFormat("#,###").format(total)} FCFA",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 10),

              /// 🔹 Quantité + Btn
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                      "$nombreProduits articles",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  BtnAction(
                    label: labelBtn,
                    onCancel: () => print("annuler"),
                    onPressed: () => print(labelBtn),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}