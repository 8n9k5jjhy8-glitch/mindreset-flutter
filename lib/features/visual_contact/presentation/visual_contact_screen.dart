import 'package:flutter/material.dart';

import '../../intervention/data/repositories/sessions_repository.dart';

class VisualContactScreen extends StatefulWidget {
  const VisualContactScreen({
    super.key,
    this.arguments = const <String, dynamic>{},
    this.sessionsRepository,
  });

  final Map<String, dynamic> arguments;
  final SessionsRepository? sessionsRepository;

  @override
  State<VisualContactScreen> createState() => _VisualContactScreenState();
}

class _VisualContactScreenState extends State<VisualContactScreen> {
  late final SessionsRepository sessionsRepository;

  bool isStarting = false;
  bool isCompleting = false;
  bool isCancelling = false;
  bool sessionStarted = false;
  bool sessionCompleted = false;
  bool sessionCancelled = false;

  late String runtimeSessionId;
  late bool isPreviewRuntime;

  bool get isPreview => isPreviewRuntime;

  String get source =>
      widget.arguments['source']?.toString().trim().isNotEmpty == true
          ? widget.arguments['source'].toString().trim()
          : 'visual_contact';

  int get stressLevel =>
      int.tryParse(widget.arguments['stressLevel']?.toString() ?? '') ?? 1;

  String get stressTitle =>
      widget.arguments['stressTitle']?.toString().trim().isNotEmpty == true
          ? widget.arguments['stressTitle'].toString().trim()
          : 'Unknown';

  String get modeKey =>
      widget.arguments['modeKey']?.toString().trim().isNotEmpty == true
          ? widget.arguments['modeKey'].toString().trim()
          : 'visual_contact';

  String get modeTitle =>
      widget.arguments['modeTitle']?.toString().trim().isNotEmpty == true
          ? widget.arguments['modeTitle'].toString().trim()
          : 'Визуальный контакт с AI';

  bool get canManageSession => runtimeSessionId.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    sessionsRepository = widget.sessionsRepository ?? SessionsRepository();

    final initialStatus =
        widget.arguments['status']?.toString().trim().toLowerCase();

    runtimeSessionId =
        (widget.arguments['sessionId'] ?? widget.arguments['id'] ?? '')
            .toString()
            .trim();

    isPreviewRuntime =
        widget.arguments['isPreview'] == true || initialStatus == 'preview';

    if (!isPreview &&
        (initialStatus == 'started' || initialStatus == 'inprogress')) {
      sessionStarted = true;
    }
    if (!isPreview && initialStatus == 'completed') {
      sessionStarted = true;
      sessionCompleted = true;
    }
    if (!isPreview && initialStatus == 'cancelled') {
      sessionCancelled = true;
    }
  }

  Future<void> startPreviewSession() async {
    if (isStarting || !isPreview) return;

    setState(() => isStarting = true);

    try {
      final sessionId = await sessionsRepository.createSession(
        modeKey: modeKey,
        modeTitle: modeTitle,
        stressLevel: stressLevel,
        stressTitle: stressTitle,
        source: source,
        status: 'started',
      );

      if (!mounted) return;

      if (sessionId == null || sessionId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Не удалось начать визуальный контакт'),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() => isStarting = false);
        return;
      }

      setState(() {
        runtimeSessionId = sessionId;
        isPreviewRuntime = false;
        sessionStarted = true;
        sessionCompleted = false;
        sessionCancelled = false;
        isStarting = false;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка запуска: $e'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
      if (mounted) {
        setState(() => isStarting = false);
      }
    }
  }

  Future<void> completeSession() async {
    if (!canManageSession || isCompleting || sessionCompleted) return;

    setState(() => isCompleting = true);

    try {
      await sessionsRepository.updateSessionStatus(
        sessionId: runtimeSessionId,
        status: 'completed',
      );

      if (!mounted) return;

      setState(() {
        sessionStarted = true;
        sessionCompleted = true;
        sessionCancelled = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Визуальный контакт завершён'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.of(context).maybePop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка завершения: $e'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isCompleting = false);
      }
    }
  }

  Future<void> cancelSessionBeforeClose() async {
    if (!canManageSession) return;
    if (!sessionStarted || sessionCompleted || sessionCancelled) return;

    await sessionsRepository.updateSessionStatus(
      sessionId: runtimeSessionId,
      status: 'cancelled',
    );

    sessionCancelled = true;
  }

  Future<void> handleClose() async {
    if (isPreview) {
      if (mounted) Navigator.of(context).maybePop();
      return;
    }

    if (isStarting || isCompleting || isCancelling) return;

    setState(() => isCancelling = true);

    try {
      await cancelSessionBeforeClose();
      if (!mounted) return;
      Navigator.of(context).maybePop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не удалось безопасно закрыть сессию: $e'),
          backgroundColor: Colors.red.shade600,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => isCancelling = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isPreview ? _buildPreview(context) : _buildLive(context);
  }

  Widget _buildPreview(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      appBar: AppBar(
        title: const Text('Визуальный контакт'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: handleClose,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            Container(
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [Color(0xFFE9E1F5), Color(0xFFD8E3F2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.person_rounded,
                  size: 110,
                  color: Color(0xFF6F6A8D),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              modeTitle,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Color(0xFF253126),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'AI появляется как спокойное присутствие рядом и помогает пройти через напряжённый момент не в одиночку.',
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF667267),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                'source: $source\nstressLevel: $stressLevel\nstressTitle: $stressTitle',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF425043),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const _VisualStepCard(
              title: 'Сначала контакт',
              text:
                  'Пользователь должен почувствовать спокойное присутствие рядом, а не просто увидеть ещё один интерфейс.',
            ),
            const SizedBox(height: 12),
            const _VisualStepCard(
              title: 'Потом стабилизация',
              text:
                  'Следом AI мягко ведёт дыхание, заземление или короткий разговор, снижая интенсивность состояния.',
            ),
            const SizedBox(height: 12),
            const _VisualStepCard(
              title: 'Потом следующий шаг',
              text:
                  'После этого можно перевести человека в восстановление, сон, фокус или другой персональный сценарий помощи.',
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: isStarting ? null : startPreviewSession,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3B2F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                isStarting ? 'Запуск...' : 'Начать визуальный контакт',
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: handleClose,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('Вернуться'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLive(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      appBar: AppBar(
        title: Text(modeTitle),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon:
              isCancelling
                  ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2.2),
                  )
                  : const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: isCancelling ? null : handleClose,
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: [
            Container(
              height: 260,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [Color(0xFFE9E1F5), Color(0xFFD8E3F2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.videocam_rounded,
                  size: 96,
                  color: Color(0xFF6F6A8D),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              modeTitle,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Color(0xFF253126),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Сессия активна. Здесь позже можно будет подключить видео-персону, анимированное присутствие, голос и guided flow.',
              style: TextStyle(
                fontSize: 15,
                height: 1.45,
                color: Color(0xFF667267),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                'sessionId: $runtimeSessionId\nsource: $source\nstressLevel: $stressLevel\nstressTitle: $stressTitle',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFF425043),
                ),
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: isCompleting ? null : completeSession,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3B2F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(
                isCompleting ? 'Завершение...' : 'Завершить визуальный контакт',
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: handleClose,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('Закрыть'),
            ),
          ],
        ),
      ),
    );
  }
}

class _VisualStepCard extends StatelessWidget {
  const _VisualStepCard({required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF253126),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              height: 1.45,
              color: Color(0xFF667267),
            ),
          ),
        ],
      ),
    );
  }
}
