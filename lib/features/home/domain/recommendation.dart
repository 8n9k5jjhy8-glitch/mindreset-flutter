class Recommendation {
  const Recommendation({
    required this.modeKey,
    required this.modeTitle,
    required this.title,
    required this.subtitle,
    required this.source,
    required this.priority,
  });

  final String modeKey;
  final String modeTitle;
  final String title;
  final String subtitle;
  final String source;
  final int priority;
}
