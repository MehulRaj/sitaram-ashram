import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'dart:math' as Math;

class AnimatedCard extends StatefulWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  const AnimatedCard(
      {super.key, required this.child, this.borderRadius = 28, this.padding});

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()..scale(_hovering ? 1.03 : 1.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(_hovering ? 0.12 : 0.06),
              blurRadius: _hovering ? 24 : 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: widget.padding ?? const EdgeInsets.all(24),
        child: widget.child,
      ),
    );
  }
}

class HeartbeatIcon extends StatefulWidget {
  final Widget icon;
  final Duration duration;
  final double scale;
  final bool beat;
  const HeartbeatIcon({
    super.key,
    required this.icon,
    this.duration = const Duration(milliseconds: 1200),
    this.scale = 1.0,
    this.beat = false,
  });

  @override
  State<HeartbeatIcon> createState() => _HeartbeatIconState();
}

class _HeartbeatIconState extends State<HeartbeatIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.beat) {
      _controller.repeat(reverse: false);
    }
  }

  @override
  void didUpdateWidget(covariant HeartbeatIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.beat && !_controller.isAnimating) {
      _controller.repeat(reverse: false);
    } else if (!widget.beat && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _heartbeatCurve(double t) {
    if (t < 0.12) {
      return 1.0 + 0.22 * Math.sin(Math.pi * t / 0.12);
    } else if (t < 0.18) {
      return 1.0 - 0.10 * (t - 0.12) / 0.06;
    } else if (t < 0.28) {
      return 1.0 + 0.10 * Math.sin(Math.pi * (t - 0.18) / 0.10);
    } else if (t < 0.5) {
      return 1.0 - 0.04 * (t - 0.28) / 0.22;
    } else {
      return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.beat) {
      return widget.icon;
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double t = _controller.value;
        final double scale = _heartbeatCurve(t) * widget.scale;
        return Transform.scale(
          scale: scale,
          child: widget.icon,
        );
      },
    );
  }
}

class HeartbeatText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final bool beat;
  final TextAlign? textAlign;
  const HeartbeatText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 1200),
    this.beat = false,
    this.textAlign,
  });

  @override
  State<HeartbeatText> createState() => _HeartbeatTextState();
}

class _HeartbeatTextState extends State<HeartbeatText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    if (widget.beat) {
      _controller.repeat(reverse: false);
    }
  }

  @override
  void didUpdateWidget(covariant HeartbeatText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.beat && !_controller.isAnimating) {
      _controller.repeat(reverse: false);
    } else if (!widget.beat && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _heartbeatCurve(double t) {
    if (t < 0.12) {
      return 1.0 + 0.22 * Math.sin(Math.pi * t / 0.12);
    } else if (t < 0.18) {
      return 1.0 - 0.10 * (t - 0.12) / 0.06;
    } else if (t < 0.28) {
      return 1.0 + 0.10 * Math.sin(Math.pi * (t - 0.18) / 0.10);
    } else if (t < 0.5) {
      return 1.0 - 0.04 * (t - 0.28) / 0.22;
    } else {
      return 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.beat) {
      return Text(widget.text,
          style: widget.style, textAlign: widget.textAlign);
    }
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double t = _controller.value;
        final double scale = 1.0 + 0.25 * (_heartbeatCurve(t) - 1.0);
        return Transform.scale(
          scale: scale,
          child: Text(widget.text,
              style: widget.style, textAlign: widget.textAlign),
        );
      },
    );
  }
}

class HoverBeat extends StatefulWidget {
  final Widget Function(BuildContext context, bool hovered) builder;
  final MouseCursor cursor;
  const HoverBeat({
    super.key,
    required this.builder,
    this.cursor = SystemMouseCursors.click,
  });
  @override
  State<HoverBeat> createState() => _HoverBeatState();
}

class _HoverBeatState extends State<HoverBeat> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.cursor,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: widget.builder(context, _hovered),
    );
  }
}
