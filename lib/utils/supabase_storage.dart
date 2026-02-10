import 'dart:io';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<String?> uploadMedia(File file, String filename, BuildContext context) async {
  try {
    await Supabase.instance.client.storage
        .from('media')
        .upload(filename, file, fileOptions: const FileOptions(upsert: true));

    final url = Supabase.instance.client.storage.from('media').getPublicUrl(filename);
    return url;
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur upload: $e')),
    );
    return null;
  }
}
