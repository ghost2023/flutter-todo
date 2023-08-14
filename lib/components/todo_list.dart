import 'package:flutter/material.dart';
import 'package:to_do/components/todo_item.dart';
import 'package:to_do/services/classes.dart';

class TodoList extends StatefulWidget {
  final String title;
  final List<Todo> todos;
  final Function onActionClick;
  final Function deleteTask;

  const TodoList(
      {super.key,
      required this.todos,
      required this.title,
      required this.onActionClick,
      required this.deleteTask});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.title,
            style: TextStyle(
                color: Colors.blue.shade700,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Column(
            // itemCount: widget.todos.length,
            // itemBuilder: ((context, index) {
            children: widget.todos
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: TodoItem(
                          todo: item,
                          onActionClick: () {
                            widget.onActionClick(item);
                          },
                          deleteTask: () {
                            widget.deleteTask(item);
                          }),
                    ))
                .toList()),
      ],
    );
  }
}
