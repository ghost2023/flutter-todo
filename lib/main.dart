import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/components/todo_form.dart';
import 'package:to_do/components/todo_list.dart';
import 'package:to_do/services/classes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Todo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    () async {
      final prefs = await SharedPreferences.getInstance();
      var todosList = prefs.getStringList('todos') ?? [];
      setState(() {
        todos = todosList.map((e) => Todo.fromJson(jsonDecode(e))).toList();
      });
    }();
  }

  void updatePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'todos', todos.map((e) => jsonEncode(e.toJson())).toList());
  }

  void moveTaskToInprogress(Todo item) {
    setState(() {
      item.status = 'inprogress';
    });
    updatePrefs();
  }

  void moveTaskToDone(Todo item) {
    setState(() {
      item.status = 'done';
    });
    updatePrefs();
  }

  void deleteTask(Todo task) {
    setState(() {
      todos.remove(task);
    });
    updatePrefs();
  }

  void addTodo(String todo) {
    setState(() {
      todos.add(Todo(todo));
    });
    updatePrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade500,
        title:
            const Text('To-do', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration:
            BoxDecoration(color: Colors.blueGrey.shade50.withOpacity(0.5)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(12.0),
                  children: [
                    TodoList(
                      todos: todos
                          .where((element) => element.status == 'todo')
                          .toList(),
                      title: 'New Tasks',
                      onActionClick: moveTaskToInprogress,
                      deleteTask: deleteTask,
                    ),
                    TodoList(
                      todos: todos
                          .where((element) => element.status == 'inprogress')
                          .toList(),
                      title: 'In-Progress',
                      onActionClick: moveTaskToDone,
                      deleteTask: deleteTask,
                    ),
                    TodoList(
                      todos: todos
                          .where((element) => element.status == 'done')
                          .toList(),
                      title: 'Done',
                      onActionClick: () {},
                      deleteTask: deleteTask,
                    ),
                  ],
                ),
              ),
              TodoForm(todos: todos, addTodo: addTodo)
            ]),
      ),
    );
  }
}
