import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/domain/entities/announcement.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/molecules/announcement_card.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class AnnouncementsPage extends StatelessWidget {
  const AnnouncementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final announcements = mockAnnouncements;

    return BaseScaffold(
      title: l10n.announcementsTitle,
      body: announcements.isEmpty
          ? Center(
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
                    child: const Icon(Icons.campaign_outlined,
                        size: AppDimensions.iconXL,
                        color: AppColors.textTertiary),
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),
                  Text(
                    l10n.announcementsTitle,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontMedium,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            )
          : Stack(
              children: [
                // Decorative circle in top-right
                Positioned(
                  top: -30,
                  right: -30,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accent.withValues(alpha: 0.05),
                    ),
                  ),
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  itemCount: announcements.length,
                  itemBuilder: (context, index) {
                    final a = announcements[index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: AppDimensions.paddingSmall + 4),
                      child: AnnouncementCard(
                        title: a.title,
                        content: a.content,
                        date:
                            '${a.date.day.toString().padLeft(2, '0')}/${a.date.month.toString().padLeft(2, '0')}/${a.date.year}',
                        isUrgent: a.priority == AnnouncementPriority.urgent,
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}
