/// Возвращает приветствие в зависимости от текущего времени суток.
///
/// Используется на HomeScreen для строки «Доброе утро, {имя}».
String greetingForNow([DateTime? now]) {
  final time = now ?? DateTime.now();
  final hour = time.hour;

  if (hour >= 5 && hour < 12) return 'Доброе утро';
  if (hour >= 12 && hour < 17) return 'Добрый день';
  if (hour >= 17 && hour < 23) return 'Добрый вечер';
  return 'Доброй ночи';
}
