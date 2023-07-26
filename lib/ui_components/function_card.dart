import 'package:flutter/material.dart';

import '../home.dart';

class FunctionCard extends StatelessWidget {
  const FunctionCard({
    super.key,
    required this.mlFunctions,
  });

  final FunctionModel mlFunctions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 1,
                color: Colors.grey.shade300,
              ),
            ],
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              mlFunctions.functionIcon.icon,
              size: 26,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(mlFunctions.functionName)
          ],
        ),
      ),
    );
  }
}
