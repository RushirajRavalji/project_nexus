import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyTodoHome(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white, fontFamily: 'Monospace'),
        ),
      ),
    );
  }
}

class MyTodoHome extends StatefulWidget {
  const MyTodoHome({super.key});

  @override
  State<MyTodoHome> createState() => _MyTodoHomeState();
}

class _MyTodoHomeState extends State<MyTodoHome> {
  List<String> todoList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      todoList = prefs.getStringList('todos') ?? [];
    });
  }

  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todos', todoList);
  }

  void addTodo() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      todoList.add(_controller.text.trim());
    });
    _saveTodos();
    _controller.clear();
  }

  void deleteTodo(int index) {
    setState(() {
      todoList.removeAt(index);
    });
    _saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyTodo App",
          style: TextStyle(fontFamily: 'Monospace', fontSize: 22),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: todoList.isEmpty
                ? const Center(
                    child: Text(
                      "No tasks yet. Add one!",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey[900],
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          title: Text(
                            todoList[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Monospace',
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => deleteTodo(index),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Add New Task",
          style: TextStyle(color: Colors.white, fontFamily: 'Monospace'),
        ),
        content: TextField(
          controller: _controller,
          style: const TextStyle(color: Colors.white, fontFamily: 'Monospace'),
          decoration: const InputDecoration(
            hintText: "Enter task here...",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              addTodo();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              "Add",
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
