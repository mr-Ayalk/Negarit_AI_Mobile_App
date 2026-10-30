import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/locale/locale_controller.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/features/flow/flow_state.dart';
import 'package:negarit_mobile/features/flow/premium_ui.dart';
import 'package:negarit_mobile/features/profile/data/auth_api.dart';

const _languages = <ChosenLanguage>[
  ChosenLanguage('en', 'English'),
  ChosenLanguage('am', 'አማርኛ'),
  ChosenLanguage('ar', 'العربية'),
  ChosenLanguage('fr', 'Français'),
  ChosenLanguage('om', 'Afaan Oromoo'),
  ChosenLanguage('ti', 'ትግርኛ · Soomaali'),
];

class LanguageScreen extends ConsumerStatefulWidget {
  const LanguageScreen({this.returnTo, super.key});

  final String? returnTo;

  @override
  ConsumerState<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends ConsumerState<LanguageScreen> {
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final chosen = ref.watch(chosenLanguageProvider);
    final shown = _languages.where((language) {
      final query = _query.trim().toLowerCase();
      if (query.isEmpty) {
        return true;
      }
      return language.label.toLowerCase().contains(query) ||
          language.code.contains(query);
    }).toList();

    return PremiumPage(
      footer: PremiumButton(
        label: 'Continue',
        onPressed: () {
          if (widget.returnTo != null && context.canPop()) {
            context.pop();
            return;
          }
          context.push('/permissions');
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PremiumTitle('Choose your language'),
          const SizedBox(height: 6),
          const PremiumMuted('You can change it any time in Profile.'),
          const SizedBox(height: 14),
          PremiumSearch(
            hint: 'Search 80+ languages',
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 12),
          PremiumCard(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              children: [
                for (var i = 0; i < shown.length; i++)
                  _LanguageRow(
                    label: shown[i].label,
                    selected: shown[i].code == chosen.code,
                    divider: i > 0,
                    onTap: () {
                      ref
                          .read(chosenLanguageProvider.notifier)
                          .choose(shown[i]);
                      const stored = ['en', 'am', 'ar'];
                      if (stored.contains(shown[i].code)) {
                        ref
                            .read(localeProvider.notifier)
                            .select(shown[i].code);
                      }
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const PremiumMuted(
            'Other languages are translated by AI and labeled.',
          ),
        ],
      ),
    );
  }
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.label,
    required this.selected,
    required this.divider,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool divider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
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
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: NegaritColors.text,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: selected ? NegaritColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(99),
                border: Border.all(
                  color: selected
                      ? NegaritColors.primary
                      : const Color(0xFFE1EAFA),
                ),
              ),
              child: Text(
                selected ? '✓' : ' ',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionsScreen extends StatelessWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PremiumPage(
      footer: Column(
        children: [
          PremiumButton(
            label: 'Allow and continue',
            onPressed: () => context.push('/sign-in'),
          ),
          PremiumTextButton(
            label: 'Not now – I’ll choose my spot manually',
            onPressed: () => context.push('/sign-in'),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 18),
          Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                center: Alignment(-0.4, -0.5),
                colors: [Color(0xFF75B9FF), Color(0xFF2863FF), Color(0xFF153CC9)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x45245BFF),
                  blurRadius: 25,
                  offset: Offset(0, 12),
                ),
              ],
            ),
            child: const Text(
              '✦',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          const SizedBox(height: 14),
          const PremiumTitle('Let Negarit guide you', center: true),
          const SizedBox(height: 6),
          const PremiumMuted(
            'A few permissions so the app can find where you are inside the museum.',
            center: true,
          ),
          const SizedBox(height: 16),
          const _PermissionCard(
            glyph: '📶',
            title: 'Bluetooth',
            body: 'Detects the exhibit you’re standing at',
          ),
          const SizedBox(height: 10),
          const _PermissionCard(
            glyph: '📍',
            title: 'Location',
            body: 'Needed by Android for Bluetooth scanning',
          ),
          const SizedBox(height: 10),
          const _PermissionCard(
            glyph: '🔔',
            title: 'Notifications',
            body: 'Optional. Tips when you enter a new area',
          ),
        ],
      ),
    );
  }
}

class _PermissionCard extends StatelessWidget {
  const _PermissionCard({
    required this.glyph,
    required this.title,
    required this.body,
  });

  final String glyph;
  final String title;
  final String body;

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
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: NegaritColors.text,
                  ),
                ),
                PremiumMuted(body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeSignInScreen extends ConsumerStatefulWidget {
  const WelcomeSignInScreen({super.key});

  @override
  ConsumerState<WelcomeSignInScreen> createState() =>
      _WelcomeSignInScreenState();
}

class _WelcomeSignInScreenState extends ConsumerState<WelcomeSignInScreen> {
  late final TextEditingController _phone = TextEditingController(
    text: visitorPhone,
  );
  var _sending = false;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  Future<void> _sendCode() async {
    if (_sending) {
      return;
    }
    setState(() => _sending = true);
    try {
      await const AuthApi()
          .requestCode(_phone.text.trim())
          .timeout(const Duration(seconds: 3));
    } catch (_) {
      // The walk-through continues when the API is not on this phone.
    }
    if (!mounted) {
      return;
    }
    context.go('/venue');
  }

  @override
  Widget build(BuildContext context) {
    return PremiumPage(
      footer: const PremiumMuted(
        'By continuing you accept the Terms and Privacy Policy.',
        center: true,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          const PremiumTitle('Welcome to Negarit'),
          const SizedBox(height: 6),
          const PremiumMuted(
            'Sign in to save your visit and pay for local offers.',
          ),
          const SizedBox(height: 18),
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PremiumMuted('Phone number'),
                TextField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: NegaritColors.text,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          PremiumButton(
            label: 'Send code',
            onPressed: _sending ? null : _sendCode,
          ),
          const SizedBox(height: 8),
          const Center(child: PremiumMuted('— or —')),
          const SizedBox(height: 8),
          PremiumButton(
            label: 'Continue as guest',
            ghost: true,
            onPressed: () => context.go('/venue'),
          ),
          const SizedBox(height: 10),
          const PremiumMuted(
            'Guests can use the guide and map. Payments need an account.',
            center: true,
          ),
        ],
      ),
    );
  }
}

class VenuePickScreen extends StatefulWidget {
  const VenuePickScreen({super.key});

  @override
  State<VenuePickScreen> createState() => _VenuePickScreenState();
}

class _VenuePickScreenState extends State<VenuePickScreen> {
  var _query = '';

  @override
  Widget build(BuildContext context) {
    final query = _query.trim().toLowerCase();
    bool show(String name) =>
        query.isEmpty || name.toLowerCase().contains(query);

    return PremiumPage(
      footer: PremiumButton(
        label: 'Enter Adwa Museum',
        onPressed: () => context.go('/explore'),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PremiumTitle('Where are you visiting?'),
          const SizedBox(height: 6),
          const PremiumMuted('Pick a place. Guidance starts when you walk in.'),
          const SizedBox(height: 14),
          PremiumSearch(
            hint: 'Search places',
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 12),
          if (show('Adwa Museum')) ...[
            const _AdwaCard(),
            const SizedBox(height: 10),
          ],
          if (show('Friendship Park')) ...[
            const _SoonVenue(
              name: 'Friendship Park',
              place: 'Addis Ababa',
              warm: false,
            ),
            const SizedBox(height: 10),
          ],
          if (show('Unity Park'))
            const _SoonVenue(name: 'Unity Park', place: 'Addis Ababa'),
          const SizedBox(height: 12),
          const PremiumMuted(
            'Download the guide before you arrive: 48 MB, works offline.',
          ),
        ],
      ),
    );
  }
}

class _AdwaCard extends StatelessWidget {
  const _AdwaCard();

  @override
  Widget build(BuildContext context) {
    return const PremiumCard(
      selected: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PremiumPhoto(
            warm: true,
            height: 84,
            child: PremiumTag('Near you', positive: true),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adwa Museum',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                        color: NegaritColors.text,
                      ),
                    ),
                    PremiumMuted('Adwa, Tigray · Open until 6 pm'),
                  ],
                ),
              ),
              PremiumChip(label: '✓', selected: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _SoonVenue extends StatelessWidget {
  const _SoonVenue({
    required this.name,
    required this.place,
    this.warm = true,
  });

  final String name;
  final String place;
  final bool warm;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Row(
        children: [
          PremiumPhoto(warm: warm, width: 54, height: 54, padding: EdgeInsets.zero),
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
                PremiumMuted(place),
              ],
            ),
          ),
          const PremiumTag('Soon'),
        ],
      ),
    );
  }
}
