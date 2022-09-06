import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onpressed;
  const MyButton({
    super.key,
    required this.onpressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
        primary: Color(0x68d388).withOpacity(0.2),
        minimumSize: const Size(
          double.infinity,
          50,
        ),
      ),
      child: Text(text),
    );
  }
}
