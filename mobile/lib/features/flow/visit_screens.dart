import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/features/flow/flow_state.dart';
import 'package:negarit_mobile/features/flow/premium_ui.dart';
import 'package:negarit_mobile/features/visit/data/saved_places_controller.dart';

void _note(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

class EntranceScreen extends ConsumerWidget {
  const EntranceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(chosenLanguageProvider);
    return PremiumPage(
      footer: Column(
        children: [
          PremiumButton(
            label: 'Begin my visit',
            onPressed: () => context.push('/exhibit'),
          ),
          PremiumTextButton(
            label: 'Change language',
            onPressed: () => context.push('/language?return=welcome'),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Color(0xFF2863FF),
                  Color(0x3D2863FF),
                  Color(0x142863FF),
                ],
                stops: [0.17, 0.43, 1],
              ),
            ),
          ),
          const SizedBox(height: 8),
          const PremiumTag('Entrance detected'),
          const SizedBox(height: 12),
          PremiumTitle(
            'Hello $visitorName, welcome to Adwa Museum',
            center: true,
          ),
          const SizedBox(height: 8),
          const PremiumMuted(
            'From now on I will guide you, room by room. Just walk – I’ll tell you what’s around you.',
            center: true,
          ),
          const SizedBox(height: 16),
          PremiumCard(
            child: InkWell(
              onTap: () => _note(context, 'No audio file is loaded.'),
              child: Row(
                children: [
                  const PremiumIcon('▶'),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hear the welcome',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: NegaritColors.text,
                          ),
                        ),
                        PremiumMuted('0:24 · ${language.label}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExhibitScreen extends ConsumerWidget {
  const ExhibitScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedPlacesProvider).value ?? const <String>[];
    final kept = saved.contains('5gna-ber');
    return PremiumBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 230,
              child: Stack(
                children: [
                  const Positioned.fill(
                    child: PremiumPhoto(
                      warm: true,
                      radius: BorderRadius.only(
                        bottomLeft: Radius.circular(26),
                        bottomRight: Radius.circular(26),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
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
                              const Spacer(),
                              PremiumIcon(
                                kept ? '♥' : '♡',
                                onTap: () => ref
                                    .read(savedPlacesProvider.notifier)
                                    .toggle('5gna-ber'),
                              ),
                              const SizedBox(width: 8),
                              const PremiumIcon('⤴'),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              _Pill(
                                label: '▶  Play audio',
                                onTap: () => _note(
                                  context,
                                  'No audio file is loaded.',
                                ),
                              ),
                              const Spacer(),
                              _Pill(
                                label: '🗺  Map',
                                light: true,
                                onTap: () => context.go('/map'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                children: [
                  const Row(
                    children: [
                      Expanded(child: PremiumTitle('5gna Ber')),
                      PremiumMuted('Zone 3 of 8'),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      PremiumChip(label: '🕓  4 min'),
                      PremiumChip(label: '🌐  English'),
                      PremiumChip(label: '✓  Reviewed'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'The story of the warriors who defended Adwa in 1896, told through their weapons and clothing.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: NegaritColors.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  PremiumCard(
                    sponsored: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PremiumTag('Sponsored'),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Traditional warrior cape',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                      color: NegaritColors.text,
                                    ),
                                  ),
                                  PremiumMuted('Shop 4 · 60 m · 2,400 ETB'),
                                ],
                              ),
                            ),
                            PremiumMiniButton(
                              label: 'View',
                              onPressed: () => context.push('/offer'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  PremiumButton(
                    label: '✦  Ask about this exhibit',
                    ghost: true,
                    onPressed: () => context.push('/guide'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.onTap, this.light = false});

  final String label;
  final VoidCallback onTap;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: light ? Colors.white : const Color(0xC70F1D37),
      borderRadius: BorderRadius.circular(99),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          child: Text(
            label,
            style: TextStyle(
              color: light ? NegaritColors.text : Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PremiumPage(
      footer: Column(
        children: [
          PremiumButton(
            label: 'Pay now',
            onPressed: () => context.push('/checkout'),
          ),
          const SizedBox(height: 8),
          PremiumButton(
            label: 'Reserve and pay at the shop',
            ghost: true,
            onPressed: () => _note(context, 'Reservations are not connected.'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PremiumIcon(
                '←',
                onTap: () =>
                    context.canPop() ? context.pop() : context.go('/exhibit'),
              ),
              const Spacer(),
              const PremiumTag('Sponsored'),
              const Spacer(),
              const PremiumIcon('⤴'),
            ],
          ),
          const SizedBox(height: 12),
          const PremiumPhoto(warm: true, height: 160),
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: PremiumTitle('Warrior cape')),
              Text(
                '2,400 ETB',
                style: TextStyle(
                  color: NegaritColors.primary,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const PremiumMuted(
            'Hand-woven cotton, made in Adwa. Sold by Selam Crafts.',
          ),
          const SizedBox(height: 12),
          const PremiumCard(
            child: Row(
              children: [
                PremiumIcon('📍'),
                SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shop 4, east exit',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: NegaritColors.text,
                        ),
                      ),
                      PremiumMuted('60 m from you · Open until 5 pm'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  var _method = 'telebirr';

  @override
  Widget build(BuildContext context) {
    return PremiumPage(
      footer: Column(
        children: [
          const Row(
            children: [
              Text(
                'Total',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: NegaritColors.text,
                ),
              ),
              Spacer(),
              Text(
                '2,400 ETB',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  color: NegaritColors.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          PremiumButton(
            label: 'Pay 2,400 ETB',
            onPressed: () => _note(context, 'Payment is not connected.'),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              PremiumIcon(
                '←',
                onTap: () =>
                    context.canPop() ? context.pop() : context.go('/offer'),
              ),
              const Expanded(
                child: Text(
                  'Checkout',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: NegaritColors.text,
                  ),
                ),
              ),
              const SizedBox(width: 36),
            ],
          ),
          const SizedBox(height: 14),
          const PremiumCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Warrior cape × 1',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: NegaritColors.text,
                        ),
                      ),
                      PremiumMuted('Selam Crafts'),
                    ],
                  ),
                ),
                Text(
                  '2,400 ETB',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: NegaritColors.text,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pay with',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: NegaritColors.text,
            ),
          ),
          const SizedBox(height: 8),
          _PayRow(
            glyph: '📱',
            label: 'Telebirr',
            selected: _method == 'telebirr',
            onTap: () => setState(() => _method = 'telebirr'),
          ),
          const SizedBox(height: 8),
          _PayRow(
            glyph: '💳',
            label: 'Chapa',
            selected: _method == 'chapa',
            onTap: () => setState(() => _method = 'chapa'),
          ),
          const SizedBox(height: 8),
          _PayRow(
            glyph: '🏪',
            label: 'Pay at the shop',
            selected: _method == 'shop',
            onTap: () => setState(() => _method = 'shop'),
          ),
          const SizedBox(height: 12),
          const PremiumMuted(
            'You’ll confirm on the payment provider’s own screen. Negarit never sees your PIN.',
          ),
        ],
      ),
    );
  }
}

class _PayRow extends StatelessWidget {
  const _PayRow({
    required this.glyph,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String glyph;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(21),
      child: PremiumCard(
        selected: selected,
        child: Row(
          children: [
            PremiumIcon(glyph),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: NegaritColors.text,
                ),
              ),
            ),
            Text(
              selected ? '●' : '○',
              style: TextStyle(
                color: selected
                    ? NegaritColors.text
                    : NegaritColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BreakScreen extends StatelessWidget {
  const BreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PremiumBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            const Expanded(child: _MapCanvas(dimmed: true)),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Need a break?',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: NegaritColors.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const PremiumMuted(
                      'You’ve been exploring for 90 minutes. Want to see places to eat, drink or rest?',
                    ),
                    const SizedBox(height: 10),
                    const _BreakPlace(
                      glyph: '☕',
                      name: 'Museum Café',
                      detail: '80 m · Open',
                    ),
                    const SizedBox(height: 8),
                    const _BreakPlace(
                      glyph: '🍽',
                      name: 'Tigist Restaurant',
                      detail: '200 m · Open',
                    ),
                    const SizedBox(height: 12),
                    PremiumButton(
                      label: 'Show on map',
                      onPressed: () => context.go('/map'),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: PremiumTextButton(
                            label: 'Remind me in 1 hour',
                            onPressed: () {
                              if (context.canPop()) {
                                context.pop();
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: PremiumTextButton(
                            label: 'Don’t ask again',
                            onPressed: () {
                              if (context.canPop()) {
                                context.pop();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BreakPlace extends StatelessWidget {
  const _BreakPlace({
    required this.glyph,
    required this.name,
    required this.detail,
  });

  final String glyph;
  final String name;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Row(
        children: [
          PremiumIcon(glyph),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: NegaritColors.text,
                  ),
                ),
                PremiumMuted(detail),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  var _time = '1 hour';
  final _interests = <String>{'History', 'Photos'};

  @override
  Widget build(BuildContext context) {
    return PremiumBackdrop(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                  children: [
                    const PremiumTitle('Plan my visit'),
                    const SizedBox(height: 6),
                    const PremiumMuted('How much time do you have?'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final time in ['30 min', '1 hour', '2 hours'])
                          PremiumChip(
                            label: time,
                            selected: _time == time,
                            onTap: () => setState(() => _time = time),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        for (final interest in [
                          'History',
                          'Culture',
                          'Family',
                          'Photos',
                        ])
                          PremiumChip(
                            label: interest,
                            selected: _interests.contains(interest),
                            onTap: () => setState(() {
                              if (_interests.contains(interest)) {
                                _interests.remove(interest);
                              } else {
                                _interests.add(interest);
                              }
                            }),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.only(left: 14),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Color(0xFFB7CDFA), width: 2),
                        ),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _Stop('Entrance hall', '5 min · Start'),
                          SizedBox(height: 10),
                          _Stop('5gna Ber', '10 min · Warriors'),
                          SizedBox(height: 10),
                          _Stop('6gna Ber', '10 min · Daily life'),
                          SizedBox(height: 10),
                          _Stop('Café break', '15 min'),
                          SizedBox(height: 10),
                          _Stop('Gift shop', '10 min'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    PremiumButton(
                      label: 'Start this plan',
                      onPressed: () => context.push('/entrance'),
                    ),
                  ],
                ),
              ),
              PremiumTabBar(index: 0, onSelected: (index) => openPremiumTab(context, index)),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stop extends StatelessWidget {
  const _Stop(this.title, this.detail);

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: NegaritColors.text,
          ),
        ),
        PremiumMuted(detail),
      ],
    );
  }
}

class _MapCanvas extends StatelessWidget {
  const _MapCanvas({this.dimmed = false});

  final bool dimmed;

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        Colors.white.withValues(alpha: dimmed ? 0.35 : 0),
        BlendMode.srcATop,
      ),
      child: const Stack(
        children: [
          Positioned.fill(child: ColoredBox(color: Color(0xFFE7F0E4))),
          Positioned.fill(child: CustomPaint(painter: _RoutePainter())),
          Positioned(left: 16, top: 52, child: _MapLabel()),
          Positioned(left: 36, bottom: 70, child: _Pin(glyph: '1')),
          Positioned(left: 120, top: 120, child: _Pin(glyph: '2')),
          Positioned(
            right: 28,
            top: 48,
            child: _Pin(glyph: '☕', color: NegaritColors.success),
          ),
          Positioned(
            left: 24,
            top: 90,
            child: _Pin(glyph: '🅿', color: Color(0xFF8A94A8)),
          ),
        ],
      ),
    );
  }
}

class _MapLabel extends StatelessWidget {
  const _MapLabel();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'ADWA MUSEUM',
      style: TextStyle(
        color: Color(0xFF91A18D),
        fontSize: 9,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.4,
      ),
    );
  }
}

class _Pin extends StatelessWidget {
  const _Pin({required this.glyph, this.color = NegaritColors.primary});

  final String glyph;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [
          BoxShadow(color: Color(0x3D142E5C), blurRadius: 8, offset: Offset(0, 3)),
        ],
      ),
      child: Text(
        glyph,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class VenueMapScreen extends StatefulWidget {
  const VenueMapScreen({super.key});

  @override
  State<VenueMapScreen> createState() => _VenueMapScreenState();
}

class _VenueMapScreenState extends State<VenueMapScreen> {
  var _filter = 'All';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              const Positioned.fill(child: _MapCanvas()),
              Positioned(
                top: 8,
                left: 8,
                right: 8,
                child: SafeArea(
                  bottom: false,
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final filter in ['All', '☕', '🍽', '🅿', '🚻'])
                        PremiumChip(
                          label: filter,
                          selected: _filter == filter,
                          onTap: () => setState(() => _filter = filter),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE6F8),
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nearest coffee',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: NegaritColors.text,
                          ),
                        ),
                        PremiumMuted('Museum Café · 80 m · 2 min walk'),
                      ],
                    ),
                  ),
                  PremiumMiniButton(label: 'Go', onPressed: () {}),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Parking',
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: NegaritColors.text,
                          ),
                        ),
                        PremiumMuted('Main gate · 150 m'),
                      ],
                    ),
                  ),
                  PremiumMuted('Route'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoutePainter extends CustomPainter {
  const _RoutePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF245BFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(size.width * 0.18, size.height * 0.78)
      ..cubicTo(
        size.width * 0.34,
        size.height * 0.66,
        size.width * 0.26,
        size.height * 0.46,
        size.width * 0.5,
        size.height * 0.42,
      )
      ..cubicTo(
        size.width * 0.72,
        size.height * 0.38,
        size.width * 0.78,
        size.height * 0.28,
        size.width * 0.84,
        size.height * 0.16,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
