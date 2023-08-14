import 'package:flutter/material.dart';
import 'package:to_do/services/classes.dart';

class TodoForm extends StatefulWidget {
  final Function addTodo;
  final List<Todo> todos;
  const TodoForm({
    super.key,
    required this.todos,
    required this.addTodo,
  });

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  bool empty = true;
  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        empty = _controller.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 12, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: const Offset(0, -3),
            blurRadius: 8.0,
            spreadRadius: 4.0,
          )
        ],
      ),
      child: Form(
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: TextFormField(
                  controller: _controller,
                  cursorColor: Colors.blue,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2)),
                      labelText: 'Enter Tasks',
                      suffixIcon: IconButton(
                          onPressed: () {
                            _controller.clear();
                          },
                          color: Colors.black54,
                          icon: const Icon(Icons.clear)),
                      floatingLabelStyle:
                          const TextStyle(fontSize: 14, color: Colors.blue)),
                )),
            ElevatedButton(
                onPressed: (empty)
                    ? null
                    : () {
                        widget.addTodo(_controller.text);
                        _controller.clear();
                      },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    disabledForegroundColor: Colors.white,
                    disabledBackgroundColor: Colors.blue.withOpacity(0.4)),
                child: const Text('Add'))
          ],
        ),
      ),
    );
  }
}
