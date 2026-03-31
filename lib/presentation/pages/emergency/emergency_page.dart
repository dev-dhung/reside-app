import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/domain/entities/emergency_contact.dart';
import 'package:prototype/data/datasources/mock/mock_emergency.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/atoms/status_badge.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    final emergencies = mockEmergencyContacts
        .where((c) =>
            c.category == 'Bomberos' ||
            c.category == 'Ambulancia' ||
            c.category == 'Policia')
        .toList();

    final building = mockEmergencyContacts
        .where((c) =>
            c.category == 'Seguridad' || c.category == 'Administracion')
        .toList();

    final technical = mockEmergencyContacts
        .where((c) => c.category == 'Tecnico')
        .toList();

    return BaseScaffold(
      title: l10n.emergencyTitle,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Warning banner
            _buildBanner(l10n),
            const SizedBox(height: AppDimensions.paddingXL),

            // Emergencies section
            _buildSectionHeader(l10n.emergencySection, AppColors.error),
            const SizedBox(height: AppDimensions.paddingSmall + 4),
            ...emergencies.map((c) => _buildEmergencyCard(
                context, c, l10n,
                accentColor: AppColors.error, isBig: true)),

            const SizedBox(height: AppDimensions.paddingXL),

            // Building section
            _buildSectionHeader(
                l10n.buildingSection, AppColors.primary),
            const SizedBox(height: AppDimensions.paddingSmall + 4),
            ...building.map((c) => _buildEmergencyCard(
                context, c, l10n,
                accentColor: AppColors.primary)),

            const SizedBox(height: AppDimensions.paddingXL),

            // Technical services section
            _buildSectionHeader(
                l10n.technicalSection, AppColors.warning),
            const SizedBox(height: AppDimensions.paddingSmall + 4),
            ...technical.map((c) => _buildEmergencyCard(
                context, c, l10n,
                accentColor: AppColors.warning)),

            const SizedBox(height: AppDimensions.paddingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(L10n l10n) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.warning_amber_rounded,
                size: AppDimensions.iconLarge, color: AppColors.error),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: Text(
              l10n.emergencyBanner,
              style: TextStyle(
                fontSize: AppDimensions.fontBody,
                fontWeight: FontWeight.w600,
                color: AppColors.error.withValues(alpha: 0.9),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall + 4),
        Text(
          title,
          style: TextStyle(
            fontSize: AppDimensions.fontLarge,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildEmergencyCard(
    BuildContext context,
    EmergencyContact contact,
    L10n l10n, {
    required Color accentColor,
    bool isBig = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(AppDimensions.radiusXL),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.callingTo(contact.name)),
                backgroundColor: AppColors.primary,
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: AppCard(
            child: Row(
              children: [
                // Icon in colored circle
                Container(
                  width: isBig ? 52 : 44,
                  height: isBig ? 52 : 44,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _resolveIcon(contact.iconName),
                    size: isBig
                        ? AppDimensions.iconMedium
                        : AppDimensions.iconSmall,
                    color: accentColor,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: TextStyle(
                          fontSize: isBig
                              ? AppDimensions.fontMedium
                              : AppDimensions.fontBody,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXS),
                      Text(
                        contact.phone,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontBody,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Availability badge or schedule
                contact.isAvailable24h
                    ? StatusBadge(
                        label: l10n.available24h,
                        color: AppColors.success)
                    : Flexible(
                        child: Text(
                          contact.schedule ?? '',
                          style: const TextStyle(
                            fontSize: AppDimensions.fontSmall,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.call,
                      size: AppDimensions.iconSmall,
                      color: accentColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _resolveIcon(String iconName) {
    switch (iconName) {
      case 'security':
        return Icons.security;
      case 'local_fire_department':
        return Icons.local_fire_department;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'local_police':
        return Icons.local_police;
      case 'business':
        return Icons.business;
      case 'plumbing':
        return Icons.plumbing;
      case 'electrical_services':
        return Icons.electrical_services;
      case 'cleaning_services':
        return Icons.cleaning_services;
      default:
        return Icons.phone;
    }
  }
}
