import 'package:assignment_9/core/constants.dart';
import 'package:flutter/material.dart';

class IconChip extends StatelessWidget {
  final IconData icon;

  const IconChip({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Chip(
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: const Color.fromARGB(255, 224, 255, 225),
      labelPadding: const EdgeInsets.all(2),
      label: Icon(icon, color: Constants.primary, size: 20),
    );
  }
}
