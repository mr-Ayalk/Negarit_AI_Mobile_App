import 'dart:async';

import 'package:flutter/material.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';

/// Bright opening: a short wait, then the logo grows from a dot.
class OpeningSplash extends StatefulWidget {
  const OpeningSplash({required this.onFinished, super.key});

  final VoidCallback onFinished;

  @override
  State<OpeningSplash> createState() => _OpeningSplashState();
}

class _OpeningSplashState extends State<OpeningSplash> {
  Timer? _start;
  Timer? _finish;
  var _showLogo = false;
  var _scale = 0.08;

  @override
  void initState() {
    super.initState();
    _start = Timer(const Duration(milliseconds: 600), () {
      if (!mounted) {
        return;
      }
      setState(() => _showLogo = true);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        setState(() => _scale = 1);
        _finish = Timer(const Duration(milliseconds: 1300), () {
          if (mounted) {
            widget.onFinished();
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _start?.cancel();
    _finish?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFFCF8), NegaritColors.skyTop],
        ),
      ),
      child: Center(
        child: _showLogo
            ? AnimatedScale(
                scale: _scale,
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                child: const _BrightLogo(),
              )
            : const SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: NegaritColors.primary,
                ),
              ),
      ),
    );
  }
}

class _BrightLogo extends StatelessWidget {
  const _BrightLogo();

  static const _brighter = ColorFilter.matrix(<double>[
    1.2, 0, 0, 0, 28,
    0, 1.15, 0, 0, 18,
    0, 0, 1.05, 0, 8,
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: NegaritColors.gold.withValues(alpha: 0.55),
            blurRadius: 36,
            spreadRadius: 4,
          ),
        ],
      ),
      child: ClipOval(
        child: ColoredBox(
          color: Colors.white,
          child: ColorFiltered(
            colorFilter: _brighter,
            child: Image.asset(
              'assets/brand/logo.png',
              width: 220,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
