import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_radius.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_background.dart';
import 'package:negarit_mobile/features/guide/data/visit_guide.dart';
import 'package:negarit_mobile/features/map/data/map_focus.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class GuideScreen extends ConsumerStatefulWidget {
  const GuideScreen({super.key});

  @override
  ConsumerState<GuideScreen> createState() => _GuideScreenState();
}

class _GuideMessage {
  const _GuideMessage({required this.text, required this.mine, this.placeSlug});

  final String text;
  final bool mine;
  final String? placeSlug;
}

class _GuideScreenState extends ConsumerState<GuideScreen> {
  final _controller = TextEditingController();
  final _messages = <_GuideMessage>[];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send(AppLocalizations l10n) {
    final text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }
    setState(() {
      _messages.add(_GuideMessage(text: text, mine: true));
      _messages.add(
        _GuideMessage(
          text: replyForVisit(text, l10n),
          mine: false,
          placeSlug: placeSlugForQuestion(text),
        ),
      );
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NegaritBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  NegaritSpacing.md,
                  NegaritSpacing.sm,
                  NegaritSpacing.md,
                  NegaritSpacing.xs,
                ),
                child: Row(
                  children: [
                    _RoundIconButton(
                      icon: Icons.arrow_back,
                      tooltip: MaterialLocalizations.of(context)
                          .backButtonTooltip,
                      onPressed: () => context.pop(),
                    ),
                    Expanded(
                      child: Text(
                        l10n.guideTitle,
                        textAlign: TextAlign.center,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: NegaritSpacing.lg,
                ),
                child: Text(
                  l10n.guideNotice,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall?.copyWith(
                    color: NegaritColors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: NegaritSpacing.sm),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(NegaritSpacing.lg),
                  itemCount: _messages.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: NegaritSpacing.sm),
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    return Align(
                      alignment: message.mine
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 280),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: message.mine
                                ? NegaritColors.primary
                                : NegaritColors.surface,
                            borderRadius: BorderRadius.circular(
                              NegaritRadius.card,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(NegaritSpacing.md),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message.text,
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: message.mine
                                        ? Colors.white
                                        : NegaritColors.text,
                                  ),
                                ),
                                if (!message.mine && message.placeSlug != null)
                                  TextButton(
                                    onPressed: () {
                                      ref
                                          .read(mapFocusProvider.notifier)
                                          .show(message.placeSlug!);
                                      context.go('/map');
                                    },
                                    child: Text(l10n.openMap),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  NegaritSpacing.md,
                  NegaritSpacing.xs,
                  NegaritSpacing.md,
                  NegaritSpacing.md,
                ),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: NegaritColors.surface,
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: [
                      BoxShadow(
                        color: NegaritColors.primary.withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: NegaritSpacing.md),
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: l10n.guideHint,
                            border: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.send,
                          onSubmitted: (_) => _send(l10n),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(NegaritSpacing.xs),
                        child: Material(
                          color: NegaritColors.primary,
                          shape: const CircleBorder(),
                          child: IconButton(
                            tooltip: l10n.guideSend,
                            onPressed: () => _send(l10n),
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: NegaritColors.surface,
      shape: const CircleBorder(),
      child: IconButton(
        tooltip: tooltip,
        onPressed: onPressed,
        icon: Icon(icon, color: NegaritColors.text),
      ),
    );
  }
}
