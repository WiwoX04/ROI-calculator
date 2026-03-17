import 'package:flutter/material.dart';

class tittleWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  tittleWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blue),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
