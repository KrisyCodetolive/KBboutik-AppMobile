import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kbboutik_v04/widgets/OrderCard.dart';



class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  Stream<QuerySnapshot> getOrdersStream() {
    return FirebaseFirestore.instance
        .collection('Commande')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Commandes')),

      body: StreamBuilder<QuerySnapshot>(
        stream: getOrdersStream(),
        builder: (context, snapshot) {

          // 🔄 Chargement
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // ❌ Erreur
          if (snapshot.hasError) {
            return Center(
              child: Text("Erreur : ${snapshot.error}"),
            );
          }

          // 📭 Aucune commande
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Aucune commande pour le moment"),
            );
          }

          final orders = snapshot.data!.docs;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {

              final data =
              orders[index].data() as Map<String, dynamic>;

              return OrderCard(
                order: data,
                labelBtn: "confirmé",
                onCancel: () {
                  debugPrint("Annuler ${data['lieuLivraison']}");
                },
                onRefuse: () {
                  debugPrint("Refuser ${data['lieuLivraison']}");
                },
              );
            },
          );
        },
      ),
    );
  }
}