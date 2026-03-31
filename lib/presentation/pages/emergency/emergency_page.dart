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
            // Warning banner - organic rounded card
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
        gradient: LinearGradient(
          colors: [
            AppColors.error.withValues(alpha: 0.10),
            AppColors.error.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.error.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Subtle decorative circle
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.error.withValues(alpha: 0.06),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.error.withValues(alpha: 0.18),
                      AppColors.error.withValues(alpha: 0.10),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
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
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Text(
          title,
          style: TextStyle(
            fontSize: AppDimensions.fontLarge,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Expanded(
          child: Container(
            height: 1.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.4),
                  color.withValues(alpha: 0.0),
                ],
              ),
              borderRadius: BorderRadius.circular(1),
            ),
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
          splashColor: accentColor.withValues(alpha: 0.08),
          highlightColor: accentColor.withValues(alpha: 0.04),
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
                // Icon in gradient circle
                Container(
                  width: isBig ? 52 : 44,
                  height: isBig ? 52 : 44,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withValues(alpha: 0.15),
                        accentColor.withValues(alpha: 0.06),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
                    gradient: LinearGradient(
                      colors: [
                        accentColor.withValues(alpha: 0.12),
                        accentColor.withValues(alpha: 0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
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
