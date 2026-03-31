import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/l10n/app_localizations.dart';

class CommunityHubPage extends StatelessWidget {
  final bool isAdmin;

  const CommunityHubPage({super.key, required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppDimensions.paddingMedium),
              Text(
                l10n.communityHubTitle,
                style: const TextStyle(
                  fontSize: AppDimensions.fontTitle,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXL),
              _HubCard(
                icon: Icons.campaign_outlined,
                title: l10n.menuAnnouncements,
                subtitle: l10n.announcementsDesc,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.announcements),
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              _HubCard(
                icon: Icons.how_to_vote_outlined,
                title: l10n.menuVoting,
                subtitle: l10n.votingDesc,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.voting,
                  arguments: {'isAdmin': isAdmin},
                ),
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              _HubCard(
                icon: Icons.menu_book_outlined,
                title: l10n.menuRules,
                subtitle: l10n.rulesDesc,
                onTap: () => Navigator.pushNamed(context, AppRoutes.rules),
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              _HubCard(
                icon: Icons.badge_outlined,
                title: l10n.menuVisitors,
                subtitle: l10n.visitorsDesc,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.visitors,
                  arguments: {'isAdmin': isAdmin},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HubCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          border: Border.all(color: AppColors.divider, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(width: AppDimensions.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontMedium,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontBody,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textTertiary,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
