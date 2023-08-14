import 'package:flutter/material.dart';
import 'package:to_do/services/classes.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final Function onActionClick;
  final Function deleteTask;
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onActionClick,
      required this.deleteTask});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnimation;
  late Animation<double> opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    scaleAnimation = Tween<double>(begin: 0.6, end: 1).animate(_controller);
    opacityAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> showCustomDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: const Text('Are You sure you want to delete?'),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text("Delete"),
              onPressed: () {
                Navigator.pop(context);
                widget.deleteTask();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Transform.scale(
              scale: scaleAnimation.value,
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          offset: const Offset(0, 3),
                          blurRadius: 8.0,
                          spreadRadius: 2.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.todo.name),
                        Row(
                          children: [
                            Visibility(
                              visible: widget.todo.status != 'done',
                              child: SizedBox(
                                width: 32,
                                child: IconButton(
                                  onPressed: () {
                                    widget.onActionClick();
                                  },
                                  icon:
                                      const Icon(Icons.arrow_downward_rounded),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 32,
                              child: IconButton(
                                  onPressed: () => showDialog<void>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text("Confirm Delete"),
                                            content: const Text(
                                                'Are You sure you want to delete?'),
                                            actions: [
                                              TextButton(
                                                child: const Text("Cancel"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Delete"),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  widget.deleteTask();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                  icon: const Icon(Icons.delete)),
                            ),
                          ],
                        )
                      ],
                    )),
              ),
            ));
  }
}
