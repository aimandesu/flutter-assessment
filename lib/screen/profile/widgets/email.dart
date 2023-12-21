import 'package:flutter/material.dart';

class Email extends StatelessWidget {
  const Email({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: const Color(0xFFe9e9e9),
      height: 80,
      width: size.width * 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(Icons.email, size: 40,),
          Text(email)
        ],
      ),
    );
  }
}
