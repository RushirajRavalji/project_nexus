import 'package:flutter/material.dart'; // Importing the Flutter Material Design package for UI elements like AppBar, buttons, etc.
import 'package:shared_preferences/shared_preferences.dart'; // Importing SharedPreferences to persist data locally on the device.

void main() {
  // The entry point of the Flutter app. It runs the MyTodoApp widget.
  runApp(const MyTodoApp());
}

// MyTodoApp widget, which is the root widget of the app. It extends StatelessWidget as it does not have mutable state.
class MyTodoApp extends StatelessWidget {
  const MyTodoApp(
      {super.key}); // Constructor with a key parameter, used for widget identification.

  @override
  Widget build(BuildContext context) {
    // The build method constructs the widget tree.
    return MaterialApp(
      // MaterialApp widget is the root of the application that provides material design visual structure.
      home: const MyTodoHome(), // Setting MyTodoHome widget as the home screen.
      debugShowCheckedModeBanner:
          false, // Disables the debug banner in the app.
      theme: ThemeData(
        // Custom theme for the app.
        brightness: Brightness.dark, // Dark mode theme for the app.
        scaffoldBackgroundColor: Colors
            .black, // Sets the background color of the scaffold (the main app screen).
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
              color: Colors.white,
              fontFamily:
                  'Monospace'), // Text theme with white text and monospace font.
        ),
      ),
    );
  }
}

// Stateful widget to manage the state of the Todo list.
class MyTodoHome extends StatefulWidget {
  const MyTodoHome({super.key}); // Constructor with a key parameter.

  @override
  State<MyTodoHome> createState() =>
      _MyTodoHomeState(); // Creates the mutable state for the widget.
}

// _MyTodoHomeState is the state class for MyTodoHome.
class _MyTodoHomeState extends State<MyTodoHome> {
  List<String> todoList = []; // List to store the todo items.
  final TextEditingController _controller =
      TextEditingController(); // Controller to manage the text input field.

  @override
  void initState() {
    super.initState();
    _loadTodos(); // Load stored todo items when the app starts.
  }

  // Method to load the todo list from shared preferences.
  Future<void> _loadTodos() async {
    final prefs = await SharedPreferences
        .getInstance(); // Get the shared preferences instance.
    setState(() {
      todoList = prefs.getStringList('todos') ??
          []; // Retrieve the todo list stored under the key 'todos'. If not found, initialize an empty list.
    });
  }

  // Method to save the todo list to shared preferences.
  Future<void> _saveTodos() async {
    final prefs = await SharedPreferences
        .getInstance(); // Get the shared preferences instance.
    await prefs.setStringList(
        'todos', todoList); // Save the todo list as a string list.
  }

  // Method to add a new todo to the list.
  void addTodo() {
    if (_controller.text.trim().isEmpty)
      return; // If the input is empty, do nothing.
    setState(() {
      todoList.add(
          _controller.text.trim()); // Add the trimmed input to the todo list.
    });
    _saveTodos(); // Save the updated todo list to shared preferences.
    _controller.clear(); // Clear the text input field.
  }

  // Method to delete a todo from the list.
  void deleteTodo(int index) {
    setState(() {
      todoList.removeAt(index); // Remove the todo item at the specified index.
    });
    _saveTodos(); // Save the updated todo list to shared preferences after deletion.
  }

  @override
  Widget build(BuildContext context) {
    // The build method constructs the widget tree for the UI.
    return Scaffold(
      // Scaffold provides a basic material design layout structure with AppBar, body, and floating button.
      appBar: AppBar(
        title: const Text(
          "MyTodo App", // The title displayed in the app bar.
          style: TextStyle(
              fontFamily: 'Monospace',
              fontSize: 22), // Styling the title with monospace font.
        ),
        backgroundColor: Colors.black, // Set the app bar color to black.
        centerTitle: true, // Centers the title in the app bar.
        elevation: 0, // Removes shadow/elevation from the app bar.
      ),
      body: Column(
        // Column widget arranges its children vertically.
        children: [
          Expanded(
            // Expanded widget ensures that the list takes up the remaining space.
            child: todoList.isEmpty
                ? const Center(
                    // If the todo list is empty, show a message prompting the user to add a task.
                    child: Text(
                      "No tasks yet. Add one!", // Display text for an empty todo list.
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16), // Style the text in grey color.
                    ),
                  )
                : ListView.builder(
                    // ListView.builder creates a scrollable list of todos dynamically.
                    itemCount:
                        todoList.length, // The number of items in the list.
                    itemBuilder: (context, index) {
                      // Builds each item in the list dynamically.
                      return Card(
                        color: Colors.grey[900], // Card background color.
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5), // Margin around the card.
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10), // Rounded corners for the card.
                        ),
                        child: ListTile(
                          title: Text(
                            todoList[
                                index], // Display the todo item at the specified index.
                            style: const TextStyle(
                              color: Colors.white, // White text color.
                              fontFamily:
                                  'Monospace', // Monospace font for the todo text.
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red), // A red delete icon.
                            onPressed: () => deleteTodo(
                                index), // Delete the todo when the icon is pressed.
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            _showAddTodoDialog(context), // Show the dialog to add a new todo.
        backgroundColor: Colors.white, // Floating button background color.
        child: const Icon(Icons.add,
            color: Colors.black), // Add icon inside the floating button.
      ),
    );
  }

  // Method to show the dialog to add a new todo item.
  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor:
            Colors.grey[900], // Set the background color of the dialog.
        title: const Text(
          "Add New Task", // Dialog title to prompt user to add a new task.
          style: TextStyle(color: Colors.white, fontFamily: 'Monospace'),
        ),
        content: TextField(
          controller: _controller, // Assign the text field controller.
          style: const TextStyle(color: Colors.white, fontFamily: 'Monospace'),
          decoration: const InputDecoration(
            hintText: "Enter task here...", // Hint text inside the input field.
            hintStyle: TextStyle(color: Colors.grey), // Hint text color.
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(
                context), // Dismiss the dialog when "Cancel" is pressed.
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              addTodo(); // Add the new todo when the "Add" button is pressed.
              Navigator.pop(
                  context); // Dismiss the dialog after adding the todo.
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              "Add", // Text for the Add button.
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}


// Explanation Summary:
// Imports: The code uses the flutter/material.dart package for UI components and the shared_preferences package to store and retrieve data locally.
// Main Function: The entry point of the app, where runApp() initializes MyTodoApp.
// MyTodoApp: This is a stateless widget that defines the app's UI and theme, including the dark background and monospace text style.
// MyTodoHome: This is a stateful widget to manage the todo list and handle user interactions.
// State Management: State<MyTodoHome> and _MyTodoHomeState manage the todo list using setState to trigger UI updates.
// Persistence: SharedPreferences is used to load and save the todo list to local storage, ensuring that data is persisted even if the app is closed.
// Add/Delete Todo: The methods addTodo() and deleteTodo() update the todo list and save the changes to shared preferences.
// UI Components: The app uses an AppBar, a list of todo items (ListView), and floating action buttons to add and delete tasks. It also shows a dialog for adding new tasks.
// This code is a simple Flutter To-Do app that saves the list of tasks locally on the device, allowing the user to add and delete tasks, even after the app is closed.