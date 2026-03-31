import 'package:flutter/material.dart';
import 'package:prototype/app.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';
import 'package:prototype/presentation/pages/profile/rate_app_dialog.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showLanguageSelector(BuildContext context) {
    final settings = SigraApp.of(context)?.settings;
    if (settings == null) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Idioma / Language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _LanguageOption(
                  flag: '🇪🇸',
                  label: 'Español',
                  isSelected: settings.locale.languageCode == 'es',
                  onTap: () {
                    settings.setLocale(const Locale('es'));
                    Navigator.pop(ctx);
                  },
                ),
                const SizedBox(height: 10),
                _LanguageOption(
                  flag: '🇺🇸',
                  label: 'English',
                  isSelected: settings.locale.languageCode == 'en',
                  onTap: () {
                    settings.setLocale(const Locale('en'));
                    Navigator.pop(ctx);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final size = MediaQuery.of(context).size;
    final settings = SigraApp.of(context)?.settings;
    final isDark = settings?.isDarkMode ?? false;
    final isEs = (settings?.locale.languageCode ?? 'es') == 'es';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: WaveHeader(
              height: size.height * 0.28,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.ownerInfo('4-B'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'vecino_4b@email.com',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // -- Account --
                  _SectionTitle(title: l10n.profileTitle),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    children: [
                      _SettingsItem(
                        icon: Icons.person_outline,
                        label: l10n.fullNameLabel,
                        trailing: 'María García',
                        onTap: () {},
                      ),
                      _SettingsItem(
                        icon: Icons.phone_outlined,
                        label: l10n.phoneInfoLabel,
                        trailing: '+58 412-1234567',
                        onTap: () {},
                      ),
                      _SettingsItem(
                        icon: Icons.home_outlined,
                        label: l10n.apartmentLabel,
                        trailing: 'Torre A - 4B',
                        onTap: () {},
                      ),
                      _SettingsItem(
                        icon: Icons.verified_outlined,
                        label: l10n.solvencyStatusLabel,
                        trailing: l10n.solvencyStatusValue,
                        trailingColor: AppColors.success,
                        showArrow: false,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // -- Preferences --
                  const _SectionTitle(title: 'Preferencias'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    children: [
                      _SettingsItem(
                        icon: Icons.notifications_outlined,
                        label: l10n.pushNotifications,
                        hasToggle: true,
                        toggleValue: settings?.notificationsEnabled ?? true,
                        onTap: () => settings?.toggleNotifications(),
                      ),
                      _SettingsItem(
                        icon: Icons.language_outlined,
                        label: 'Idioma',
                        trailing: isEs ? 'Español' : 'English',
                        onTap: () => _showLanguageSelector(context),
                      ),
                      _SettingsItem(
                        icon: Icons.dark_mode_outlined,
                        label: 'Modo oscuro',
                        hasToggle: true,
                        toggleValue: isDark,
                        onTap: () => settings?.toggleTheme(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // -- Security --
                  const _SectionTitle(title: 'Seguridad'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    children: [
                      _SettingsItem(
                        icon: Icons.lock_outline,
                        label: l10n.changePassword,
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.changePassword),
                      ),
                      _SettingsItem(
                        icon: Icons.fingerprint,
                        label: 'Acceso biométrico',
                        hasToggle: true,
                        toggleValue: settings?.biometricEnabled ?? false,
                        onTap: () => settings?.toggleBiometric(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // -- Support --
                  const _SectionTitle(title: 'Soporte'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    children: [
                      _SettingsItem(
                        icon: Icons.help_outline,
                        label: 'Centro de ayuda',
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.helpCenter),
                      ),
                      _SettingsItem(
                        icon: Icons.chat_bubble_outline,
                        label: 'Contactar soporte',
                        onTap: () => Navigator.pushNamed(
                            context, AppRoutes.contactSupport),
                      ),
                      _SettingsItem(
                        icon: Icons.star_outline,
                        label: 'Calificar la app',
                        onTap: () => showRateAppDialog(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // -- Legal --
                  const _SectionTitle(title: 'Legal'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    children: [
                      _SettingsItem(
                        icon: Icons.description_outlined,
                        label: 'Términos de servicio',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.terms),
                      ),
                      _SettingsItem(
                        icon: Icons.privacy_tip_outlined,
                        label: 'Política de privacidad',
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.privacy),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  Center(
                    child: Text(
                      'Reside v1.0.0',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // -- Logout --
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
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
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 14),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : null,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary, size: 22),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Theme.of(context).hintColor,
        letterSpacing: 1,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < children.length; i++) ...[
            children[i],
            if (i < children.length - 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  height: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  final Color? trailingColor;
  final bool showArrow;
  final bool hasToggle;
  final bool toggleValue;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.label,
    this.trailing,
    this.trailingColor,
    this.showArrow = true,
    this.hasToggle = false,
    this.toggleValue = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primarySurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (hasToggle)
              Switch(
                value: toggleValue,
                onChanged: (_) => onTap(),
                activeTrackColor: AppColors.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )
            else ...[
              if (trailing != null)
                Text(
                  trailing!,
                  style: TextStyle(
                    fontSize: 13,
                    color: trailingColor ?? Theme.of(context).hintColor,
                    fontWeight: trailingColor != null
                        ? FontWeight.w600
                        : FontWeight.w400,
                  ),
                ),
              if (showArrow) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Theme.of(context).hintColor,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
