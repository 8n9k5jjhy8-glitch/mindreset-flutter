import 'package:flutter/material.dart';

import '../data/auth_service.dart';

class EmailConfirmScreen extends StatefulWidget {
  const EmailConfirmScreen({super.key});

  @override
  State<EmailConfirmScreen> createState() => _EmailConfirmScreenState();
}

class _EmailConfirmScreenState extends State<EmailConfirmScreen> {
  final _authService = AuthService();
  bool _isResending = false;

  Future<void> _resend() async {
    final email = _authService.currentUser?.email;
    if (email == null) return;

    setState(() => _isResending = true);
    try {
      await _authService.resendConfirmation(email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Письмо отправлено повторно.')),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось отправить письмо.')),
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  Future<void> _backToLogin() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final email = _authService.currentUser?.email ?? 'твой email';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF9FCF8), Color(0xFFF3F7F1), Color(0xFFEBF2E9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(28, 28, 28, 28),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.92),
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.95),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFDCE7D8).withValues(alpha: 0.34),
                        blurRadius: 34,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 110,
                        child: Center(
                          child: Text('🪷', style: TextStyle(fontSize: 64)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Подтверди свой email',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF243428),
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Мы отправили письмо на $email. Открой его и нажми «Подтвердить email», чтобы активировать аккаунт.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF5D7764),
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        height: 52,
                        child: FilledButton(
                          onPressed: _isResending ? null : _resend,
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFFA6B39F),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 0,
                          ),
                          child:
                              _isResending
                                  ? const SizedBox(
                                    width: 22,
                                    height: 22,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.4,
                                      color: Colors.white,
                                    ),
                                  )
                                  : const Text('Отправить письмо повторно'),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: _backToLogin,
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF6D7B6E),
                        ),
                        child: const Text('Вернуться ко входу'),
                      ),
                    ],
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
