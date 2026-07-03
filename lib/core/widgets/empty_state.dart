import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  final String title;

  const EmptyState({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title));
  }
}
