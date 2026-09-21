import 'package:flutter/material.dart';

class EditGoalButton extends StatelessWidget {
  const EditGoalButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: 'Change daily goal',
      child: Material(
        color: Colors.white,
        shape: const CircleBorder(side: BorderSide(width: 3)),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: const Padding(
            padding: EdgeInsets.all(14),
            child: Icon(Icons.edit_outlined, size: 32, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
