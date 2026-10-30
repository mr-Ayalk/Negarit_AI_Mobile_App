import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/features/flow/flow_state.dart';
import 'package:negarit_mobile/features/flow/premium_ui.dart';
import 'package:negarit_mobile/features/visit/data/saved_places_controller.dart';
import 'package:negarit_mobile/features/visit/data/visit_places.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(chosenLanguageProvider);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PremiumMuted('Good morning'),
                    PremiumTitle('Hi $visitorName'),
                  ],
                ),
              ),
              PremiumChip(
                label: '🌐 ${language.code.toUpperCase()}',
                onTap: () => context.push('/language?return=home'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          PremiumPhoto(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => context.push('/venue'),
                  child: const PremiumTag('Your place · Change'),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Adwa Museum',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const Text(
                  '40 m away · Open until 6 pm',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          PremiumButton(
            label: 'Start guided tour',
            onPressed: () => context.push('/entrance'),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              PremiumChip(
                label: '☕ Coffee',
                onTap: () => context.go('/map'),
              ),
              PremiumChip(
                label: '🍽 Food',
                onTap: () => context.push('/break'),
              ),
              PremiumChip(
                label: '🅿 Parking',
                onTap: () => context.go('/map'),
              ),
              PremiumChip(
                label: '🚻 Restrooms',
                onTap: () => context.go('/map'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Nearby exhibits',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: NegaritColors.text,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => context.push('/plan'),
                child: const PremiumMuted('See all'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push('/exhibit'),
                  child: const PremiumPhoto(warm: true, height: 78),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.push('/exhibit'),
                  child: const PremiumPhoto(height: 78),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedPlacesProvider).value ?? const <String>[];
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          const PremiumTitle('Saved'),
          const SizedBox(height: 6),
          const PremiumMuted('Places you keep for this visit.'),
          const SizedBox(height: 14),
          if (saved.isEmpty)
            const PremiumCard(
              child: PremiumMuted('Nothing saved yet.'),
            )
          else
            for (final slug in saved)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: PremiumCard(
                  child: InkWell(
                    onTap: () => context.push('/exhibit'),
                    child: Row(
                      children: [
                        const PremiumPhoto(
                          warm: true,
                          width: 54,
                          height: 54,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Text(
                            placeBySlug(slug)?.nameEn ?? slug,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: NegaritColors.text,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class VisitorProfileScreen extends ConsumerStatefulWidget {
  const VisitorProfileScreen({super.key});

  @override
  ConsumerState<VisitorProfileScreen> createState() =>
      _VisitorProfileScreenState();
}

class _VisitorProfileScreenState extends ConsumerState<VisitorProfileScreen> {
  var _audio = true;
  var _offers = true;
  var _breaks = true;

  @override
  Widget build(BuildContext context) {
    final language = ref.watch(chosenLanguageProvider);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          const Row(
            children: [
              _LetterAvatar(),
              SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      visitorFullName,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: NegaritColors.text,
                      ),
                    ),
                    PremiumMuted(visitorPhone),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          PremiumCard(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
            child: Column(
              children: [
                _ProfileRow(
                  label: '🌐 Language',
                  value: language.label,
                  onTap: () => context.push('/language?return=profile'),
                ),
                _ProfileRow(
                  label: '⭐ Interests',
                  value: 'History, Photos',
                  divider: true,
                  onTap: () => context.push('/plan'),
                ),
                const _ProfileRow(
                  label: '⬇ Offline: Adwa Museum',
                  value: 'Ready',
                  divider: true,
                  valueColor: NegaritColors.success,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          PremiumCard(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
            child: Column(
              children: [
                _ToggleRow(
                  label: 'Audio narration',
                  on: _audio,
                  onTap: () => setState(() => _audio = !_audio),
                ),
                _ToggleRow(
                  label: 'Offers near me',
                  on: _offers,
                  divider: true,
                  onTap: () => setState(() => _offers = !_offers),
                ),
                _ToggleRow(
                  label: 'Break suggestions',
                  on: _breaks,
                  divider: true,
                  onTap: () => setState(() => _breaks = !_breaks),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const PremiumCard(
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 4),
            child: Column(
              children: [
                _ProfileRow(label: '🔒 Privacy and data', trailing: '›'),
                _ProfileRow(
                  label: 'Help and feedback',
                  trailing: '›',
                  divider: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LetterAvatar extends StatelessWidget {
  const _LetterAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment(-0.4, -0.5),
          colors: [Color(0xFF75B9FF), Color(0xFF2863FF), Color(0xFF153CC9)],
        ),
      ),
      child: const Text(
        'A',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow({
    required this.label,
    this.value,
    this.trailing,
    this.divider = false,
    this.valueColor,
    this.onTap,
  });

  final String label;
  final String? value;
  final String? trailing;
  final bool divider;
  final Color? valueColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: divider
              ? const Border(top: BorderSide(color: Color(0xFFEEF2FA)))
              : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14, color: NegaritColors.text),
              ),
            ),
            if (value != null)
              Text(
                value!,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: valueColor ?? NegaritColors.text,
                ),
              ),
            if (trailing != null)
              Text(
                trailing!,
                style: const TextStyle(
                  fontSize: 18,
                  color: NegaritColors.textSecondary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.label,
    required this.on,
    required this.onTap,
    this.divider = false,
  });

  final String label;
  final bool on;
  final VoidCallback onTap;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: divider
            ? const Border(top: BorderSide(color: Color(0xFFEEF2FA)))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, color: NegaritColors.text),
            ),
          ),
          PremiumSwitch(on: on, onTap: onTap),
        ],
      ),
    );
  }
}

class GuideChatScreen extends StatefulWidget {
  const GuideChatScreen({super.key});

  @override
  State<GuideChatScreen> createState() => _GuideChatScreenState();
}

class _GuideChatScreenState extends State<GuideChatScreen> {
  final _messages = <_ChatLine>[
    const _ChatLine(
      mine: true,
      text: 'من هو الراس ألولا؟',
      rtl: true,
    ),
    const _ChatLine(
      mine: false,
      text: 'كان الراس ألولا قائدًا عسكريًا بارزًا خلال معركة عدوة.',
      source: 'Source: Museum guide, p. 12',
    ),
  ];
  final _input = TextEditingController();

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  void _send() {
    final text = _input.text.trim();
    if (text.isEmpty) {
      return;
    }
    setState(() {
      _messages.add(_ChatLine(mine: true, text: text));
      _input.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PremiumBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Column(
              children: [
                Row(
                  children: [
                    PremiumIcon(
                      '←',
                      onTap: () => context.canPop()
                          ? context.pop()
                          : context.go('/explore'),
                    ),
                    const Expanded(
                      child: Text(
                        'Negarit guide',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: NegaritColors.text,
                        ),
                      ),
                    ),
                    const PremiumChip(label: '🌐 AR'),
                  ],
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: ListView(
                    children: [
                      for (final line in _messages) ...[
                        _Bubble(line: line),
                        const SizedBox(height: 8),
                      ],
                      const SizedBox(height: 4),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          PremiumChip(
                            label: 'Where is the toilet?',
                            onTap: () => _input.text = 'Where is the toilet?',
                          ),
                          PremiumChip(
                            label: 'Next exhibit',
                            onTap: () => _input.text = 'Next exhibit',
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const PremiumMuted(
                        'Translated by AI from verified museum text.',
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(99),
                    border: Border.all(color: const Color(0xFFE4EBF7)),
                  ),
                  padding: const EdgeInsets.fromLTRB(14, 4, 6, 4),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _input,
                          decoration: const InputDecoration(
                            hintText: 'Type your message',
                            hintStyle: TextStyle(color: Color(0xFF8A94A8)),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                        ),
                      ),
                      const Text('🎤', style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 6),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: _send,
                          customBorder: const CircleBorder(),
                          child: Container(
                            width: 34,
                            height: 34,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFF3474FF), Color(0xFF1748E8)],
                              ),
                            ),
                            child: const Text(
                              '➤',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _ChatLine {
  const _ChatLine({
    required this.mine,
    required this.text,
    this.rtl = false,
    this.source,
  });

  final bool mine;
  final String text;
  final bool rtl;
  final String? source;
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.line});

  final _ChatLine line;

  @override
  Widget build(BuildContext context) {
    final bubble = Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        gradient: line.mine
            ? const LinearGradient(
                colors: [Color(0xFF2863FF), Color(0xFF1748E8)],
              )
            : null,
        color: line.mine ? null : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(line.mine ? 16 : 4),
          bottomRight: Radius.circular(line.mine ? 4 : 16),
        ),
        border: line.mine ? null : Border.all(color: const Color(0xFFE7EEF9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            line.text,
            textDirection: line.rtl ? TextDirection.rtl : TextDirection.ltr,
            style: TextStyle(
              color: line.mine ? Colors.white : NegaritColors.text,
              height: 1.45,
              fontSize: 14,
            ),
          ),
          if (line.source != null) ...[
            const SizedBox(height: 6),
            PremiumChip(label: '📖 ${line.source}'),
          ],
        ],
      ),
    );
    return Align(
      alignment: line.mine ? Alignment.centerRight : Alignment.centerLeft,
      child: bubble,
    );
  }
}
