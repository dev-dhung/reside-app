import 'package:prototype/domain/entities/poll.dart';
import 'package:prototype/domain/repositories/poll_repository.dart';
import 'package:prototype/data/datasources/mock/mock_polls.dart';

class MockPollRepository implements PollRepository {
  final List<Poll> _polls = List.from(mockPolls);

  @override
  Future<List<Poll>> getPolls() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_polls);
  }

  @override
  Future<void> vote(String pollId, String optionId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _polls.indexWhere((p) => p.id == pollId);
    if (index == -1) return;

    final poll = _polls[index];
    final updatedOptions = poll.options.map((opt) {
      if (opt.id == optionId) {
        final newVotes = opt.votes + 1;
        final newTotal = poll.totalVotes + 1;
        return PollOption(
          id: opt.id,
          label: opt.label,
          votes: newVotes,
          percentage: (newVotes / newTotal) * 100,
        );
      }
      return opt;
    }).toList();

    _polls[index] = Poll(
      id: poll.id,
      title: poll.title,
      description: poll.description,
      options: updatedOptions,
      startDate: poll.startDate,
      endDate: poll.endDate,
      status: poll.status,
      totalVotes: poll.totalVotes + 1,
      userVote: optionId,
    );
  }

  @override
  Future<Poll> createPoll(Poll poll) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _polls.add(poll);
    return poll;
  }
}
