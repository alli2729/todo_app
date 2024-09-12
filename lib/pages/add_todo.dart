import 'package:flutter/material.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  // controller
  final _todoController = TextEditingController();
  // key for form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      floatingActionButton: _backButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: _body(context),
    );
  }

  //* widgets

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => _back(context),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _submit(context),
      child: const Icon(Icons.check),
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
                label: Text('Todo Title'),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  //* functions

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
