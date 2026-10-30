import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/features/flow/flow_copy.dart';
import 'package:negarit_mobile/features/flow/flow_state.dart';
import 'package:negarit_mobile/features/flow/premium_ui.dart';
import 'package:negarit_mobile/features/profile/data/auth_api.dart';
import 'package:negarit_mobile/features/profile/data/session_controller.dart';

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
    final copy = copyOf(ref);
    final chosen = ref.watch(chosenLanguageProvider).value ?? languageByCode('en');
    final shown = visitLanguageChoices.where((language) {
      final query = _query.trim().toLowerCase();
      if (query.isEmpty) {
        return true;
      }
      return language.label.toLowerCase().contains(query) ||
          language.code.contains(query);
    }).toList();

    return PremiumPage(
      footer: PremiumButton(
        label: copy.t('Continue'),
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
          PremiumTitle(copy.t('Choose your language')),
          const SizedBox(height: 8),
          PremiumMuted(copy.t('You can change it any time in Profile.')),
          const SizedBox(height: 20),
          PremiumSearch(
            hint: copy.t('Search 80+ languages'),
            onChanged: (value) => setState(() => _query = value),
          ),
          const SizedBox(height: 16),
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
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          PremiumMuted(
            copy.t('Other languages are translated by AI and labeled.'),
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
        padding: const EdgeInsets.symmetric(vertical: 14),
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
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? NegaritColors.primary : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? NegaritColors.primary
                      : const Color(0xFFE1EAFA),
                ),
              ),
              child: Icon(
                Icons.check_rounded,
                size: 18,
                color: selected ? Colors.white : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PermissionsScreen extends ConsumerWidget {
  const PermissionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final copy = copyOf(ref);
    return PremiumPage(
      footer: Column(
        children: [
          PremiumButton(
            label: copy.t('Allow and continue'),
            onPressed: () => context.push('/sign-in'),
          ),
          const SizedBox(height: 4),
          PremiumTextButton(
            label: copy.t('Not now – I’ll choose my spot manually'),
            onPressed: () => context.push('/sign-in'),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 72,
            height: 72,
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
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 18),
          PremiumTitle(copy.t('Let Negarit guide you'), center: true),
          const SizedBox(height: 8),
          PremiumMuted(
            copy.t(
              'A few permissions so the app can find where you are inside the museum.',
            ),
            center: true,
          ),
          const SizedBox(height: 20),
          _PermissionCard(
            icon: Icons.bluetooth_rounded,
            title: copy.t('Bluetooth'),
            body: copy.t('Detects the exhibit you’re standing at'),
          ),
          const SizedBox(height: 12),
          _PermissionCard(
            icon: Icons.location_on_rounded,
            title: copy.t('Location'),
            body: copy.t('Needed by Android for Bluetooth scanning'),
          ),
          const SizedBox(height: 12),
          _PermissionCard(
            icon: Icons.notifications_rounded,
            title: copy.t('Notifications'),
            body: copy.t('Optional. Tips when you enter a new area'),
          ),
        ],
      ),
    );
  }
}

class _PermissionCard extends StatelessWidget {
  const _PermissionCard({
    required this.icon,
    required this.title,
    required this.body,
  });

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return PremiumCard(
      child: Row(
        children: [
          PremiumIcon(icon),
          const SizedBox(width: 14),
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
  final _phone = TextEditingController();
  final _code = TextEditingController();
  var _busy = false;
  var _codeSent = false;
  String? _error;

  @override
  void dispose() {
    _phone.dispose();
    _code.dispose();
    super.dispose();
  }

  FlowCopy get _copy {
    final code = ref.read(chosenLanguageProvider).value?.code ?? 'en';
    return FlowCopy(code);
  }

  Future<void> _sendCode() async {
    final copy = _copy;
    final destination = _phone.text.trim();
    if (destination.length < 5) {
      setState(() => _error = copy.t('Enter a phone number or email.'));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await const AuthApi()
          .requestCode(destination)
          .timeout(const Duration(seconds: 4));
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _codeSent = true;
        _error = copy.t('The code is printed in the API log.');
      });
    } on SignInException {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _error = copy.t(
          'This phone cannot reach the API. Keep it connected to the computer and try again.',
        );
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _error = copy.t(
          'This phone cannot reach the API. Keep it connected to the computer and try again.',
        );
      });
    }
  }

  Future<void> _confirm() async {
    final copy = _copy;
    final destination = _phone.text.trim();
    final code = _code.text.trim();
    if (code.length < 4) {
      setState(() => _error = copy.t('That code is not valid.'));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await const AuthApi()
          .verifyCode(destination, code)
          .timeout(const Duration(seconds: 4));
      await ref.read(sessionProvider.notifier).signIn(destination);
      if (!mounted) {
        return;
      }
      context.go('/venue');
    } on SignInException catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _error = error.invalidCode
            ? copy.t('That code is not valid.')
            : copy.t(
                'This phone cannot reach the API. Keep it connected to the computer and try again.',
              );
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _busy = false;
        _error = copy.t(
          'This phone cannot reach the API. Keep it connected to the computer and try again.',
        );
      });
    }
  }

  Future<void> _guest() async {
    await ref.read(sessionProvider.notifier).signOut();
    if (!mounted) {
      return;
    }
    context.go('/venue');
  }

  @override
  Widget build(BuildContext context) {
    final copy = copyOf(ref);
    return PremiumPage(
      footer: PremiumMuted(
        copy.t('By continuing you accept the Terms and Privacy Policy.'),
        center: true,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          PremiumTitle(copy.t('Welcome to Negarit')),
          const SizedBox(height: 8),
          PremiumMuted(
            copy.t('Sign in to save your visit and pay for local offers.'),
          ),
          const SizedBox(height: 20),
          PremiumCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PremiumMuted(copy.t('Phone number')),
                TextField(
                  controller: _phone,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: NegaritColors.text,
                  ),
                  decoration: const InputDecoration(
                    hintText: '+251 9…',
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ),
          if (_codeSent) ...[
            const SizedBox(height: 12),
            PremiumCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PremiumMuted(copy.t('Code')),
                  TextField(
                    controller: _code,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 4,
                      color: NegaritColors.text,
                    ),
                    decoration: const InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (_error != null) ...[
            const SizedBox(height: 12),
            PremiumMuted(_error!),
          ],
          const SizedBox(height: 16),
          PremiumButton(
            label: _codeSent ? copy.t('Confirm code') : copy.t('Send code'),
            onPressed: _busy ? null : (_codeSent ? _confirm : _sendCode),
          ),
          const SizedBox(height: 12),
          Center(child: PremiumMuted(copy.t('— or —'))),
          const SizedBox(height: 12),
          PremiumButton(
            label: copy.t('Continue as guest'),
            ghost: true,
            onPressed: _busy ? null : _guest,
          ),
          const SizedBox(height: 12),
          PremiumMuted(
            copy.t(
              'Guests can use the guide and map. Payments need an account.',
            ),
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
              Icon(
                Icons.check_circle_rounded,
                color: NegaritColors.primary,
                size: 28,
              ),
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
