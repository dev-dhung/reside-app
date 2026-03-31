import 'package:prototype/domain/entities/poll.dart';

abstract class PollRepository {
  Future<List<Poll>> getPolls();
  Future<void> vote(String pollId, String optionId);
  Future<Poll> createPoll(Poll poll);
}
