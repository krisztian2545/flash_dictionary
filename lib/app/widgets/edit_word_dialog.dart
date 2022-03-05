import 'package:flash_dictionary/domain/collections/language_card.dart';
import 'package:flutter/material.dart';

class EditWordDialog extends StatefulWidget {
  const EditWordDialog(
      {Key? key,
      required this.title,
      required this.initialFront,
      required this.initialBack})
      : super(key: key);

  final String title;
  final String initialFront;
  final String initialBack;

  @override
  State<EditWordDialog> createState() => _EditWordDialogState();
}

class _EditWordDialogState extends State<EditWordDialog> {
  final TextEditingController _frontController = TextEditingController();
  final TextEditingController _backController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _frontController.text = widget.initialFront;
    _backController.text = widget.initialBack;
    super.initState();
  }

  String? _formFieldValidator(String? value) {
    if (value == null || value == "") {
      return "Field can't be empty!";
    }
  }

  bool validate() => _formKey.currentState?.validate() ?? false;

  void _onSubmit() {
    if (validate()) {
      Navigator.pop<LanguageCard>(
          context,
          LanguageCard(
            front: _frontController.text,
            back: _backController.text,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        title: Text(widget.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          TextButton(
            // TODO change color of animation when you hold
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
          Spacer(),
          TextButton(
            // TODO change color of animation when you hold
            onPressed: _onSubmit,
            child: const Text(
              "Save",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text("Front:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                // TODO maybe check if front already exists in deck or just overwrite
                controller: _frontController,
                validator: _formFieldValidator,
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              SizedBox(height: 16),
              Text("Back:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextFormField(
                controller: _backController,
                validator: _formFieldValidator,
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
