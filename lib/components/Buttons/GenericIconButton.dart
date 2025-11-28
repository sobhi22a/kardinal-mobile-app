import 'package:flutter/material.dart';

class GenericIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final EdgeInsetsGeometry? padding;
  final ButtonStyle? style;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;

  const GenericIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.padding,
    this.style,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 30,),
      label: Text(label),
      style: style ??
          ElevatedButton.styleFrom(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            elevation: elevation,
          ),
    );
  }
}

// Usage example:
// GenericIconButton(
//   onPressed: () => _showCommandFormDialog(context, cubit),
//   icon: Icons.add,
//   label: t.text('create_new_command'),
// )
//
// Or with custom styling:
// GenericIconButton(
//   onPressed: () => _doSomething(),
//   icon: Icons.delete,
//   label: 'Delete',
//   backgroundColor: Colors.red,
//   foregroundColor: Colors.white,
//   padding: const EdgeInsets.all(16),
// )