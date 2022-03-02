import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends StatelessWidget {
  const DeleteConfirmationDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        actions: <Widget>[
          TextButton( // TODO make buttons look different
            onPressed: () => Navigator.pop<bool>(context, false),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Spacer(),
          TextButton(
            onPressed: () => Navigator.pop<bool>(context, true),
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
        content: Center(
          child: Text("Are you sure you want to delete?"),
        ),
      ),
    );
  }
}
