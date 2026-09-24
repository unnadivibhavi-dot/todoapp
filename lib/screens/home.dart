import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todos = Todo.toDoList();
  List<Todo> _searchToDo = [];
  final todoTextInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchToDo = todos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 228, 228),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 3, 39, 68),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
            const CircleAvatar(
              backgroundImage: AssetImage("assets/profile.png"),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _searchBox(),
            _list(),
            _input(),
          ],
        ),
      ),
    );
  }

  Widget _searchBox() {
    // TODO 1: Build the Search Box UI
    /*
    Replace the Placeholder above with the following structure:
    1. A Padding widget (EdgeInsets.all(12.0))
    2. Child: Container 
       - decoration: BoxDecoration with white color and circular border radius of 20
    3. Child: Padding (EdgeInsets.symmetric(horizontal: 8))
    4. Child: TextField
       - onChanged: (value) => searchData(value)
       - decoration: InputDecoration 
           - border: InputBorder.none
           - prefixIcon: Icon(Icons.search, color: Colors.black)
           - hintText: "Search"
    */
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            onChanged: (value) => searchData(value),
            decoration: const InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search, color: Colors.black),
              hintText: "Search",
            ),
          ),
        ),
      ),
    );
  }

  Widget _list() {
    // TODO 2: Build the Todo List UI
    /*
    Replace the Placeholder above with the following structure:
    1. An Expanded widget
    2. Child: Padding (EdgeInsets.all(14.0))
    3. Child: Column (crossAxisAlignment: CrossAxisAlignment.start)
    4. Children of Column:
       - SizedBox(height: 20)
       - Text("ALL TODOS", style: size 20, bold, black)
       - SizedBox(height: 10)
       - Expanded
         - Child: ListView
           - children: [ ... ] -> Loop through _searchToDo.reversed here.
           
           For each item, render a TodoItem and pass:
           - todo: the current loop item
           - onclick: Call setState to toggle the item's isDone status
           - onDelete: Call setState to remove the item from 'todos'
    */
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "ALL TODOS",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  for (Todo todo in _searchToDo.reversed)
                    TodoItem(
                      todo: todo,
                      onclick: () {
                        setState(() {
                          todo.isDone = !todo.isDone;
                        });
                      },
                      onDelete: () {
                        setState(() {
                          todos.removeWhere((item) => item.id == todo.id);
                        });
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _input() {
    // TODO 3: Build the Input UI
    /*
    Replace the Placeholder above with the following structure:
    1. Align widget (alignment: Alignment.bottomCenter)
    2. Child: Padding (EdgeInsets.only(left: 12, right: 12, bottom: 12))
    3. Child: Container 
       - decoration: BoxDecoration with white color and circular border radius of 20
    4. Child: Row
    5. Children of Row:
       - Expanded widget
         - Child: Padding (horizontal 8)
           - Child: TextField
             - controller: todoTextInput
             - decoration: InputDecoration with no border and hintText "Add New To Do"
       - IconButton
         - icon: Icon(Icons.add)
         - onPressed: {
             // Call setState()
             // Add a new Todo object to the 'todos' list using todoTextInput.text
             // Use DateTime.now().millisecondsSinceEpoch.toString() for the unique ID
             // Clear the todoTextInput controller
         }
    */
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    controller: todoTextInput,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Add New To Do",
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  if (todoTextInput.text.isNotEmpty) {
                    setState(() {
                      todos.add(
                        Todo(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          title: todoTextInput.text,
                        ),
                      );
                    });
                    todoTextInput.clear();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchData(String text) {
    /*
    TODO 4: Implement Search logic
    
    - Create an empty List<Todo> called results.
    - If the text is empty, set results to 'todos'.
    - If not empty, filter the 'todos' list by checking if the title contains the text (make it case-insensitive!).
    - Call setState and update _searchToDo with your results.
    */
    List<Todo> results = [];
    if (text.isEmpty) {
      results = todos;
    } else {
      results = todos
          .where(
            (item) => item.title.toLowerCase().contains(text.toLowerCase()),
          )
          .toList();
    }

    setState(() {
      _searchToDo = results;
    });
  }
}
