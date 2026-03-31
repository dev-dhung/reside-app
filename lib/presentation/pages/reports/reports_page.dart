import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/atoms/status_badge.dart';
import 'package:prototype/presentation/molecules/bar_chart_row.dart';
import 'package:prototype/presentation/molecules/info_tile.dart';
import 'package:prototype/presentation/molecules/stat_card.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class ReportsPage extends StatelessWidget {
  final bool isAdmin;

  const ReportsPage({
    super.key,
    this.isAdmin = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return BaseScaffold(
      title: isAdmin ? l10n.reportsAdminTitle : l10n.reportsResidentTitle,
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        children: [
          // Section 1: Title
          _buildSectionHeader(
            isAdmin
                ? l10n.reportsAdminHeading
                : l10n.reportsResidentHeading,
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Section 2: Stat Cards
          ..._buildStatCards(),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Section 3: Expense Breakdown (admin only)
          if (isAdmin) ...[
            _buildSectionHeader(l10n.expenseBreakdownTitle),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildExpenseBreakdownCard(),
            const SizedBox(height: AppDimensions.paddingLarge),
          ],

          // Section 4: Monthly Collection (admin only)
          if (isAdmin) ...[
            _buildSectionHeader(l10n.monthlyCollectionTitle),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildMonthlyPaymentsCard(l10n),
            const SizedBox(height: AppDimensions.paddingLarge),
          ],

          // Section 5: Chatbot Topics
          _buildSectionHeader(l10n.chatbotTopicsTitle),
          const SizedBox(height: AppDimensions.paddingSmall),
          _buildChatbotTopicsCard(),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Section 6: Recent Chat Logs (admin only)
          if (isAdmin) ...[
            _buildSectionHeader(l10n.chatLogsTitle),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildChatLogsCard(l10n),
            const SizedBox(height: AppDimensions.paddingLarge),
          ],

          // Section 7: Insight
          _buildInsightTile(l10n),
          const SizedBox(height: AppDimensions.paddingLarge),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: AppDimensions.fontLarge,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildStatCards() {
    final metrics = isAdmin ? mockAdminMetrics : mockResidentMetrics;
    return metrics.map((m) {
      final color = _accentColorFor(m.title);
      final icon = _trendIconFor(m.trend);
      return Padding(
        padding:
            const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
        child: StatCard(
          title: m.title,
          value: m.value,
          subtitle: m.subtitle,
          accentColor: color,
          trendIcon: icon,
        ),
      );
    }).toList();
  }

  Color _accentColorFor(String title) {
    switch (title) {
      case 'Morosidad':
        return AppColors.error;
      case 'Fondo de Reserva':
        return const Color(0xFFFFA000);
      case 'Resolución Chatbot':
        return AppColors.success;
      case 'Consumo de Agua':
        return AppColors.info;
      case 'Puntualidad de Pago':
        return AppColors.success;
      default:
        return AppColors.primary;
    }
  }

  IconData _trendIconFor(String trend) {
    switch (trend) {
      case 'up':
        return Icons.trending_up;
      case 'down':
        return Icons.trending_down;
      case 'stable':
        return Icons.trending_flat;
      default:
        return Icons.trending_up;
    }
  }

  // Expense Breakdown - horizontal bars with percentage labels
  static const _expenseColors = <Color>[
    AppColors.primaryDark,
    AppColors.primary,
    AppColors.success,
    Color(0xFFFFA000),
    AppColors.info,
  ];

  Widget _buildExpenseBreakdownCard() {
    return AppCard(
      child: Column(
        children: List.generate(mockExpenseBreakdown.length, (i) {
          final e = mockExpenseBreakdown[i];
          final color = i < _expenseColors.length
              ? _expenseColors[i]
              : AppColors.primary;
          return BarChartRow(
            label: '${e.category}  \$${e.amount.toStringAsFixed(0)}',
            percent: e.percentage / 100,
            color: color,
          );
        }),
      ),
    );
  }

  // Monthly chart - clean bar rows
  Widget _buildMonthlyPaymentsCard(L10n l10n) {
    double maxTotal = 0;
    for (final p in mockMonthlyPayments) {
      final total = p.collected + p.pending;
      if (total > maxTotal) maxTotal = total;
    }

    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              _legendDot(AppColors.success, l10n.collectedLabel),
              const SizedBox(width: AppDimensions.paddingMedium),
              _legendDot(AppColors.error, l10n.pendingLegendLabel),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          ...mockMonthlyPayments.map((p) {
            final collectedFraction =
                maxTotal > 0 ? p.collected / maxTotal : 0.0;
            final pendingFraction =
                maxTotal > 0 ? p.pending / maxTotal : 0.0;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingXS + 1),
              child: Row(
                children: [
                  SizedBox(
                    width: 36,
                    child: Text(
                      p.month,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingSmall),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final totalWidth = constraints.maxWidth;
                        final collectedWidth =
                            totalWidth * collectedFraction;
                        final pendingWidth =
                            totalWidth * pendingFraction;
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusPill),
                          child: Row(
                            children: [
                              Container(
                                height: 10,
                                width: collectedWidth,
                                decoration: const BoxDecoration(
                                  color: AppColors.success,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(
                                        AppDimensions.radiusPill),
                                  ),
                                ),
                              ),
                              Container(
                                height: 10,
                                width: pendingWidth,
                                decoration: const BoxDecoration(
                                  color: AppColors.error,
                                  borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(
                                        AppDimensions.radiusPill),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingSmall),
                  SizedBox(
                    width: 56,
                    child: Text(
                      '\$${(p.collected + p.pending).toStringAsFixed(0)}',
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppDimensions.fontSmall,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // Chatbot Topics
  Widget _buildChatbotTopicsCard() {
    const topicColors = <String, Color>{
      'Pagos': AppColors.primary,
      'Servicios': AppColors.info,
      'Averías': Color(0xFFFFA000),
    };

    return AppCard(
      child: Column(
        children: mockChatbotTopics.map((t) {
          final color = topicColors[t.topic] ?? AppColors.primary;
          return BarChartRow(
            label: t.topic,
            percent: t.percentage / 100,
            color: color,
          );
        }).toList(),
      ),
    );
  }

  // Chat Logs - minimal list with avatar circle + text
  Widget _buildChatLogsCard(L10n l10n) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSmall,
      ),
      child: Column(
        children: List.generate(mockChatLogs.length, (i) {
          final log = mockChatLogs[i];
          final isResolved = log.resolution == 'Resuelta';
          final badgeLabel =
              isResolved ? l10n.resolvedByAI : l10n.escalatedToBoard;
          final badgeColor =
              isResolved ? AppColors.success : AppColors.warning;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium,
                  vertical: AppDimensions.paddingSmall,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.primarySurface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.person,
                          color: AppColors.primary,
                          size: AppDimensions.iconSmall),
                    ),
                    const SizedBox(
                        width: AppDimensions.paddingSmall + 4),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${log.apartment} - ${log.topic}',
                            style: const TextStyle(
                              fontSize: AppDimensions.fontBody,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDate(log.date),
                            style: const TextStyle(
                              fontSize: AppDimensions.fontSmall,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    StatusBadge(
                      label: badgeLabel,
                      color: badgeColor,
                    ),
                  ],
                ),
              ),
              if (i < mockChatLogs.length - 1)
                Divider(
                  height: 1,
                  indent: AppDimensions.paddingMedium + 52,
                  color: AppColors.divider,
                ),
            ],
          );
        }),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/${date.year} $hour:$minute';
  }

  // Insight
  Widget _buildInsightTile(L10n l10n) {
    if (isAdmin) {
      return InfoTile(
        icon: Icons.lightbulb_outline,
        text: l10n.adminInsight,
        iconColor: AppColors.accent,
      );
    }
    return InfoTile(
      icon: Icons.verified_user,
      text: l10n.residentInsight,
      iconColor: AppColors.success,
    );
  }
}
