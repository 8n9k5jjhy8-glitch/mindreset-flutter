String normalizeSessionModeKey(String? raw) {
  final normalized = (raw ?? '')
      .trim()
      .toLowerCase()
      .replaceAll('_', '')
      .replaceAll('-', '')
      .replaceAll(' ', '');

  switch (normalized) {
    case 'calm':
      return 'calm';

    case 'energy':
    case 'needenergy':
      return 'energy';

    case 'sleep':
    case 'sleeppreparation':
      return 'sleep';

    case 'focus':
    case 'wanttofocus':
      return 'focus';

    case 'recovery':
    case 'quickreset':
    case 'guided':
    case 'softsupport':
      return 'recovery';

    case 'visualcontact':
      return 'visual_contact';

    case 'trustedcontact':
      return 'trusted_contact';

    case 'urgenthelp':
      return 'urgent_help';

    default:
      return 'recovery';
  }
}

bool isTrustedContactMode(String? raw) {
  return normalizeSessionModeKey(raw) == 'trusted_contact';
}
