import 'package:flutter/material.dart';
import 'package:mindreset_flutter/app/app.dart';
import 'package:mindreset_flutter/l10n/generated/app_localizations.dart';

import '../data/profile_service.dart';
import '../domain/profile.dart';

class PersonalDetailsScreen extends StatefulWidget {
  const PersonalDetailsScreen({super.key, this.profile});

  final Profile? profile;

  @override
  State<PersonalDetailsScreen> createState() => _PersonalDetailsScreenState();
}

class _PersonalDetailsScreenState extends State<PersonalDetailsScreen> {
  final ProfileService _profileService = ProfileService();

  late final TextEditingController _goalsController;
  late final TextEditingController _trustedContactNameController;
  late final TextEditingController _trustedContactPhoneController;
  late final TextEditingController _trustedContactNoteController;

  bool _isLoading = true;
  bool _isSaving = false;

  String? _preferredLanguage;
  String? _timezone;
  String? _dailyRoutine;
  String? _energyDipTime;
  String? _sessionLengthPreference;
  String? _supportStyle;
  String? _workFormat;
  String? _sleepSchedule;
  int _stressLevel = 5;
  int _energyLevel = 5;
  int _supportSystemScore = 5;
  String? _selfRegulationExperience;
  String? _emergencyHelpPreference;
  bool _hasChildren = false;
  bool _crisisPlanEnabled = false;

  final Set<String> _stressTriggers = <String>{};
  final Set<String> _sleepProblems = <String>{};

  @override
  void initState() {
    super.initState();
    _goalsController = TextEditingController();
    _trustedContactNameController = TextEditingController();
    _trustedContactPhoneController = TextEditingController();
    _trustedContactNoteController = TextEditingController();
    _bootstrap();
  }

  @override
  void dispose() {
    _goalsController.dispose();
    _trustedContactNameController.dispose();
    _trustedContactPhoneController.dispose();
    _trustedContactNoteController.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    try {
      final profile =
          widget.profile ?? await _profileService.fetchCurrentProfile();
      final trustedContact = await _profileService.fetchTrustedContact();

      if (!mounted) return;

      _fillFromProfile(profile);

      if (trustedContact != null) {
        _trustedContactNameController.text = trustedContact.name;
        _trustedContactPhoneController.text = trustedContact.phone;
        _trustedContactNoteController.text = trustedContact.note ?? '';
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.profileLoadError(e.toString()))),
      );
    }
  }

  void _fillFromProfile(Profile? profile) {
    _goalsController.text = (profile?.goals ?? '').trim();

    _preferredLanguage = _normalizeNullable(
      profile?.preferredLanguage,
      _languageValues,
    );
    _timezone = _normalizeTimezone(profile?.timezone);
    _dailyRoutine = _normalizeNullable(
      profile?.dailyRoutine,
      _dailyRoutineValues,
    );
    _energyDipTime = _normalizeEnergyDipTime(profile?.energyDipTime);
    _sessionLengthPreference = _normalizeNullable(
      profile?.sessionLengthPreference,
      _sessionLengthValues,
    );
    _supportStyle = _normalizeNullable(
      profile?.supportStyle,
      _supportStyleValues,
    );
    _workFormat = _normalizeNullable(profile?.workFormat, _workFormatValues);
    _sleepSchedule = _normalizeNullable(
      profile?.sleepSchedule,
      _sleepScheduleValues,
    );
    _stressLevel = _normalizeSlider(profile?.stressLevel);
    _energyLevel = _normalizeSlider(profile?.energyLevel);
    _supportSystemScore = _normalizeSlider(profile?.supportSystemScore);
    _selfRegulationExperience = _normalizeNullable(
      profile?.selfRegulationExperience,
      _selfRegulationValues,
    );
    _emergencyHelpPreference = _normalizeNullable(
      profile?.emergencyHelpPreference,
      _emergencyHelpValues,
    );

    _hasChildren = profile?.hasChildren ?? false;
    _crisisPlanEnabled = profile?.crisisPlanEnabled ?? false;

    _stressTriggers
      ..clear()
      ..addAll(_normalizeStringList(profile?.stressTriggers));

    _sleepProblems
      ..clear()
      ..addAll(_normalizeStringList(profile?.sleepProblems));
  }

  int _normalizeSlider(int? value) {
    if (value == null) return 5;
    if (value < 1) return 1;
    if (value > 10) return 10;
    return value;
  }

  String? _normalizeNullable(String? value, Set<String> allowed) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    return allowed.contains(normalized) ? normalized : null;
  }

  String? _normalizeTimezone(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;
    return normalized;
  }

  String? _normalizeEnergyDipTime(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return null;

    switch (normalized) {
      case 'midday':
        return 'afternoon';
      case 'late_night':
      case 'irregular':
        return 'none';
      default:
        return _energyDipTimeValues.contains(normalized) ? normalized : null;
    }
  }

  List<String> _normalizeStringList(List<String>? values) {
    if (values == null) return const [];
    return values
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toSet()
        .toList();
  }

  bool get _hasTrustedContactData {
    return _trustedContactNameController.text.trim().isNotEmpty ||
        _trustedContactPhoneController.text.trim().isNotEmpty ||
        _trustedContactNoteController.text.trim().isNotEmpty;
  }

  List<_OptionItem> get _resolvedTimezoneItems {
    final items = List<_OptionItem>.from(_timezoneItems);

    final selected = _timezone?.trim();
    if (selected != null &&
        selected.isNotEmpty &&
        !items.any((item) => item.value == selected)) {
      items.insert(
        0,
        _OptionItem(selected, (_) => _buildTimezoneLabel(selected)),
      );
    }

    return items;
  }

  Future<void> _save() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final normalizedGoals = _goalsController.text.trim();
      final trustedName = _trustedContactNameController.text.trim();
      final trustedPhone = _trustedContactPhoneController.text.trim();
      final trustedNote = _trustedContactNoteController.text.trim();

      await _profileService.updatePersonalData(
        hasChildren: _hasChildren,
        sleepSchedule: _sleepSchedule,
        stressLevel: _stressLevel,
        energyLevel: _energyLevel,
        goals: normalizedGoals.isEmpty ? null : normalizedGoals,
        preferredLanguage: _preferredLanguage,
        timezone: _timezone,
        dailyRoutine: _dailyRoutine,
        energyDipTime: _energyDipTime,
        sessionLengthPreference: _sessionLengthPreference,
        supportStyle: _supportStyle,
        workFormat: _workFormat,
        stressTriggers: _stressTriggers.toList(),
        sleepProblems: _sleepProblems.toList(),
        supportSystemScore: _supportSystemScore,
        selfRegulationExperience: _selfRegulationExperience,
        emergencyHelpPreference: _emergencyHelpPreference,
        crisisPlanEnabled: _crisisPlanEnabled,
      );

      if (trustedName.isEmpty && trustedPhone.isEmpty && trustedNote.isEmpty) {
        await _profileService.clearTrustedContact();
      } else {
        await _profileService.saveTrustedContact(
          name: trustedName,
          phone: trustedPhone,
          note: trustedNote.isEmpty ? null : trustedNote,
        );
      }

      if (!mounted) return;
      if (_preferredLanguage != null && _preferredLanguage!.isNotEmpty) {
        MindResetApp.setLocale(context, Locale(_preferredLanguage!));
      }
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.personalDataSaveError(e.toString()))),
      );
    }
  }

  InputDecoration _inputDecoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFDCE4D5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFFE1E8DB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(color: Color(0xFF8DA47B), width: 1.4),
      ),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.92),
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      alignLabelWithHint: true,
      labelStyle: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF87907F),
      ),
      hintStyle: const TextStyle(fontSize: 15, color: Color(0xFF9AA297)),
    );
  }

  Widget _buildSectionTitle(String title, {String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF223127),
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 13,
                height: 1.35,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7D867B),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<_OptionItem> items,
    required ValueChanged<String?> onChanged,
    double? menuMaxHeight,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      menuMaxHeight: menuMaxHeight,
      icon: const Icon(Icons.expand_more_rounded, color: Color(0xFF6F786C)),
      borderRadius: BorderRadius.circular(20),
      decoration: _inputDecoration(label),
      items:
          items
              .map(
                (item) => DropdownMenuItem<String>(
                  value: item.value,
                  child: Text(
                    item.label(l10n),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF223127),
                    ),
                  ),
                ),
              )
              .toList(),
      selectedItemBuilder: (context) {
        return items
            .map(
              (item) => Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  item.label(l10n),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF223127),
                  ),
                ),
              ),
            )
            .toList();
      },
      onChanged: onChanged,
    );
  }

  Widget _buildSlider({
    required String title,
    required int value,
    required ValueChanged<double> onChanged,
    required String leading,
    required String trailing,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: $value/10',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 15,
            color: Color(0xFF223127),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            SizedBox(
              width: 68,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    leading,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF788175),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 9,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 18,
                  ),
                ),
                child: Slider(
                  value: value.toDouble(),
                  min: 1,
                  max: 10,
                  divisions: 9,
                  onChanged: onChanged,
                ),
              ),
            ),
            SizedBox(
              width: 68,
              child: Align(
                alignment: Alignment.centerRight,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    trailing,
                    maxLines: 1,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF788175),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChipGroup({
    required String title,
    required String subtitle,
    required List<_OptionItem> items,
    required Set<String> selected,
    required ValueChanged<String> onToggle,
  }) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 15,
            color: Color(0xFF223127),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF7D867B),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children:
              items.map((item) {
                final isSelected = selected.contains(item.value);
                return FilterChip(
                  label: Text(
                    item.label(l10n),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color:
                          isSelected
                              ? const Color(0xFF2B402A)
                              : const Color(0xFF465246),
                    ),
                  ),
                  selected: isSelected,
                  onSelected: (_) => onToggle(item.value),
                  backgroundColor: Colors.white.withValues(alpha: 0.9),
                  selectedColor: const Color(0xFFDDF0D9),
                  side: BorderSide(
                    color:
                        isSelected
                            ? const Color(0xFFB7D6B2)
                            : const Color(0xFFDCE4D7),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  showCheckmark: true,
                  checkmarkColor: const Color(0xFF466B40),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  void _toggleStressTrigger(String value) {
    setState(() {
      if (_stressTriggers.contains(value)) {
        _stressTriggers.remove(value);
      } else {
        _stressTriggers.add(value);
      }
    });
  }

  void _toggleSleepProblem(String value) {
    setState(() {
      if (_sleepProblems.contains(value)) {
        _sleepProblems.remove(value);
      } else {
        _sleepProblems.add(value);
      }
    });
  }

  void _clearTrustedContact() {
    setState(() {
      _trustedContactNameController.clear();
      _trustedContactPhoneController.clear();
      _trustedContactNoteController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final timezoneItems = _resolvedTimezoneItems;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F6F1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF3F6F1),
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          l10n.personalDataTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF223127),
          ),
        ),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 28),
                children: [
                  _buildSectionTitle(
                    l10n.personalDetailsBasicsTitle,
                    subtitle: l10n.personalDetailsBasicsSubtitle,
                  ),
                  _buildDropdown(
                    label: l10n.personalDetailsLanguage,
                    value: _preferredLanguage,
                    items: _languageItems,
                    menuMaxHeight: 320,
                    onChanged:
                        (value) => setState(() => _preferredLanguage = value),
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: l10n.personalDetailsTimeZone,
                    value: _timezone,
                    items: timezoneItems,
                    menuMaxHeight: 360,
                    onChanged: (value) => setState(() => _timezone = value),
                  ),
                  const SizedBox(height: 6),
                  Padding(
                    padding: const EdgeInsets.only(left: 4, top: 2),
                    child: Text(
                      l10n.personalDetailsTimeZoneHint,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8A9388),
                      ),
                    ),
                  ),
                  const SizedBox(height: 22),
                  _buildSectionTitle(
                    l10n.personalDetailsDailyRhythmTitle,
                    subtitle: l10n.personalDetailsDailyRhythmSubtitle,
                  ),
                  _buildDropdown(
                    label: l10n.personalDetailsDailyRoutine,
                    value: _dailyRoutine,
                    items: _dailyRoutineItems,
                    onChanged: (value) => setState(() => _dailyRoutine = value),
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: l10n.personalDetailsEnergyDip,
                    value: _energyDipTime,
                    items: _energyDipTimeItems,
                    onChanged:
                        (value) => setState(() => _energyDipTime = value),
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: l10n.personalDetailsSessionFormat,
                    value: _sessionLengthPreference,
                    items: _sessionLengthItems,
                    onChanged:
                        (value) =>
                            setState(() => _sessionLengthPreference = value),
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: l10n.personalDetailsWorkFormat,
                    value: _workFormat,
                    items: _workFormatItems,
                    onChanged: (value) => setState(() => _workFormat = value),
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: l10n.personalDetailsSleepScheduleLabel,
                    value: _sleepSchedule,
                    items: _sleepScheduleItems,
                    onChanged:
                        (value) => setState(() => _sleepSchedule = value),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n.personalDetailsHasChildrenLabel,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    value: _hasChildren,
                    onChanged: (value) => setState(() => _hasChildren = value),
                  ),
                  const SizedBox(height: 22),
                  _buildSectionTitle(
                    l10n.personalDetailsStateTitle,
                    subtitle: l10n.personalDetailsStateSubtitle,
                  ),
                  _buildSlider(
                    title: l10n.personalDetailsCurrentStress,
                    value: _stressLevel,
                    leading: l10n.personalDetailsLow,
                    trailing: l10n.personalDetailsHigh,
                    onChanged:
                        (value) => setState(() => _stressLevel = value.round()),
                  ),
                  const SizedBox(height: 8),
                  _buildSlider(
                    title: l10n.personalDetailsCurrentEnergy,
                    value: _energyLevel,
                    leading: l10n.personalDetailsLow,
                    trailing: l10n.personalDetailsHigh,
                    onChanged:
                        (value) => setState(() => _energyLevel = value.round()),
                  ),
                  const SizedBox(height: 8),
                  _buildSlider(
                    title: l10n.personalDetailsSupportSystem,
                    value: _supportSystemScore,
                    leading: l10n.personalDetailsWeak,
                    trailing: l10n.personalDetailsStrong,
                    onChanged:
                        (value) =>
                            setState(() => _supportSystemScore = value.round()),
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: l10n.personalDetailsSupportStyle,
                    value: _supportStyle,
                    items: _supportStyleItems,
                    onChanged: (value) => setState(() => _supportStyle = value),
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: l10n.personalDetailsSelfHelpExperience,
                    value: _selfRegulationExperience,
                    items: _selfRegulationItems,
                    onChanged:
                        (value) =>
                            setState(() => _selfRegulationExperience = value),
                  ),
                  const SizedBox(height: 14),
                  _buildDropdown(
                    label: l10n.personalDetailsEmergencyHelp,
                    value: _emergencyHelpPreference,
                    items: _emergencyHelpItems,
                    onChanged:
                        (value) =>
                            setState(() => _emergencyHelpPreference = value),
                  ),
                  const SizedBox(height: 10),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n.personalDetailsCrisisPlanTitle,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      l10n.personalDetailsCrisisPlanSubtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.35,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    value: _crisisPlanEnabled,
                    onChanged:
                        (value) => setState(() => _crisisPlanEnabled = value),
                  ),
                  const SizedBox(height: 22),
                  _buildSectionTitle(
                    l10n.personalDetailsTriggersSleepTitle,
                    subtitle: l10n.personalDetailsTriggersSleepSubtitle,
                  ),
                  _buildChipGroup(
                    title: l10n.personalDetailsStressTriggersTitle,
                    subtitle: l10n.personalDetailsChooseAllThatApply,
                    items: _stressTriggerItems,
                    selected: _stressTriggers,
                    onToggle: _toggleStressTrigger,
                  ),
                  const SizedBox(height: 18),
                  _buildChipGroup(
                    title: l10n.personalDetailsSleepProblemsTitle,
                    subtitle: l10n.personalDetailsChooseAllThatFit,
                    items: _sleepProblemItems,
                    selected: _sleepProblems,
                    onToggle: _toggleSleepProblem,
                  ),
                  const SizedBox(height: 22),
                  _buildSectionTitle(
                    l10n.personalDataGoals,
                    subtitle: l10n.personalDetailsGoalsSubtitle,
                  ),
                  TextFormField(
                    controller: _goalsController,
                    minLines: 4,
                    maxLines: 6,
                    decoration: _inputDecoration(
                      l10n.personalDataGoals,
                      hint: l10n.personalDetailsGoalsHint,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: 22),
                  _buildSectionTitle(
                    l10n.personalDetailsTrustedContactTitle,
                    subtitle: l10n.personalDetailsTrustedContactSubtitle,
                  ),
                  TextFormField(
                    controller: _trustedContactNameController,
                    decoration: _inputDecoration(
                      l10n.personalDetailsName,
                      hint: l10n.personalDetailsNameHint,
                    ),
                    textCapitalization: TextCapitalization.words,
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _trustedContactPhoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _inputDecoration(
                      l10n.personalDetailsPhone,
                      hint: '+972 50 123 45 67',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _trustedContactNoteController,
                    minLines: 2,
                    maxLines: 3,
                    decoration: _inputDecoration(
                      l10n.personalDetailsNote,
                      hint: l10n.personalDetailsNoteHint,
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (_) => setState(() {}),
                  ),
                  if (_hasTrustedContactData) ...[
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: _clearTrustedContact,
                        icon: const Icon(Icons.delete_outline_rounded),
                        label: Text(l10n.personalDetailsClearContact),
                      ),
                    ),
                  ],
                  const SizedBox(height: 26),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _isSaving ? null : _save,
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFF6D8B5B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(
                        _isSaving
                            ? l10n.personalDataSaving
                            : l10n.personalDataSave,
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}

class _OptionItem {
  const _OptionItem(this.value, this.labelBuilder);

  final String value;
  final String Function(AppLocalizations l10n) labelBuilder;

  String label(AppLocalizations l10n) => labelBuilder(l10n);
}

String _buildTimezoneLabel(String timezone) {
  const customLabels = <String, String>{
    'Asia/Jerusalem': 'Israel — Asia/Jerusalem',
    'Europe/Moscow': 'Moscow — Europe/Moscow',
    'Europe/Berlin': 'Berlin — Europe/Berlin',
    'Europe/London': 'London — Europe/London',
    'America/New_York': 'New York — America/New_York',
    'America/Los_Angeles': 'Los Angeles — America/Los_Angeles',
    'America/Toronto': 'Toronto — America/Toronto',
    'America/Chicago': 'Chicago — America/Chicago',
    'America/Miami': 'Miami — America/New_York',
    'Europe/Paris': 'Paris — Europe/Paris',
    'Europe/Warsaw': 'Warsaw — Europe/Warsaw',
    'Europe/Kyiv': 'Kyiv — Europe/Kyiv',
    'Europe/Riga': 'Riga — Europe/Riga',
    'Europe/Vilnius': 'Vilnius — Europe/Vilnius',
    'Europe/Tallinn': 'Tallinn — Europe/Tallinn',
    'Asia/Tbilisi': 'Tbilisi — Asia/Tbilisi',
    'Asia/Yerevan': 'Yerevan — Asia/Yerevan',
    'Asia/Baku': 'Baku — Asia/Baku',
    'Asia/Dubai': 'Dubai — Asia/Dubai',
    'Asia/Istanbul': 'Istanbul — Europe/Istanbul',
    'Asia/Almaty': 'Almaty — Asia/Almaty',
    'Asia/Tashkent': 'Tashkent — Asia/Tashkent',
    'Asia/Bishkek': 'Bishkek — Asia/Bishkek',
    'Asia/Bangkok': 'Bangkok — Asia/Bangkok',
    'Asia/Singapore': 'Singapore — Asia/Singapore',
    'Asia/Tokyo': 'Tokyo — Asia/Tokyo',
    'Asia/Seoul': 'Seoul — Asia/Seoul',
    'Australia/Sydney': 'Sydney — Australia/Sydney',
  };

  return customLabels[timezone] ?? timezone.replaceAll('_', ' ');
}

const Set<String> _languageValues = {'ru', 'en', 'he'};

const Set<String> _dailyRoutineValues = {'early_bird', 'balanced', 'night_owl'};

const Set<String> _energyDipTimeValues = {
  'morning',
  'afternoon',
  'evening',
  'none',
};

const Set<String> _sessionLengthValues = {'short', 'medium', 'long'};

const Set<String> _supportStyleValues = {
  'gentle',
  'structured',
  'direct',
  'warm',
};

const Set<String> _workFormatValues = {
  'office',
  'remote',
  'hybrid',
  'shift',
  'flexible',
  'other',
};

const Set<String> _sleepScheduleValues = {'stable', 'unstable', 'shift'};

const Set<String> _selfRegulationValues = {
  'none',
  'beginner',
  'intermediate',
  'advanced',
};

const Set<String> _emergencyHelpValues = {
  'self_help',
  'contact_person',
  'hotline',
  'depends',
};

final List<_OptionItem> _languageItems = [
  _OptionItem('ru', (_) => 'Russian'),
  _OptionItem('en', (_) => 'English'),
  _OptionItem('he', (_) => 'עברית'),
];

final List<_OptionItem> _timezoneItems = [
  _OptionItem('Asia/Jerusalem', (_) => _buildTimezoneLabel('Asia/Jerusalem')),
  _OptionItem('Europe/Moscow', (_) => _buildTimezoneLabel('Europe/Moscow')),
  _OptionItem('Europe/Berlin', (_) => _buildTimezoneLabel('Europe/Berlin')),
  _OptionItem('Europe/London', (_) => _buildTimezoneLabel('Europe/London')),
  _OptionItem(
    'America/New_York',
    (_) => _buildTimezoneLabel('America/New_York'),
  ),
  _OptionItem(
    'America/Los_Angeles',
    (_) => _buildTimezoneLabel('America/Los_Angeles'),
  ),
  _OptionItem('America/Toronto', (_) => _buildTimezoneLabel('America/Toronto')),
  _OptionItem('America/Chicago', (_) => _buildTimezoneLabel('America/Chicago')),
  _OptionItem('America/Miami', (_) => _buildTimezoneLabel('America/Miami')),
  _OptionItem('Europe/Paris', (_) => _buildTimezoneLabel('Europe/Paris')),
  _OptionItem('Europe/Warsaw', (_) => _buildTimezoneLabel('Europe/Warsaw')),
  _OptionItem('Europe/Kyiv', (_) => _buildTimezoneLabel('Europe/Kyiv')),
  _OptionItem('Europe/Riga', (_) => _buildTimezoneLabel('Europe/Riga')),
  _OptionItem('Europe/Vilnius', (_) => _buildTimezoneLabel('Europe/Vilnius')),
  _OptionItem('Europe/Tallinn', (_) => _buildTimezoneLabel('Europe/Tallinn')),
  _OptionItem('Asia/Tbilisi', (_) => _buildTimezoneLabel('Asia/Tbilisi')),
  _OptionItem('Asia/Yerevan', (_) => _buildTimezoneLabel('Asia/Yerevan')),
  _OptionItem('Asia/Baku', (_) => _buildTimezoneLabel('Asia/Baku')),
  _OptionItem('Asia/Dubai', (_) => _buildTimezoneLabel('Asia/Dubai')),
  _OptionItem('Asia/Istanbul', (_) => _buildTimezoneLabel('Asia/Istanbul')),
  _OptionItem('Asia/Almaty', (_) => _buildTimezoneLabel('Asia/Almaty')),
  _OptionItem('Asia/Tashkent', (_) => _buildTimezoneLabel('Asia/Tashkent')),
  _OptionItem('Asia/Bishkek', (_) => _buildTimezoneLabel('Asia/Bishkek')),
  _OptionItem('Asia/Bangkok', (_) => _buildTimezoneLabel('Asia/Bangkok')),
  _OptionItem('Asia/Singapore', (_) => _buildTimezoneLabel('Asia/Singapore')),
  _OptionItem('Asia/Tokyo', (_) => _buildTimezoneLabel('Asia/Tokyo')),
  _OptionItem('Asia/Seoul', (_) => _buildTimezoneLabel('Asia/Seoul')),
  _OptionItem(
    'Australia/Sydney',
    (_) => _buildTimezoneLabel('Australia/Sydney'),
  ),
];

final List<_OptionItem> _dailyRoutineItems = [
  _OptionItem('early_bird', (l10n) => l10n.personalDetailsRoutineEarlyBird),
  _OptionItem('balanced', (l10n) => l10n.personalDetailsRoutineBalanced),
  _OptionItem('night_owl', (l10n) => l10n.personalDetailsRoutineNightOwl),
];

final List<_OptionItem> _energyDipTimeItems = [
  _OptionItem('morning', (l10n) => l10n.personalDetailsDipMorning),
  _OptionItem('afternoon', (l10n) => l10n.personalDetailsDipAfternoon),
  _OptionItem('evening', (l10n) => l10n.personalDetailsDipEvening),
  _OptionItem('none', (l10n) => l10n.personalDetailsDipNone),
];

final List<_OptionItem> _sessionLengthItems = [
  _OptionItem('short', (l10n) => l10n.personalDetailsSessionShort),
  _OptionItem('medium', (l10n) => l10n.personalDetailsSessionMedium),
  _OptionItem('long', (l10n) => l10n.personalDetailsSessionLong),
];

final List<_OptionItem> _supportStyleItems = [
  _OptionItem('gentle', (l10n) => l10n.personalDetailsSupportGentle),
  _OptionItem('structured', (l10n) => l10n.personalDetailsSupportStructured),
  _OptionItem('direct', (l10n) => l10n.personalDetailsSupportDirect),
  _OptionItem('warm', (l10n) => l10n.personalDetailsSupportWarm),
];

final List<_OptionItem> _workFormatItems = [
  _OptionItem('office', (l10n) => l10n.personalDetailsWorkOffice),
  _OptionItem('remote', (l10n) => l10n.personalDetailsWorkRemote),
  _OptionItem('hybrid', (l10n) => l10n.personalDetailsWorkHybrid),
  _OptionItem('shift', (l10n) => l10n.personalDetailsWorkShift),
  _OptionItem('flexible', (l10n) => l10n.personalDetailsWorkFlexible),
  _OptionItem('other', (l10n) => l10n.personalDetailsWorkOther),
];

final List<_OptionItem> _sleepScheduleItems = [
  _OptionItem('stable', (l10n) => l10n.personalDetailsSleepStableOption),
  _OptionItem('unstable', (l10n) => l10n.personalDetailsSleepUnstableOption),
  _OptionItem('shift', (l10n) => l10n.personalDetailsSleepShiftOption),
];

final List<_OptionItem> _selfRegulationItems = [
  _OptionItem('none', (l10n) => l10n.personalDetailsExperienceNone),
  _OptionItem('beginner', (l10n) => l10n.personalDetailsExperienceBeginner),
  _OptionItem(
    'intermediate',
    (l10n) => l10n.personalDetailsExperienceIntermediate,
  ),
  _OptionItem('advanced', (l10n) => l10n.personalDetailsExperienceAdvanced),
];

final List<_OptionItem> _emergencyHelpItems = [
  _OptionItem('self_help', (l10n) => l10n.personalDetailsEmergencySelfHelp),
  _OptionItem(
    'contact_person',
    (l10n) => l10n.personalDetailsEmergencyContactPerson,
  ),
  _OptionItem('hotline', (l10n) => l10n.personalDetailsEmergencyHotline),
  _OptionItem('depends', (l10n) => l10n.personalDetailsEmergencyDepends),
];

final List<_OptionItem> _stressTriggerItems = [
  _OptionItem('work', (l10n) => l10n.personalDetailsTriggerWork),
  _OptionItem('career', (l10n) => l10n.personalDetailsTriggerCareer),
  _OptionItem('family', (l10n) => l10n.personalDetailsTriggerFamily),
  _OptionItem(
    'relationships',
    (l10n) => l10n.personalDetailsTriggerRelationships,
  ),
  _OptionItem('sleep', (l10n) => l10n.personalDetailsTriggerSleep),
  _OptionItem('health', (l10n) => l10n.personalDetailsTriggerHealth),
  _OptionItem('money', (l10n) => l10n.personalDetailsTriggerMoney),
  _OptionItem('uncertainty', (l10n) => l10n.personalDetailsTriggerUncertainty),
  _OptionItem('anxiety', (l10n) => l10n.personalDetailsTriggerAnxiety),
  _OptionItem('social', (l10n) => l10n.personalDetailsTriggerSocial),
];

final List<_OptionItem> _sleepProblemItems = [
  _OptionItem(
    'falling_asleep',
    (l10n) => l10n.personalDetailsSleepProblemFallingAsleep,
  ),
  _OptionItem(
    'night_waking',
    (l10n) => l10n.personalDetailsSleepProblemNightWaking,
  ),
  _OptionItem(
    'early_waking',
    (l10n) => l10n.personalDetailsSleepProblemEarlyWaking,
  ),
  _OptionItem(
    'light_sleep',
    (l10n) => l10n.personalDetailsSleepProblemLightSleep,
  ),
  _OptionItem(
    'racing_thoughts',
    (l10n) => l10n.personalDetailsSleepProblemRacingThoughts,
  ),
  _OptionItem(
    'irregular_schedule',
    (l10n) => l10n.personalDetailsSleepProblemIrregularSchedule,
  ),
];
