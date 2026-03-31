import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/organisms/dashboard_header.dart';
import 'package:prototype/presentation/organisms/notification_bell.dart';
import 'package:prototype/presentation/organisms/role_selector.dart';

class HomePage extends StatefulWidget {
  final bool isAdmin;
  final ValueChanged<bool>? onAdminChanged;

  const HomePage({
    super.key,
    this.isAdmin = false,
    this.onAdminChanged,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late bool _isAdmin;

  @override
  void initState() {
    super.initState();
    _isAdmin = widget.isAdmin;
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isAdmin != widget.isAdmin) {
      _isAdmin = widget.isAdmin;
    }
  }

  String _getGreeting(L10n l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.greetingMorning;
    if (hour < 18) return l10n.greetingAfternoon;
    return l10n.greetingEvening;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimensions.paddingXL,
          AppDimensions.paddingXL,
          AppDimensions.paddingXL,
          AppDimensions.paddingHero,
        ),
        children: [
          // 1. Greeting Header
          _buildGreetingHeader(l10n),
          const SizedBox(height: AppDimensions.paddingXL),

          // 2. Role Selector
          RoleSelector(
            isAdmin: _isAdmin,
            onChanged: (val) {
              setState(() => _isAdmin = val);
              widget.onAdminChanged?.call(val);
            },
          ),
          const SizedBox(height: AppDimensions.paddingXL),

          // 3. Dashboard Header (balance card)
          DashboardHeader(isAdmin: _isAdmin),
          const SizedBox(height: AppDimensions.paddingXL),

          // 4. Quick Actions
          _buildQuickActionsSection(l10n),
          const SizedBox(height: AppDimensions.paddingXL),

          // 5. Recent Activity
          _buildRecentActivitySection(l10n),
        ],
      ),
    );
  }

  // ─── Greeting Header ───────────────────────────────────────────────

  Widget _buildGreetingHeader(L10n l10n) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getGreeting(l10n),
                style: const TextStyle(
                  fontSize: AppDimensions.fontXL,
                  fontWeight: FontWeight.w300,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'María García',
                      style: const TextStyle(
                        fontSize: AppDimensions.fontTitle,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (_isAdmin) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusPill,
                        ),
                      ),
                      child: Text(
                        l10n.adminBadge,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontXS,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentDark,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Text(
                l10n.appSubtitle,
                style: const TextStyle(
                  fontSize: AppDimensions.fontBody,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        NotificationBell(
          count: 1,
          onTap: () {},
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, AppRoutes.profile),
          child: Container(
            width: AppDimensions.avatarMedium,
            height: AppDimensions.avatarMedium,
            decoration: const BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              color: AppColors.primary,
              size: AppDimensions.iconMedium,
            ),
          ),
        ),
      ],
    );
  }

  // ─── Quick Actions ─────────────────────────────────────────────────

  Widget _buildQuickActionsSection(L10n l10n) {
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
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _isAdmin
                ? _buildAdminQuickActions(l10n)
                : _buildResidentQuickActions(l10n),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildResidentQuickActions(L10n l10n) {
    return [
      _QuickActionItem(
        icon: Icons.payment_rounded,
        label: l10n.menuPay,
        onTap: () => Navigator.pushNamed(context, AppRoutes.payment),
      ),
      const SizedBox(width: AppDimensions.paddingLarge),
      _QuickActionItem(
        icon: Icons.smart_toy_rounded,
        label: l10n.chatbot,
        onTap: () => Navigator.pushNamed(context, AppRoutes.chatbot),
      ),
      const SizedBox(width: AppDimensions.paddingLarge),
      _QuickActionItem(
        icon: Icons.event_rounded,
        label: l10n.reserve,
        onTap: () => Navigator.pushNamed(context, AppRoutes.reservations),
      ),
      const SizedBox(width: AppDimensions.paddingLarge),
      _QuickActionItem(
        icon: Icons.build_rounded,
        label: l10n.report,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.maintenance,
          arguments: {'isAdmin': false},
        ),
      ),
    ];
  }

  List<Widget> _buildAdminQuickActions(L10n l10n) {
    return [
      _QuickActionItem(
        icon: Icons.money_off_rounded,
        label: l10n.adminQuickMorosos,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.paymentHistory,
          arguments: {'isAdmin': true},
        ),
      ),
      const SizedBox(width: AppDimensions.paddingLarge),
      _QuickActionItem(
        icon: Icons.assignment_rounded,
        label: l10n.adminQuickSolicitudes,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.maintenance,
          arguments: {'isAdmin': true},
        ),
      ),
      const SizedBox(width: AppDimensions.paddingLarge),
      _QuickActionItem(
        icon: Icons.campaign_rounded,
        label: l10n.adminQuickAnuncios,
        onTap: () => Navigator.pushNamed(context, AppRoutes.announcements),
      ),
      const SizedBox(width: AppDimensions.paddingLarge),
      _QuickActionItem(
        icon: Icons.analytics_rounded,
        label: l10n.adminQuickReportes,
        onTap: () => Navigator.pushNamed(
          context,
          AppRoutes.reports,
          arguments: {'soyAdmin': true},
        ),
      ),
    ];
  }

  // ─── Recent Activity ───────────────────────────────────────────────

  Widget _buildRecentActivitySection(L10n l10n) {
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
              onTap: () {},
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
        _isAdmin
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
        const SizedBox(height: AppDimensions.paddingSmall),
        _ActivityCard(
          dotColor: AppColors.info,
          title: l10n.activityNewAnnouncement,
          subtitle: l10n.activityAnnouncementText,
          trailing: l10n.daysAgo(5),
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
        const SizedBox(height: AppDimensions.paddingSmall),
        _ActivityCard(
          dotColor: AppColors.info,
          title: l10n.adminActivityPollClosed,
          subtitle: l10n.adminActivityPollText,
          trailing: l10n.daysAgo(4),
        ),
      ],
    );
  }
}

// ─── Quick Action Circle Widget ────────────────────────────────────────

class _QuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
                size: AppDimensions.iconMedium,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Text(
              label,
              style: const TextStyle(
                fontSize: AppDimensions.fontSmall,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Activity Feed Card Widget ─────────────────────────────────────────

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
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 2),
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
