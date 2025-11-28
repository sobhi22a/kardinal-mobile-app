import 'package:flutter/material.dart';

class CardHomeIcon extends StatelessWidget {
  final IconData icon;
  final double iconSize;
  final String title;
  final Color? color;

  const CardHomeIcon({
    super.key,
    required this.icon,
    required this.title,
    this.color,
    this.iconSize = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Icon(icon, size: iconSize, color: color ?? Theme.of(context).primaryColor)),
            const SizedBox(height: 35),
            Expanded(child: Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)))
          ],
        ),
      ),
    );
  }
}
