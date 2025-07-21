import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool primary;
  final Widget? icon;
  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.primary = true,
    this.icon,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _hovering = false;
  bool _pressing = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.primary;
    final bgColor = isPrimary
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surface;
    final fgColor = isPrimary
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.primary;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() {
        _hovering = false;
        _pressing = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressing = true),
        onTapUp: (_) => setState(() => _pressing = false),
        onTapCancel: () => setState(() => _pressing = false),
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..scale(_pressing ? 0.96 : (_hovering ? 1.04 : 1.0)),
          decoration: BoxDecoration(
            color: _hovering ? bgColor.withOpacity(0.92) : bgColor,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              if (_hovering || _pressing)
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                widget.icon!,
                const SizedBox(width: 12),
              ],
              Text(
                widget.text,
                style: GoogleFonts.mukta(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: fgColor,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
