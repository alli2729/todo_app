import 'package:flutter/material.dart';
import 'add_todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final List<String> _todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      floatingActionButton: _addButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: _body(),
      ),
    );
  }

  PreferredSizeWidget? _appBar() {
    if (_todos.isEmpty) return null;

    return AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 80,
        title: const Text('Todos', style: TextStyle(fontSize: 24)));
  }

  Widget _body() {
    if (_todos.isEmpty) {
      return const Center(
        child: Text('No Item', style: TextStyle(fontSize: 16)),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 54.0),
      child: ListView.separated(
        itemBuilder: (context, index) => _todoBox(index),
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemCount: _todos.length,
      ),
    );
  }

  Widget _todoBox(int index) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_todos[index], style: const TextStyle(fontSize: 16)),
            // delete button
            InkWell(
              onTap: () => _deleteTodo(index),
              child: const Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }

  Widget _addButton() {
    return FloatingActionButton(
      onPressed: _addPressed,
      child: const Icon(Icons.add),
    );
  }

  void _addPressed() async {
    final result = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (_) => AddTodo(),
      ),
    );
    if (result != null) {
      _todos.add(result);
    }
    setState(() {});
  }

  void _deleteTodo(index) {
    _todos.removeAt(index);
    setState(() {});
  }
}
