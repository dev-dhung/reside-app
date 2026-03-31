import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/domain/entities/common_area.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class ReservationsPage extends StatelessWidget {
  const ReservationsPage({super.key});

  static IconData _iconForArea(String iconName) {
    switch (iconName) {
      case 'outdoor_grill':
        return Icons.outdoor_grill;
      case 'celebration':
        return Icons.celebration;
      case 'pool':
        return Icons.pool;
      case 'sports_tennis':
        return Icons.sports_tennis;
      default:
        return Icons.place;
    }
  }

  static String _statusLabel(L10n l10n, AreaStatus status, String? detail) {
    switch (status) {
      case AreaStatus.available:
        return l10n.statusAvailable;
      case AreaStatus.occupied:
        return detail ?? l10n.statusOccupied;
      case AreaStatus.maintenance:
        return detail ?? l10n.statusMaintenance;
    }
  }

  static Color _statusCircleColor(AreaStatus status) {
    switch (status) {
      case AreaStatus.available:
        return AppColors.primarySurface;
      case AreaStatus.occupied:
        return AppColors.accentLight;
      case AreaStatus.maintenance:
        return const Color(0xFFFCE4E4);
    }
  }

  static Color _statusIconColor(AreaStatus status) {
    switch (status) {
      case AreaStatus.available:
        return AppColors.primary;
      case AreaStatus.occupied:
        return AppColors.accentDark;
      case AreaStatus.maintenance:
        return AppColors.error;
    }
  }

  static Color _statusDotColor(AreaStatus status) {
    switch (status) {
      case AreaStatus.available:
        return AppColors.success;
      case AreaStatus.occupied:
        return AppColors.accent;
      case AreaStatus.maintenance:
        return AppColors.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final areas = mockAreas;

    return BaseScaffold(
      title: l10n.reservationsTitle,
      body: ListView.separated(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        itemCount: areas.length,
        separatorBuilder: (_, _) =>
            const SizedBox(height: AppDimensions.paddingSmall + 4),
        itemBuilder: (context, index) {
          final area = areas[index];
          final isAvailable = area.status == AreaStatus.available;

          return AppCard(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingMedium,
            ),
            child: Row(
              children: [
                // Left: status-colored circle with area icon
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: _statusCircleColor(area.status),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _iconForArea(area.iconName),
                    size: AppDimensions.iconMedium,
                    color: _statusIconColor(area.status),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),

                // Center: name + status with dot
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        area.name,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontMedium,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _statusDotColor(area.status),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              _statusLabel(l10n, area.status, area.statusDetail),
                              style: const TextStyle(
                                fontSize: AppDimensions.fontSmall,
                                color: AppColors.textSecondary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),

                // Right: pill button
                GestureDetector(
                  onTap: isAvailable
                      ? () => _onReserve(context, area)
                      : null,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMedium,
                      vertical: AppDimensions.paddingSmall,
                    ),
                    decoration: BoxDecoration(
                      color: isAvailable
                          ? AppColors.primary
                          : AppColors.inputBackground,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusPill),
                    ),
                    child: Text(
                      l10n.reserveButton,
                      style: TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        fontWeight: FontWeight.w600,
                        color: isAvailable
                            ? AppColors.textOnPrimary
                            : AppColors.textTertiary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onReserve(BuildContext context, CommonArea area) async {
    final l10n = L10n.of(context);
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 2)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );

    if (picked != null && context.mounted) {
      final dateStr =
          '${picked.day.toString().padLeft(2, '0')}/'
          '${picked.month.toString().padLeft(2, '0')}/'
          '${picked.year}';
      showDialog(
        context: context,
        barrierColor: AppColors.overlay,
        builder: (ctx) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          ),
          backgroundColor: AppColors.cardBackground,
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingXXL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: AppDimensions.iconHero,
                  height: AppDimensions.iconHero,
                  decoration: const BoxDecoration(
                    color: AppColors.primarySurface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: AppColors.primary,
                    size: AppDimensions.iconLarge,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingLarge),
                Text(
                  l10n.reservationSentTitle,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontLarge,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                Text(
                  l10n.reservationSentMessage(area.name, dateStr),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontBody,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingXL),
                GestureDetector(
                  onTap: () => Navigator.of(ctx).pop(),
                  child: Container(
                    width: double.infinity,
                    height: AppDimensions.buttonHeight,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusLarge),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      l10n.acceptButton,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontMedium,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
