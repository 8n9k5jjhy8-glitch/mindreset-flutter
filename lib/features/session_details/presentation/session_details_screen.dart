import 'package:flutter/material.dart';

import '../../intervention/data/models/session_record.dart';
import '../../intervention/data/repositories/sessions_repository.dart';

class SessionDetailsScreen extends StatefulWidget {
  const SessionDetailsScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  State<SessionDetailsScreen> createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  final SessionsRepository _sessionsRepository = SessionsRepository();
  final TextEditingController _noteController = TextEditingController();

  bool _isLoading = true;
  bool _isSaving = false;
  SessionRecord? _session;

  @override
  void initState() {
    super.initState();
    _loadSession();
  }

  Future<void> _loadSession() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final session = await _sessionsRepository.fetchSessionById(
        widget.sessionId,
      );
      if (!mounted) return;

      _noteController.text = session?.userNote ?? '';

      setState(() {
        _session = session;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveNote() async {
    if (_session == null) return;

    setState(() {
      _isSaving = true;
    });

    try {
      await _sessionsRepository.saveUserNote(
        sessionId: _session!.id,
        userNote: _noteController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Заметка сохранена')));

      await _loadSession();
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          'Детали сессии',
          style: TextStyle(
            color: Color(0xFF253126),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child:
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _session == null
                ? const Center(child: Text('Не удалось загрузить сессию'))
                : ListView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                  children: [
                    _DetailsCard(session: _session!),
                    const SizedBox(height: 16),
                    _UserNoteCard(
                      controller: _noteController,
                      isSaving: _isSaving,
                      onSave: _saveNote,
                    ),
                  ],
                ),
      ),
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.session});

  final SessionRecord session;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            session.modeTitle,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF253126),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Состояние: ${session.stressTitle}',
            style: const TextStyle(fontSize: 14, color: Color(0xFF667267)),
          ),
          const SizedBox(height: 6),
          Text(
            'Статус: ${session.status}',
            style: const TextStyle(fontSize: 14, color: Color(0xFF667267)),
          ),
          const SizedBox(height: 6),
          Text(
            'Источник: ${session.source ?? '—'}',
            style: const TextStyle(fontSize: 14, color: Color(0xFF667267)),
          ),
          if ((session.note ?? '').isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'Системная заметка: ${session.note}',
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Color(0xFF7A8577),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _UserNoteCard extends StatelessWidget {
  const _UserNoteCard({
    required this.controller,
    required this.isSaving,
    required this.onSave,
  });

  final TextEditingController controller;
  final bool isSaving;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Твоя заметка после сессии',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF253126),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Что помогло, что не сработало, что стоит учесть в следующий раз.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF71806F),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: controller,
            maxLines: 5,
            decoration: InputDecoration(
              hintText:
                  'Например: помог спокойный темп и короткий вход без давления...',
              filled: true,
              fillColor: const Color(0xFFF8F8F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isSaving ? null : onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3B2F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                isSaving ? 'Сохраняем...' : 'Сохранить заметку',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
