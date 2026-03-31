enum PollStatus { active, closed, upcoming }

class Poll {
  final String id;
  final String title;
  final String description;
  final List<PollOption> options;
  final DateTime startDate;
  final DateTime endDate;
  final PollStatus status;
  final int totalVotes;
  final String? userVote;

  const Poll({
    required this.id,
    required this.title,
    required this.description,
    required this.options,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.totalVotes,
    this.userVote,
  });
}

class PollOption {
  final String id;
  final String label;
  final int votes;
  final double percentage;

  const PollOption({
    required this.id,
    required this.label,
    required this.votes,
    required this.percentage,
  });
}
