import 'package:flutter/material.dart';

class VisualContactScreen extends StatelessWidget {
  const VisualContactScreen({
    super.key,
    this.arguments = const <String, dynamic>{},
  });

  final Map<String, dynamic> arguments;

  @override
  Widget build(BuildContext context) {
    final source = arguments['source'];
    final stressLevel = arguments['stressLevel'];
    final stressTitle = arguments['stressTitle'];

    return Scaffold(
      backgroundColor: const Color(0xFFF7F4EF),
      appBar: AppBar(
        title: const Text('Визуальный контакт'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
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
            const Text(
              'AI-человек рядом',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Color(0xFF253126),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Здесь будет сценарий, в котором AI появляется как человек на экране и ведёт пользователя через напряжённый момент в формате живого визуального контакта.',
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
                  'Пользователь должен почувствовать, что на экране не просто текст, а чьё-то спокойное присутствие рядом.',
            ),
            const SizedBox(height: 12),
            const _VisualStepCard(
              title: 'Потом стабилизация',
              text:
                  'Следом AI мягко ведёт дыхание, заземление или короткий разговор, снижая интенсивность состояния.',
            ),
            const SizedBox(height: 12),
            const _VisualStepCard(
              title: 'Потом перевод в следующий режим',
              text:
                  'После этого можно перевести человека в восстановление, сон, фокус или другую персональную интервенцию.',
            ),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3B2F),
                foregroundColor: Colors.white,
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
