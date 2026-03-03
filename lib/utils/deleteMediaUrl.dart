import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> deleteMediaUrl(String mediaUrl) async {
  if (mediaUrl.isEmpty) return;

  try {
    final supabase = Supabase.instance.client;
    const bucketName = 'product-media';

    final uri = Uri.parse(mediaUrl);
    final bucketIndex = uri.pathSegments.indexOf(bucketName);

    if (bucketIndex == -1) return;

    final filePath =
    uri.pathSegments.skip(bucketIndex + 1).join('/');

    await supabase.storage
        .from(bucketName)
        .remove([filePath]);

    print("Fichier supprimé.");

  } catch (e) {
    print("Erreur suppression : $e");
  }
}
