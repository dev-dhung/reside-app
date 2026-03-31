import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/domain/entities/poll.dart';
import 'package:prototype/data/datasources/mock/mock_polls.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_button.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/atoms/app_text_field.dart';
import 'package:prototype/presentation/atoms/status_badge.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class VotingPage extends StatefulWidget {
  final bool isAdmin;

  const VotingPage({super.key, this.isAdmin = false});

  @override
  State<VotingPage> createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  int _selectedTab = 0;
  late List<Poll> _polls;

  final Map<String, String> _selectedOptions = {};

  L10n get l10n => L10n.of(context);

  @override
  void initState() {
    super.initState();
    _polls = List.from(mockPolls);
  }

  List<Poll> _filterPolls(PollStatus status) =>
      _polls.where((p) => p.status == status).toList();

  void _vote(Poll poll) {
    final optionId = _selectedOptions[poll.id];
    if (optionId == null) return;

    setState(() {
      final index = _polls.indexWhere((p) => p.id == poll.id);
      if (index == -1) return;

      final newTotal = poll.totalVotes + 1;
      final updatedOptions = poll.options.map((opt) {
        final newVotes = opt.id == optionId ? opt.votes + 1 : opt.votes;
        return PollOption(
          id: opt.id,
          label: opt.label,
          votes: newVotes,
          percentage: (newVotes / newTotal) * 100,
        );
      }).toList();

      _polls[index] = Poll(
        id: poll.id,
        title: poll.title,
        description: poll.description,
        options: updatedOptions,
        startDate: poll.startDate,
        endDate: poll.endDate,
        status: poll.status,
        totalVotes: newTotal,
        userVote: optionId,
      );
      _selectedOptions.remove(poll.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.voteRegisteredSuccess),
        backgroundColor: AppColors.success,
      ),
    );
  }

  void _closePollEarly(Poll poll) {
    setState(() {
      final index = _polls.indexWhere((p) => p.id == poll.id);
      if (index == -1) return;
      _polls[index] = Poll(
        id: poll.id,
        title: poll.title,
        description: poll.description,
        options: poll.options,
        startDate: poll.startDate,
        endDate: DateTime.now(),
        status: PollStatus.closed,
        totalVotes: poll.totalVotes,
        userVote: poll.userVote,
      );
    });
  }

  void _showCreatePollSheet() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    final optionControllers = <TextEditingController>[
      TextEditingController(),
      TextEditingController(),
    ];
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 14));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXXL),
        ),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => Padding(
          padding: EdgeInsets.only(
            left: AppDimensions.paddingLarge,
            right: AppDimensions.paddingLarge,
            top: AppDimensions.paddingLarge,
            bottom: MediaQuery.of(ctx).viewInsets.bottom +
                AppDimensions.paddingLarge,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                Text(
                  l10n.createPollTitle,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontXL,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingXL),
                AppTextField(
                  label: l10n.pollTitleLabel,
                  controller: titleController,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                AppTextField(
                  label: l10n.pollDescriptionLabel,
                  controller: descController,
                  maxLines: 3,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                Text(
                  l10n.optionsLabel,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontMedium,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                ...optionControllers.asMap().entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(
                            bottom: AppDimensions.paddingSmall),
                        child: AppTextField(
                          label: l10n.optionNumber(entry.key + 1),
                          controller: entry.value,
                        ),
                      ),
                    ),
                TextButton.icon(
                  onPressed: () {
                    setSheetState(() {
                      optionControllers.add(TextEditingController());
                    });
                  },
                  icon: const Icon(Icons.add,
                      size: AppDimensions.iconSmall,
                      color: AppColors.primary),
                  label: Text(
                    l10n.addOptionButton,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                Row(
                  children: [
                    Expanded(
                      child: _DatePickerField(
                        label: l10n.startDateLabel,
                        date: startDate,
                        onPicked: (d) =>
                            setSheetState(() => startDate = d),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    Expanded(
                      child: _DatePickerField(
                        label: l10n.endDateLabel,
                        date: endDate,
                        onPicked: (d) =>
                            setSheetState(() => endDate = d),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingXL),
                AppButton(
                  label: l10n.createPollButton,
                  onPressed: () {
                    final title = titleController.text.trim();
                    if (title.isEmpty) return;

                    final options = optionControllers
                        .where((c) => c.text.trim().isNotEmpty)
                        .toList();
                    if (options.length < 2) return;

                    final newPoll = Poll(
                      id: 'poll-${DateTime.now().millisecondsSinceEpoch}',
                      title: title,
                      description: descController.text.trim(),
                      options: options
                          .asMap()
                          .entries
                          .map((e) => PollOption(
                                id: 'opt-new-${e.key}',
                                label: e.value.text.trim(),
                                votes: 0,
                                percentage: 0,
                              ))
                          .toList(),
                      startDate: startDate,
                      endDate: endDate,
                      status: startDate.isAfter(DateTime.now())
                          ? PollStatus.upcoming
                          : PollStatus.active,
                      totalVotes: 0,
                    );

                    setState(() => _polls.add(newPoll));
                    Navigator.of(ctx).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.pollCreatedSuccess),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tabLabels = [l10n.tabActive, l10n.tabClosed, l10n.tabUpcoming];
    final tabStatuses = [
      PollStatus.active,
      PollStatus.closed,
      PollStatus.upcoming,
    ];

    return BaseScaffold(
      title: widget.isAdmin
          ? l10n.votingAdminTitle
          : l10n.votingResidentTitle,
      floatingActionButton: widget.isAdmin
          ? FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: _showCreatePollSheet,
              child:
                  const Icon(Icons.add, color: AppColors.textOnPrimary),
            )
          : null,
      body: Column(
        children: [
          // Custom pill tabs
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.paddingMedium,
              AppDimensions.paddingMedium,
              AppDimensions.paddingMedium,
              AppDimensions.paddingSmall,
            ),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusPill),
              ),
              child: Row(
                children: List.generate(tabLabels.length, (i) {
                  final isActive = _selectedTab == i;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            vertical: AppDimensions.paddingSmall + 2),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusPill),
                        ),
                        child: Center(
                          child: Text(
                            tabLabels[i],
                            style: TextStyle(
                              fontSize: AppDimensions.fontBody,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isActive
                                  ? AppColors.textOnPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          Expanded(
            child: _buildPollList(tabStatuses[_selectedTab]),
          ),
        ],
      ),
    );
  }

  Widget _buildPollList(PollStatus status) {
    final polls = _filterPolls(status);
    if (polls.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.how_to_vote_outlined,
                  size: AppDimensions.iconXL,
                  color: AppColors.textTertiary),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Text(
              status == PollStatus.active
                  ? l10n.noActivePolls
                  : status == PollStatus.closed
                      ? l10n.noClosedPolls
                      : l10n.noUpcomingPolls,
              style: const TextStyle(
                fontSize: AppDimensions.fontMedium,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      itemCount: polls.length,
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
        child: _buildPollCard(polls[i]),
      ),
    );
  }

  Widget _buildPollCard(Poll poll) {
    final hasVoted = poll.userVote != null;
    final showResults =
        hasVoted || poll.status == PollStatus.closed;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  poll.title,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontLarge,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingSmall),
              _statusBadge(poll.status),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Text(
            poll.description,
            style: const TextStyle(
              fontSize: AppDimensions.fontBody,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          if (poll.status == PollStatus.upcoming)
            _buildUpcomingInfo(poll)
          else if (showResults)
            _buildResults(poll)
          else
            _buildVoteOptions(poll),

          // Participation indicator
          if (poll.status == PollStatus.active ||
              poll.status == PollStatus.closed) ...[
            const SizedBox(height: AppDimensions.paddingMedium),
            _buildParticipationBar(poll),
          ],

          // Admin extras
          if (widget.isAdmin && poll.status == PollStatus.active) ...[
            const SizedBox(height: AppDimensions.paddingSmall),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => _closePollEarly(poll),
                child: Text(
                  l10n.closePollButton,
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildParticipationBar(Poll poll) {
    // A simple linear participation indicator
    final maxVotes = 20; // Assume ~20 residents for demo
    final progress =
        (poll.totalVotes / maxVotes).clamp(0.0, 1.0);
    final label = poll.status == PollStatus.active
        ? l10n.participationActive(poll.totalVotes)
        : l10n.participationClosed(poll.totalVotes);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: AppDimensions.fontSmall,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Text(
              '${(progress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: AppDimensions.fontSmall,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingXS),
        ClipRRect(
          borderRadius:
              BorderRadius.circular(AppDimensions.radiusPill),
          child: SizedBox(
            height: 6,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.divider,
              valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(PollStatus status) {
    switch (status) {
      case PollStatus.active:
        return StatusBadge(
            label: l10n.pollStatusActive, color: AppColors.success);
      case PollStatus.closed:
        return StatusBadge(
            label: l10n.pollStatusClosed,
            color: AppColors.textSecondary);
      case PollStatus.upcoming:
        return StatusBadge(
            label: l10n.pollStatusUpcoming, color: AppColors.info);
    }
  }

  Widget _buildUpcomingInfo(Poll poll) {
    final formatter = _formatDate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.calendar_today,
                size: AppDimensions.iconSmall,
                color: AppColors.textSecondary),
            const SizedBox(width: AppDimensions.paddingSmall),
            Text(
              l10n.pollStartsOn(formatter(poll.startDate)),
              style: const TextStyle(
                fontSize: AppDimensions.fontBody,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingXS),
        Row(
          children: [
            const Icon(Icons.calendar_today,
                size: AppDimensions.iconSmall,
                color: AppColors.textSecondary),
            const SizedBox(width: AppDimensions.paddingSmall),
            Text(
              l10n.pollEndsOn(formatter(poll.endDate)),
              style: const TextStyle(
                fontSize: AppDimensions.fontBody,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVoteOptions(Poll poll) {
    return Column(
      children: [
        RadioGroup<String>(
          groupValue: _selectedOptions[poll.id] ?? '',
          onChanged: (val) {
            if (val != null) {
              setState(() => _selectedOptions[poll.id] = val);
            }
          },
          child: Column(
            children: poll.options
                .map((opt) => RadioListTile<String>(
                      title: Text(
                        opt.label,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontBody,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      value: opt.id,
                      toggleable: false,
                      activeColor: AppColors.primary,
                      contentPadding: EdgeInsets.zero,
                    ))
                .toList(),
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        AppButton(
          label: l10n.voteButton,
          onPressed: _selectedOptions.containsKey(poll.id)
              ? () => _vote(poll)
              : null,
        ),
      ],
    );
  }

  Widget _buildResults(Poll poll) {
    final colors = [
      AppColors.primary,
      AppColors.accent,
      AppColors.info,
      AppColors.success,
      AppColors.warning,
    ];
    return Column(
      children: poll.options.asMap().entries.map((entry) {
        final i = entry.key;
        final opt = entry.value;
        final isUserVote = poll.userVote == opt.id;
        final barColor = colors[i % colors.length];

        return Padding(
          padding: const EdgeInsets.only(
              bottom: AppDimensions.paddingSmall + 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (isUserVote)
                    const Padding(
                      padding: EdgeInsets.only(
                          right: AppDimensions.paddingXS),
                      child: Icon(Icons.check_circle,
                          size: AppDimensions.iconSmall,
                          color: AppColors.success),
                    ),
                  Expanded(
                    child: Text(
                      opt.label,
                      style: TextStyle(
                        fontSize: AppDimensions.fontBody,
                        fontWeight: isUserVote
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Text(
                    '${opt.percentage.toStringAsFixed(1)}%',
                    style: const TextStyle(
                      fontSize: AppDimensions.fontBody,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingXS),
              ClipRRect(
                borderRadius: BorderRadius.circular(
                    AppDimensions.radiusPill),
                child: SizedBox(
                  height: 8,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.divider,
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusPill),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor:
                            (opt.percentage / 100).clamp(0.0, 1.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: barColor,
                            borderRadius: BorderRadius.circular(
                                AppDimensions.radiusPill),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppDimensions.paddingXS),
                child: Text(
                  l10n.voteResults(opt.votes,
                      opt.percentage.toStringAsFixed(1)),
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSmall,
                    color: AppColors.textTertiary,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime date;
  final ValueChanged<DateTime> onPicked;

  const _DatePickerField({
    required this.label,
    required this.date,
    required this.onPicked,
  });

  @override
  Widget build(BuildContext context) {
    final text =
        '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
        );
        if (picked != null) onPicked(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingSmall + 4,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style:
                    const TextStyle(fontSize: AppDimensions.fontBody)),
            const Icon(Icons.calendar_today,
                size: AppDimensions.iconSmall,
                color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
