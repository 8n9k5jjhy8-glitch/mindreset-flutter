import 'package:flutter/material.dart';
import 'package:mindreset_flutter/l10n/generated/app_localizations.dart';

import 'router.dart';
import 'theme.dart';

class MindResetApp extends StatefulWidget {
  const MindResetApp({super.key});

  static void setLocale(BuildContext context, Locale? locale) {
    final state = context.findAncestorStateOfType<_MindResetAppState>();
    state?.setLocale(locale);
  }

  @override
  State<MindResetApp> createState() => _MindResetAppState();
}

class _MindResetAppState extends State<MindResetApp> {
  late final _router = buildAppRouter();
  Locale? _locale = const Locale('ru');

  void setLocale(Locale? locale) {
    setState(() {
      _locale = locale ?? const Locale('ru');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MindReset',
      theme: buildMindResetTheme(),
      routerConfig: _router,
      locale: _locale ?? const Locale('ru'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
