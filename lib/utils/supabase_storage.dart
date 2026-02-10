import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const directory = "product-media";

Future<String> uploadMedia(
    File file,
    String filename,
    BuildContext context,
    ) async {
  try {
    final filePath = 'products/$filename';

    await Supabase.instance.client.storage
        .from(directory)
        .upload(
      filePath,
      file,
      fileOptions: const FileOptions(
        cacheControl: '3600',
        upsert: true,
      ),
    );

    final publicUrl = Supabase.instance.client.storage
        .from(directory)
        .getPublicUrl(filePath);

    debugPrint('✅ Media uploaded: $publicUrl');

    return publicUrl;
  } on StorageException catch (e) {
    debugPrint('❌ Supabase upload error: ${e.message}');
    throw Exception('Échec de l’upload du média vers Supabase');
  } catch (e) {
    debugPrint('❌ Upload error: $e');
    throw Exception('Erreur inconnue lors de l’upload');
  }
}



