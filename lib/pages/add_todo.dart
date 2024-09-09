import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  final _todoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _backButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: _body(context),
    );
  }

  Widget _backButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _back(context),
      child: const Icon(Icons.arrow_back),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _todoController,
              validator: _todoValidate,
              autofocus: true,
              decoration: const InputDecoration(
                label: Text('Todo'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _submitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return InkWell(
      onTap: () => _submit(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: const Text("Submit"),
      ),
    );
  }

  String? _todoValidate(value) {
    if (value.isEmpty) return 'Todo is required';
    if (value.length > 32) return 'length must be shorter then 40 characters';
    return null;
  }

  void _submit(context) {
    if (_formKey.currentState?.validate() ?? false) {
      var result = _todoController.text;
      _todoController.clear();
      Navigator.pop(context, result);
    }
  }

  void _back(context) {
    Navigator.pop(context, null);
  }
}
