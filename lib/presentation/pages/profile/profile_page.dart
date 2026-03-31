import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/molecules/profile_info_tile.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    return BaseScaffold(
      title: l10n.profileTitle,
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        children: [
          const SizedBox(height: AppDimensions.paddingLarge),

          // Large centered avatar
          Center(
            child: Container(
              width: AppDimensions.avatarHero,
              height: AppDimensions.avatarHero,
              decoration: const BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                size: AppDimensions.iconXL,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Name centered
          Center(
            child: Text(
              l10n.ownerInfo('4-B'),
              style: const TextStyle(
                fontSize: AppDimensions.fontXL,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXS),

          // Subtitle centered
          Center(
            child: Text(
              l10n.appSubtitle,
              style: const TextStyle(
                fontSize: AppDimensions.fontBody,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXL),

          // Info section on white card
          AppCard(
            child: Column(
              children: [
                ProfileInfoTile(
                  icon: Icons.email,
                  label: l10n.emailInfoLabel,
                  value: 'vecino_4b@email.com',
                ),
                const Divider(
                    height: AppDimensions.paddingMedium,
                    color: AppColors.divider),
                ProfileInfoTile(
                  icon: Icons.phone,
                  label: l10n.phoneInfoLabel,
                  value: '+58 412-1234567',
                ),
                const Divider(
                    height: AppDimensions.paddingMedium,
                    color: AppColors.divider),
                ProfileInfoTile(
                  icon: Icons.verified,
                  label: l10n.solvencyStatusLabel,
                  value: l10n.solvencyStatusValue,
                  valueColor: AppColors.success,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          // Settings section on separate white card
          AppCard(
            child: Column(
              children: [
                _buildToggleItem(
                  icon: Icons.notifications_active,
                  label: l10n.pushNotifications,
                  value: true,
                  onChanged: (_) {},
                ),
                const Divider(
                    height: AppDimensions.paddingSmall,
                    color: AppColors.divider),
                _buildArrowItem(
                  icon: Icons.lock,
                  label: l10n.changePassword,
                  onTap: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXL),

          // Logout button - outlined red, subtle
          OutlinedButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (_) => false,
              );
            },
            icon: const Icon(Icons.logout, color: AppColors.error),
            label: Text(
              l10n.logoutButton,
              style: const TextStyle(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.error),
              minimumSize: const Size(
                double.infinity,
                AppDimensions.buttonHeight,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  AppDimensions.radiusXL,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingXL),
        ],
      ),
    );
  }

  Widget _buildToggleItem({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingXS),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusSmall),
            ),
            child: Icon(icon,
                size: AppDimensions.iconSmall, color: AppColors.primary),
          ),
          const SizedBox(width: AppDimensions.paddingSmall + 4),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: AppDimensions.fontMedium,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildArrowItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppDimensions.paddingSmall + 2),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: Icon(icon,
                  size: AppDimensions.iconSmall,
                  color: AppColors.primary),
            ),
            const SizedBox(width: AppDimensions.paddingSmall + 4),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: AppDimensions.fontMedium,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 14, color: AppColors.textTertiary),
          ],
        ),
      ),
    );
  }
}
