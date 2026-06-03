import 'package:flutter/material.dart';
import 'package:mindreset_flutter/l10n/generated/app_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/data/auth_service.dart';
import '../data/profile_service.dart';
import '../domain/user_profession_profile.dart';
import 'personal_details_screen.dart';
import 'widgets/profession_profile_selector_tile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authService = AuthService();
  final _profileService = ProfileService();

  UserProfessionProfile _profession = UserProfessionProfile.student;
  bool _isLoadingProfession = true;
  bool _isSavingProfession = false;
  bool _isSigningOut = false;

  @override
  void initState() {
    super.initState();
    _loadProfession();
  }

  String _resolveUserName(User? user, AppLocalizations l10n) {
    final metadata = user?.userMetadata;

    final nameFromName = metadata?['name']?.toString().trim();
    if (nameFromName != null && nameFromName.isNotEmpty) {
      return nameFromName;
    }

    final nameFromFullName = metadata?['full_name']?.toString().trim();
    if (nameFromFullName != null && nameFromFullName.isNotEmpty) {
      return nameFromFullName;
    }

    final email = user?.email?.trim();
    if (email != null && email.isNotEmpty && email.contains('@')) {
      return email.split('@').first;
    }

    return l10n.userFallbackName;
  }

  Future<void> _loadProfession() async {
    try {
      final raw = await _profileService.getProfessionProfile();

      if (!mounted) return;

      setState(() {
        _profession = raw == null || raw.isEmpty
            ? UserProfessionProfile.student
            : UserProfessionProfileX.fromName(raw);
        _isLoadingProfession = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _profession = UserProfessionProfile.student;
        _isLoadingProfession = false;
      });

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.profileLoadError(e.toString()))),
      );
    }
  }

  Future<void> _handleProfessionChanged(UserProfessionProfile value) async {
    if (_isSavingProfession) return;

    final previous = _profession;

    setState(() {
      _profession = value;
      _isSavingProfession = true;
    });

    try {
      await _profileService.updateProfessionProfile(value.name);

      if (!mounted) return;

      setState(() {
        _isSavingProfession = false;
      });

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.professionSaved)),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _profession = previous;
        _isSavingProfession = false;
      });

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.professionSaveError(e.toString())),
          duration: const Duration(seconds: 6),
        ),
      );
    }
  }

  void _openPersonalDetails() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const PersonalDetailsScreen()),
    );
  }

  Future<void> _signOut() async {
    if (_isSigningOut) return;

    final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(l10n.signOutDialogTitle),
            content: Text(l10n.signOutDialogMessage),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l10n.cancel),
              ),
              FilledButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(l10n.signOut),
              ),
            ],
          ),
        ) ??
        false;

    if (!confirmed || !mounted) return;

    setState(() {
      _isSigningOut = true;
    });

    try {
      await _authService.signOut();
    } on AuthException catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message)),
      );

      setState(() {
        _isSigningOut = false;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.signOutError(e.toString()))),
      );

      setState(() {
        _isSigningOut = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final user = Supabase.instance.client.auth.currentUser;
    final userName = _resolveUserName(user, l10n);

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F1),
      body: SafeArea(
        child: _isLoadingProfession
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF7B946D)),
              )
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 32),
                children: [
                  _ScreenTitle(
                    title: l10n.profileTitle,
                    subtitle: l10n.profileSubtitle,
                  ),
                  const SizedBox(height: 16),
                  _ProfileHeaderCard(
                    userName: userName,
                    nameLabel: l10n.nameFieldLabel,
                  ),
                  const SizedBox(height: 16),
                  _ProfileSummaryCard(
                    profession: _profession,
                    currentContextTitle: l10n.currentContextTitle,
                    professionalProfileTitle: l10n.professionalProfileTitle,
                  ),
                  const SizedBox(height: 14),
                  ProfessionProfileSelectorTile(
                    value: _profession,
                    onChanged: _handleProfessionChanged,
                  ),
                  if (_isSavingProfession) ...[
                    const SizedBox(height: 10),
                    Center(
                      child: Text(
                        l10n.savingProfessionProfile,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF7A8776),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 18),
                  _SectionCaption(l10n.accountSection),
                  const SizedBox(height: 10),
                  _ProfileSectionTile(
                    title: l10n.personalDataTitle,
                    subtitle: l10n.personalDataSubtitle,
                    icon: Icons.person_outline_rounded,
                    onTap: _openPersonalDetails,
                  ),
                  const SizedBox(height: 12),
                  _ProfileSectionTile(
                    title: l10n.billingTitle,
                    subtitle: l10n.billingSubtitle,
                    icon: Icons.credit_card_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(height: 18),
                  _SectionCaption(l10n.appSection),
                  const SizedBox(height: 10),
                  _ProfileSectionTile(
                    title: l10n.settingsTitle,
                    subtitle: l10n.settingsSubtitle,
                    icon: Icons.settings_outlined,
                    onTap: () {},
                  ),
                  const SizedBox(height: 12),
                  _ProfileSectionTile(
                    title: l10n.supportTitle,
                    subtitle: l10n.supportSubtitle,
                    icon: Icons.help_outline_rounded,
                    onTap: () {},
                  ),
                  const SizedBox(height: 22),
                  _SoftActionButton(
                    label: _isSigningOut ? l10n.signingOut : l10n.signOut,
                    icon: Icons.logout_rounded,
                    isDestructive: true,
                    onTap: _signOut,
                  ),
                ],
              ),
      ),
    );
  }
}

class _ScreenTitle extends StatelessWidget {
  const _ScreenTitle({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              height: 1.05,
              fontWeight: FontWeight.w900,
              color: Color(0xFF203024),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w600,
              color: Color(0xFF70806D),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCaption extends StatelessWidget {
  const _SectionCaption(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w800,
          color: Color(0xFF7C8C76),
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard({
    required this.userName,
    required this.nameLabel,
  });

  final String userName;
  final String nameLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.96),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFE1E7DC)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD5DDD0).withValues(alpha: 0.10),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFA6C28E), Color(0xFF7F9B6D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.center,
            child: Text(
              userName.isNotEmpty ? userName.characters.first.toUpperCase() : '?',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nameLabel,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7A8874),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 20,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF223127),
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

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({
    required this.profession,
    required this.currentContextTitle,
    required this.professionalProfileTitle,
  });

  final UserProfessionProfile profession;
  final String currentContextTitle;
  final String professionalProfileTitle;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE9F1E4), Color(0xFFDDEAD4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFB7C8AE).withValues(alpha: 0.18),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileSummaryBadge(label: currentContextTitle),
          const SizedBox(height: 12),
          Text(
            professionalProfileTitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF607058),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.78),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  profession.icon,
                  color: const Color(0xFF6E8660),
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  profession.title(l10n),
                  style: const TextStyle(
                    fontSize: 18,
                    height: 1.15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF223127),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            profession.subtitle(l10n),
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5A6A54),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSummaryBadge extends StatelessWidget {
  const _ProfileSummaryBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w800,
          color: Color(0xFF6C7F63),
        ),
      ),
    );
  }
}

class _ProfileSectionTile extends StatelessWidget {
  const _ProfileSectionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE3E8DF)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFD5DDD0).withValues(alpha: 0.08),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 14, 16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5EC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF7C9470),
                    size: 23,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF223127),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF72806E),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF9EAAA0),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SoftActionButton extends StatelessWidget {
  const _SoftActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.isDestructive = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color =
        isDestructive ? const Color(0xFF9A6C6C) : const Color(0xFF6E8563);

    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFE3E8DF)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: color,
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