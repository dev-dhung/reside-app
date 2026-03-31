import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/l10n/app_localizations.dart';

class ServicesHubPage extends StatelessWidget {
  final bool isAdmin;

  const ServicesHubPage({super.key, required this.isAdmin});

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
                l10n.servicesHubTitle,
                style: const TextStyle(
                  fontSize: AppDimensions.fontTitle,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingXL),
              _HubCard(
                icon: Icons.build_outlined,
                title: l10n.menuMaintenance,
                subtitle: l10n.maintenanceDesc,
                onTap: () => Navigator.pushNamed(
                  context,
                  AppRoutes.maintenance,
                  arguments: {'isAdmin': isAdmin},
                ),
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              _HubCard(
                icon: Icons.event_available_outlined,
                title: l10n.menuReservations,
                subtitle: l10n.reservationsDesc,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.reservations),
              ),
              const SizedBox(height: AppDimensions.paddingMedium),
              _HubCard(
                icon: Icons.emergency_outlined,
                title: l10n.menuEmergency,
                subtitle: l10n.emergencyDesc,
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.emergency),
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
