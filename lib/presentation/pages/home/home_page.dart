import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';
import 'package:prototype/presentation/organisms/dashboard_header.dart';
import 'package:prototype/presentation/pages/home/activity_page.dart';
import 'package:prototype/presentation/pages/home/notifications_sheet.dart';

class HomePage extends StatelessWidget {
  final bool isAdmin;
  final String userName;

  const HomePage({
    super.key,
    this.isAdmin = false,
    this.userName = '',
  });

  String _getGreeting(L10n l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 18) return l10n.greetingAfternoon;
    return l10n.greetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final displayName = userName.isNotEmpty ? userName : 'María García';

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          // -- Wave header --
          WaveHeader(
            height: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingXL,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _getGreeting(l10n),
                            style: TextStyle(
                              fontSize: AppDimensions.fontMedium,
                              fontWeight: FontWeight.w300,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  displayName,
                                  style: const TextStyle(
                                    fontSize: AppDimensions.fontXL,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isAdmin) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusPill,
                                    ),
                                  ),
                                  child: Text(
                                    l10n.adminBadge,
                                    style: const TextStyle(
                                      fontSize: AppDimensions.fontXS,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    GestureDetector(
                      onTap: () => showNotificationsSheet(context),
                      child: Stack(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications_outlined,
                              color: Colors.white,
                              size: AppDimensions.iconMedium,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, AppRoutes.profile),
                      child: Container(
                        width: AppDimensions.avatarMedium,
                        height: AppDimensions.avatarMedium,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          color: Colors.white,
                          size: AppDimensions.iconMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // -- Content --
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.paddingMedium),

                  // Balance card - full width
                  SizedBox(
                    width: double.infinity,
                    child: DashboardHeader(isAdmin: isAdmin),
                  ),
                  const SizedBox(height: AppDimensions.paddingLarge),

                  // Quick Actions
                  _buildQuickActionsSection(context, l10n),
                  const SizedBox(height: AppDimensions.paddingLarge),

                  // Recent Activity (fills remaining space)
                  Expanded(
                    child: _buildRecentActivitySection(context, l10n),
                  ),
                  const SizedBox(height: AppDimensions.paddingSmall),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Quick Actions as horizontal cards ----------------------------------------

  Widget _buildQuickActionsSection(BuildContext context, L10n l10n) {
    final actions = isAdmin
        ? _adminActions(context, l10n)
        : _residentActions(context, l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickActions,
          style: const TextStyle(
            fontSize: AppDimensions.fontLarge,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingMedium),
        // Two rows of action cards
        for (int i = 0; i < actions.length; i += 2) ...[
          if (i > 0) const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: actions[i]),
              const SizedBox(width: 10),
              Expanded(
                child: i + 1 < actions.length
                    ? actions[i + 1]
                    : const SizedBox(),
              ),
            ],
          ),
        ],
      ],
    );
  }

  List<Widget> _residentActions(BuildContext context, L10n l10n) {
    return [
      _ActionCard(
        icon: Icons.payment_rounded,
        label: l10n.menuPay,
        subtitle: 'Reportar pagos',
        color: AppColors.primary,
        onTap: () => Navigator.pushNamed(context, AppRoutes.payment),
      ),
      _ActionCard(
        icon: Icons.smart_toy_rounded,
        label: l10n.chatbot,
        subtitle: 'Asistente virtual',
        color: AppColors.accent,
        onTap: () => Navigator.pushNamed(context, AppRoutes.chatbot),
      ),
      _ActionCard(
        icon: Icons.event_rounded,
        label: l10n.reserve,
        subtitle: 'Áreas comunes',
        color: AppColors.info,
        onTap: () => Navigator.pushNamed(context, AppRoutes.reservations),
      ),
      _ActionCard(
        icon: Icons.build_rounded,
        label: l10n.report,
        subtitle: 'Mantenimiento',
        color: AppColors.warning,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.maintenance,
          arguments: {'isAdmin': false},
        ),
      ),
    ];
  }

  List<Widget> _adminActions(BuildContext context, L10n l10n) {
    return [
      _ActionCard(
        icon: Icons.money_off_rounded,
        label: l10n.adminQuickMorosos,
        subtitle: 'Pendientes',
        color: AppColors.error,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.paymentHistory,
          arguments: {'isAdmin': true},
        ),
      ),
      _ActionCard(
        icon: Icons.assignment_rounded,
        label: l10n.adminQuickSolicitudes,
        subtitle: 'Gestionar',
        color: AppColors.warning,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.maintenance,
          arguments: {'isAdmin': true},
        ),
      ),
      _ActionCard(
        icon: Icons.campaign_rounded,
        label: l10n.adminQuickAnuncios,
        subtitle: 'Publicar',
        color: AppColors.info,
        onTap: () => Navigator.pushNamed(context, AppRoutes.announcements),
      ),
      _ActionCard(
        icon: Icons.analytics_rounded,
        label: l10n.adminQuickReportes,
        subtitle: 'Métricas',
        color: AppColors.primary,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.reports,
          arguments: {'soyAdmin': true},
        ),
      ),
    ];
  }

  // --- Recent Activity -----------------------------------------------------------

  Widget _buildRecentActivitySection(BuildContext context, L10n l10n) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.recentActivity,
              style: const TextStyle(
                fontSize: AppDimensions.fontLarge,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivityPage(isAdmin: isAdmin),
                ),
              ),
              child: Text(
                l10n.viewAll,
                style: const TextStyle(
                  fontSize: AppDimensions.fontBody,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.paddingMedium),
        isAdmin
            ? _buildAdminActivityFeed(l10n)
            : _buildResidentActivityFeed(l10n),
      ],
    );
  }

  Widget _buildResidentActivityFeed(L10n l10n) {
    return Column(
      children: [
        _ActivityCard(
          dotColor: AppColors.success,
          title: l10n.activityPaymentApproved,
          subtitle: l10n.activityPaymentAmount,
          trailing: l10n.daysAgo(2),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        _ActivityCard(
          dotColor: AppColors.warning,
          title: l10n.activityReservationSent,
          subtitle: l10n.activityReservationArea,
          trailing: l10n.daysAgo(3),
        ),
      ],
    );
  }

  Widget _buildAdminActivityFeed(L10n l10n) {
    return Column(
      children: [
        _ActivityCard(
          dotColor: AppColors.success,
          title: l10n.adminActivityPaymentReceived,
          subtitle: l10n.adminActivityPaymentApt,
          trailing: l10n.daysAgo(1),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        _ActivityCard(
          dotColor: AppColors.warning,
          title: l10n.adminActivityNewRequest,
          subtitle: l10n.adminActivityRequestText,
          trailing: l10n.daysAgo(2),
        ),
      ],
    );
  }
}

// --- Action Card (replaces circle quick actions) ---------------------------------

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 16,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Activity Feed Card ----------------------------------------------------------

class _ActivityCard extends StatelessWidget {
  final Color dotColor;
  final String title;
  final String subtitle;
  final String trailing;

  const _ActivityCard({
    required this.dotColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontBody,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontSmall,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            trailing,
            style: const TextStyle(
              fontSize: AppDimensions.fontXS,
              fontWeight: FontWeight.w400,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
