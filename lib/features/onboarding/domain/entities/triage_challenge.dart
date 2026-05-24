/// Stable triage option identifiers aligned with Stitch `data-value` attributes.
enum TriageChallenge {
  procrastination('procrastination', 'Procrastinação'),
  forgetting('forgetting', 'Esquecer tarefas'),
  focus('focus', 'Dificuldade de foco'),
  anxiety('anxiety', 'Ansiedade'),
  starting('starting', 'Começar algo novo');

  const TriageChallenge(this.id, this.label);

  final String id;
  final String label;

  static TriageChallenge? fromId(String id) {
    for (final challenge in TriageChallenge.values) {
      if (challenge.id == id) {
        return challenge;
      }
    }
    return null;
  }

  static List<TriageChallenge> fromIds(List<String> ids) {
    return ids
        .map(fromId)
        .whereType<TriageChallenge>()
        .toList(growable: false);
  }
}
