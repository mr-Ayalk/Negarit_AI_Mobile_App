import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:negarit_mobile/core/theme/negarit_colors.dart';
import 'package:negarit_mobile/core/theme/negarit_spacing.dart';
import 'package:negarit_mobile/core/widgets/negarit_background.dart';
import 'package:negarit_mobile/core/widgets/negarit_button.dart';
import 'package:negarit_mobile/features/profile/data/auth_api.dart';
import 'package:negarit_mobile/features/profile/data/session_controller.dart';
import 'package:negarit_mobile/l10n/app_localizations.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _destination = TextEditingController();
  final _code = TextEditingController();
  var _codeSent = false;
  var _busy = false;
  String? _notice;

  @override
  void dispose() {
    _destination.dispose();
    _code.dispose();
    super.dispose();
  }

  Future<void> _request(AppLocalizations l10n) async {
    final destination = _destination.text.trim();
    if (destination.length < 5) {
      return;
    }
    setState(() {
      _busy = true;
      _notice = null;
    });
    try {
      await const AuthApi().requestCode(destination);
      if (!mounted) {
        return;
      }
      setState(() {
        _codeSent = true;
        _notice = l10n.signInWaiting;
      });
    } on SignInException catch (error) {
      setState(() => _notice = l10n.signInUnreachable);
      if (error.invalidCode) {
        setState(() => _notice = l10n.signInInvalid);
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  Future<void> _verify(AppLocalizations l10n) async {
    setState(() {
      _busy = true;
      _notice = null;
    });
    try {
      await const AuthApi().verifyCode(
        _destination.text.trim(),
        _code.text.trim(),
      );
      await ref
          .read(sessionProvider.notifier)
          .signIn(_destination.text.trim());
      if (mounted) {
        context.pop();
      }
    } on SignInException catch (error) {
      setState(
        () => _notice = error.invalidCode
            ? l10n.signInInvalid
            : l10n.signInUnreachable,
      );
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: NegaritBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(NegaritSpacing.lg),
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  tooltip: MaterialLocalizations.of(context).backButtonTooltip,
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              Text(
                l10n.signIn,
                style: textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: NegaritSpacing.sm),
              Text(
                l10n.signInBody,
                style: textTheme.bodyMedium?.copyWith(
                  color: NegaritColors.textSecondary,
                ),
              ),
              const SizedBox(height: NegaritSpacing.lg),
              TextField(
                controller: _destination,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: NegaritColors.surface,
                  hintText: l10n.signInHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: NegaritSpacing.md),
              NegaritButton(
                label: l10n.signInSend,
                isLoading: _busy && !_codeSent,
                onPressed: () => _request(l10n),
              ),
              if (_codeSent) ...[
                const SizedBox(height: NegaritSpacing.md),
                TextField(
                  controller: _code,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: NegaritColors.surface,
                    hintText: l10n.signInCodeHint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: NegaritSpacing.md),
                NegaritButton(
                  label: l10n.signInConfirm,
                  isLoading: _busy,
                  onPressed: () => _verify(l10n),
                ),
              ],
              if (_notice != null) ...[
                const SizedBox(height: NegaritSpacing.md),
                Text(
                  _notice!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: NegaritColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
