// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

import '../model/todo.dart';
import '../constants/colors.dart';

class ToDoItem extends StatefulWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  State<ToDoItem> createState() => _ToDoItemState();
}

class _ToDoItemState extends State<ToDoItem> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        confetiMethod(),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: ListTile(
            onTap: () {
              print('Clicked on Todo Item.');
              widget.onToDoChanged(widget.todo);
              _controllerCenter.play();
              _controllerCenter.dispose();
              // _controllerCenter.stop();
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: Colors.white,
            leading: Icon(
              widget.todo.isDone
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: tdBlue,
            ),
            title: Text(
              widget.todo.todoText!,
              style: TextStyle(
                fontSize: 16,
                color: tdBlack,
                decoration:
                    widget.todo.isDone ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.symmetric(
                vertical: 12,
              ),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: tdRed,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                color: Colors.white,
                iconSize: 18,
                icon: Icon(Icons.delete),
                onPressed: () {
                  // print('Clicked on delete icon');
                  widget.onDeleteItem(widget.todo.id);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Align confetiMethod() {
    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: _controllerCenter,
        blastDirectionality: BlastDirectionality
            .explosive, // don't specify a direction, blast randomly
        shouldLoop: false, // start again as soon as the animation is finished
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ], // manually specify the colors to be used
        createParticlePath: drawStar, // define a custom shape/path.
      ),
    );
  }
}
