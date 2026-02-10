import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/product_store.dart';
import '../utils/add_product.dart';


class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  File? selectedFile;


  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    super.dispose();
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Center(
              child: Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const Text(
              'Ajouter un produit',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            Column(
              children: [
                // Bouton pour choisir le media
                OutlinedButton.icon(
                  onPressed: () async {
                    final picker = ImagePicker();
                    // Permet à l'utilisateur de choisir une image ou une vidéo
                    final XFile? pickedFile = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      setState(() {
                        selectedFile = File(pickedFile.path);
                      });
                    }
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text('Choisir photo / vidéo'),
                ),

                const SizedBox(height: 16), // un petit espace

                // Indicateur visuel du fichier sélectionné
                if (selectedFile != null)
                  selectedFile!.path.endsWith('.mp4') // si c'est une vidéo
                      ? Row(
                    children: [
                      const Icon(Icons.videocam, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          selectedFile!.path.split('/').last, // nom du fichier
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                      : Image.file(
                    selectedFile!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
              ],
            ),

            const SizedBox(height: 12),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Nom du Produit',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Prix du Produit',
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

            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Quantité',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(

              onPressed: () async {
                productCounter++;
                await addProductToFirestore(
                  productCounter,
                  nameController,
                  descriptionController,
                  quantityController,
                  priceController,
                  context
                );

                Navigator.pop(context);
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
