import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> todos = [];

  void addTodo() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      todos.add({
        'title': _controller.text,
        'completed': false,
      });
    });

    _controller.clear();
  }

  void deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  void toggleTodo(int index) {
    setState(() {
      todos[index]['completed'] = !todos[index]['completed'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter Todo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addTodo,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: todos.isEmpty
                  ? const Center(
                child: Text(
                  'No Todos Added',
                  style: TextStyle(fontSize: 18),
                ),
              )
                  : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(
                        value: todos[index]['completed'],
                        onChanged: (_) {
                          toggleTodo(index);
                        },
                      ),
                      title: Text(
                        todos[index]['title'],
                        style: TextStyle(
                          decoration: todos[index]['completed']
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          deleteTodo(index);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}