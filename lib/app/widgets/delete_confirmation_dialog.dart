import 'package:flash_dictionary/styles.dart';
import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        actions: <Widget>[
          OutlinedButton(
            style: OutlinedButton.styleFrom(
                side: const BorderSide(width: borderWidth)),
            onPressed: () => Navigator.pop<bool>(context, false),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          SizedBox(width: 16),
          TextButton(
            onPressed: () => Navigator.pop<bool>(context, true),
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
        content: Center(
          child: Text(
            "Are you sure you want to delete?",
            style: TextStyle(fontSize: 18, color: Colors.grey[800]),
          ),
        ),
      ),
    );
  }
}
