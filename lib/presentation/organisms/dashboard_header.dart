import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/l10n/app_localizations.dart';

class DashboardHeader extends StatelessWidget {
  final bool isAdmin;
  final String balance;
  final String adminTotal;

  const DashboardHeader({
    super.key,
    required this.isAdmin,
    this.balance = '\$45.00',
    this.adminTotal = '\$12,450.80',
  });

  @override
  Widget build(BuildContext context) {
    return isAdmin ? _buildAdminHeader(context) : _buildResidentHeader(context);
  }

  Widget _buildAdminHeader(BuildContext context) {
    final l10n = L10n.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXL),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.gradientAccent,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.adminRecaudation,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textOnAccent.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Text(
            adminTotal,
            style: const TextStyle(
              fontSize: AppDimensions.fontHero,
              fontWeight: FontWeight.w700,
              color: AppColors.textOnAccent,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Text(
            l10n.adminCajaLabel,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textOnAccent.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResidentHeader(BuildContext context) {
    final l10n = L10n.of(context);
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingXL),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.gradientPrimary,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.residentAccountStatus,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textOnPrimary.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Text(
            balance,
            style: const TextStyle(
              fontSize: AppDimensions.fontHero,
              fontWeight: FontWeight.w700,
              color: AppColors.textOnPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingSmall),
          Text(
            l10n.residentPendingLabel,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textOnPrimary.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
