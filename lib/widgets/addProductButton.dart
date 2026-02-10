import 'package:flutter/material.dart';

import '../forms/addProductForm.dart';

class AddProductButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // ⭐ IMPORTANT
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context) => const AddProductForm(),
        );
      },
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      child: Icon(Icons.add),
    );
  }
}
