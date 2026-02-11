import 'package:flutter/material.dart';

import '../utils/editById.dart';
import '../widgets/QuantitySelector.dart';

class EditProductSheet extends StatefulWidget {
  final Map<String, dynamic> product;

  const EditProductSheet({super.key, required this.product});

  @override
  State<EditProductSheet> createState() => _EditProductSheetState();
}

class _EditProductSheetState extends State<EditProductSheet> {

  late TextEditingController nameController;
  late TextEditingController descriptionController;
  late TextEditingController quantityController;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.product['nomProduit'] ?? '');

    descriptionController =
        TextEditingController(text: widget.product['description'] ?? '');

    quantityController =
        TextEditingController(
            text: (widget.product['quantité'] ?? 0).toString());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Modifier le produit',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nom du produit',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            QuantitySelector(
              initialQuantity: int.tryParse(quantityController.text) ?? 1,
              onChanged: (val) {
                quantityController.text = val.toString();
              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final updatedData = {
                  'nomProduit': nameController.text.trim(),
                  'description': descriptionController.text.trim(),
                  'quantité': int.tryParse(quantityController.text.trim()) ?? 0,
                };

                // Appelle la fonction
                await editById(
                  docId: widget.product['id'],
                  updatedData: updatedData,
                  context: context,
                );

                Navigator.pop(context);
              },
              child: const Text('Enregistrer'),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
