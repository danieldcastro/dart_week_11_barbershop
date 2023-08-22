extension StringFormattersExtension on String {
  String _firstWord() => trim().split(' ').first;

  String _lastWord() => trim().contains(' ') ? ' ${split(' ').last}' : '';

  String get firstAndLastWords {
    return _firstWord() + _lastWord();
  }

  String get firstLetters {
    return '${_firstWord()[0]}${_lastWord().isNotEmpty ? _lastWord()[1] : ''}'
        .toUpperCase();
  }
}
