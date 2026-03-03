import 'package:flutter/material.dart';
import 'deleteMediaUrl.dart';
import 'deleteProduitData.dart';

Future<void> deleteProduit(
    BuildContext context, String productId, String mediaUrl) async {
  // 1️⃣ Demander confirmation à l'utilisateur
  final bool? confirm = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      title: const Text('Confirmer la suppression'),
      content: const Text(
          'Voulez-vous vraiment supprimer ce produit ? Cette action est irréversible.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Annuler'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Supprimer'),
        ),
      ],
    ),
  );

  if (confirm != true) return; // l'utilisateur a annulé

  // 2️⃣ Afficher un loader pendant la suppression
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => WillPopScope(
      onWillPop: () async => false,
      child: Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircularProgressIndicator(
              color: Colors.redAccent,
              strokeWidth: 4,
            ),
            SizedBox(height: 16),
            Text(
              'Suppression en cours...',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    ),
  );

  try {
    await deleteMediaUrl(mediaUrl);
    await deleteProduitData(productId);

    Navigator.of(context).pop(); // fermer loader
    Navigator.of(context).pop();
    // 3️⃣ Snackbar visuelle
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Expanded(child: Text('Produit supprimé avec succès ✅')),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  } catch (e) {
    Navigator.of(context).pop(); // fermer loader si erreur

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text('Erreur lors de la suppression : $e')),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
