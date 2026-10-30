import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/features/flow/flow_copy.dart';

/// Sky backdrop used by every screen in the premium visitor flow.
class PremiumBackdrop extends StatelessWidget {
  const PremiumBackdrop({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [NegaritColors.skyTop, NegaritColors.skyBottom],
        ),
      ),
      child: child,
    );
  }
}

class PremiumPage extends StatelessWidget {
  const PremiumPage({required this.child, this.footer, super.key});

  final Widget child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return PremiumBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                  child: child,
                ),
              ),
              if (footer != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  child: footer,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PremiumTitle extends StatelessWidget {
  const PremiumTitle(this.text, {this.center = false, super.key});

  final String text;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: const TextStyle(
        fontSize: 26,
        height: 1.15,
        letterSpacing: -0.4,
        fontWeight: FontWeight.w800,
        color: NegaritColors.text,
      ),
    );
  }
}

class PremiumMuted extends StatelessWidget {
  const PremiumMuted(this.text, {this.center = false, super.key});

  final String text;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: const TextStyle(
        fontSize: 13,
        height: 1.45,
        color: NegaritColors.textSecondary,
      ),
    );
  }
}

class PremiumButton extends StatelessWidget {
  const PremiumButton({
    required this.label,
    required this.onPressed,
    this.ghost = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool ghost;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: ghost || !enabled
            ? null
            : const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFF2863FF), Color(0xFF1748E8)],
              ),
        color: ghost ? const Color(0xE6FFFFFF) : null,
        borderRadius: BorderRadius.circular(16),
        border: ghost ? Border.all(color: const Color(0xFFDCE7FB)) : null,
        boxShadow: ghost || !enabled
            ? null
            : const [
                BoxShadow(
                  color: Color(0x38245BFF),
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 54),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: ghost ? NegaritColors.primary : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumMiniButton extends StatelessWidget {
  const PremiumMiniButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2863FF), Color(0xFF1748E8)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color(0x38245BFF),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumTextButton extends StatelessWidget {
  const PremiumTextButton({
    required this.label,
    required this.onPressed,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: NegaritColors.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}

class PremiumCard extends StatelessWidget {
  const PremiumCard({
    required this.child,
    this.selected = false,
    this.sponsored = false,
    this.padding = const EdgeInsets.all(13),
    super.key,
  });

  final Widget child;
  final bool selected;
  final bool sponsored;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: sponsored ? null : Colors.white,
        gradient: sponsored
            ? const LinearGradient(
                colors: [Color(0xFFFFFAF0), Color(0xFFFFF4DC)],
              )
            : null,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: selected
              ? const Color(0xFF7DA3FF)
              : sponsored
              ? const Color(0xFFF1D59B)
              : const Color(0xE6DEE9FA),
          width: selected ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: selected
                ? const Color(0x12245BFF)
                : const Color(0x0E244B8C),
            blurRadius: selected ? 0 : 20,
            spreadRadius: selected ? 3 : 0,
            offset: selected ? Offset.zero : const Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
  }
}

class PremiumSearch extends StatelessWidget {
  const PremiumSearch({required this.hint, this.onChanged, super.key});

  final String hint;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: const Color(0xFFE4EBF7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0E23437D),
            blurRadius: 18,
            offset: Offset(0, 7),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            size: 22,
            color: NegaritColors.textSecondary,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: NegaritColors.text,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Color(0xFF8A94A8),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PremiumChip extends StatelessWidget {
  const PremiumChip({
    required this.label,
    this.icon,
    this.selected = false,
    this.onTap,
    super.key,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : const Color(0xFF50617E);
    return Material(
      color: selected ? NegaritColors.primary : const Color(0xE6FFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99),
        side: BorderSide(
          color: selected ? NegaritColors.primary : const Color(0xFFE1EAFA),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 40),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18, color: color),
                  if (label.isNotEmpty) const SizedBox(width: 6),
                ],
                if (label.isNotEmpty)
                  Flexible(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumTag extends StatelessWidget {
  const PremiumTag(this.label, {this.positive = false, super.key});

  final String label;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: positive ? Colors.white : const Color(0xFFFFF8E8),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: positive ? const Color(0xFF1FA971) : const Color(0xFFF1D59B),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: positive ? const Color(0xFF0B6B45) : const Color(0xFF936000),
        ),
      ),
    );
  }
}

class PremiumPhoto extends StatelessWidget {
  const PremiumPhoto({
    this.warm = false,
    this.height,
    this.width,
    this.child,
    this.padding = const EdgeInsets.all(10),
    this.radius = const BorderRadius.all(Radius.circular(20)),
    super.key,
  });

  final bool warm;
  final double? height;
  final double? width;
  final Widget? child;
  final EdgeInsets padding;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: warm
              ? const [Color(0xFFE4C18C), Color(0xFFA66D39), Color(0xFF4A2E24)]
              : const [Color(0xFF9FCAFF), Color(0xFF3977F4), Color(0xFF173C9E)],
        ),
      ),
      child: child,
    );
  }
}

class PremiumIcon extends StatelessWidget {
  const PremiumIcon(
    this.icon, {
    this.size = 44,
    this.iconSize = 22,
    this.onTap,
    this.color = NegaritColors.primary,
    super.key,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final VoidCallback? onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFEDF2FB)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x171E4482),
                blurRadius: 14,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Icon(icon, size: iconSize, color: color),
        ),
      ),
    );
  }
}

class PremiumSwitch extends StatelessWidget {
  const PremiumSwitch({required this.on, required this.onTap, super.key});

  final bool on;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 42,
        height: 24,
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: on ? NegaritColors.success : const Color(0xFFD5DEEE),
          borderRadius: BorderRadius.circular(99),
        ),
        child: Align(
          alignment: on ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}

class PremiumTabBar extends ConsumerWidget {
  const PremiumTabBar({
    required this.index,
    required this.onSelected,
    super.key,
  });

  final int index;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copy = copyOf(ref);
    final items = <(IconData, String)>[
      (Icons.explore_rounded, copy.t('Explore')),
      (Icons.map_rounded, copy.t('Map')),
      (Icons.auto_awesome_rounded, copy.t('Ask AI')),
      (Icons.bookmark_rounded, copy.t('Saved')),
      (Icons.person_rounded, copy.t('Profile')),
    ];
    return Material(
      color: const Color(0xF5FFFFFF),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFFE8EEF8))),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(4, 6, 4, 4),
            child: Row(
              children: [
                for (var i = 0; i < items.length; i++)
                  Expanded(
                    child: InkWell(
                      onTap: () => onSelected(i),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 56),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              items[i].$1,
                              size: 24,
                              color: i == index
                                  ? NegaritColors.primary
                                  : const Color(0xFF7B88A0),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              items[i].$2,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: i == index
                                    ? FontWeight.w800
                                    : FontWeight.w600,
                                color: i == index
                                    ? NegaritColors.primary
                                    : const Color(0xFF7B88A0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void openPremiumTab(BuildContext context, int index) {
  switch (index) {
    case 0:
      context.go('/explore');
    case 1:
      context.go('/map');
    case 2:
      context.push('/guide');
    case 3:
      context.go('/favorites');
    default:
      context.go('/profile');
  }
}
