import 'package:flutter/material.dart';
import 'package:placement_daily_task/placement_day_1/Model/model.dart';


class TodoItem extends StatelessWidget {
  final Todo todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: todo.completed ? Colors.teal[50] : Colors.pink[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        todo.title,
        style: TextStyle(fontSize: 16,color: Colors.black),
      ),
    );
  }
}
