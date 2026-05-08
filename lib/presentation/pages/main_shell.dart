import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/pages/community/community_hub_page.dart';
import 'package:prototype/presentation/pages/home/home_page.dart';
import 'package:prototype/presentation/pages/payments/payments_hub_page.dart';
import 'package:prototype/presentation/pages/profile/profile_page.dart';
import 'package:prototype/presentation/pages/services/services_hub_page.dart';

class MainShell extends StatefulWidget {
  final bool isAdmin;
  final String userName;

  const MainShell({
    super.key,
    this.isAdmin = false,
    this.userName = '',
  });

  /// Switches the visible tab from anywhere inside the shell. Use this from
  /// hub pages to send the user back to Home when pressing the back arrow.
  static void goToTab(BuildContext context, int index) {
    final state = context.findAncestorStateOfType<_MainShellState>();
    state?._goToTab(index);
  }

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  void _goToTab(int index) {
    if (!mounted) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);

    final pages = <Widget>[
      HomePage(
        isAdmin: widget.isAdmin,
        userName: widget.userName,
      ),
      PaymentsHubPage(isAdmin: widget.isAdmin),
      CommunityHubPage(isAdmin: widget.isAdmin),
      ServicesHubPage(isAdmin: widget.isAdmin),
      const ProfilePage(),
    ];

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.02),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey(_currentIndex),
          child: pages[_currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.navBackground,
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowMedium,
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: SafeArea(
            child: SizedBox(
              height: AppDimensions.bottomNavHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _NavItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    label: l10n.navHome,
                    isSelected: _currentIndex == 0,
                    onTap: () => setState(() => _currentIndex = 0),
                  ),
                  _NavItem(
                    icon: Icons.account_balance_wallet_outlined,
                    activeIcon: Icons.account_balance_wallet,
                    label: l10n.navPayments,
                    isSelected: _currentIndex == 1,
                    onTap: () => setState(() => _currentIndex = 1),
                  ),
                  _NavItem(
                    icon: Icons.people_outlined,
                    activeIcon: Icons.people,
                    label: l10n.navCommunity,
                    isSelected: _currentIndex == 2,
                    onTap: () => setState(() => _currentIndex = 2),
                  ),
                  _NavItem(
                    icon: Icons.handyman_outlined,
                    activeIcon: Icons.handyman,
                    label: l10n.navServices,
                    isSelected: _currentIndex == 3,
                    onTap: () => setState(() => _currentIndex = 3),
                  ),
                  _NavItem(
                    icon: Icons.person_outlined,
                    activeIcon: Icons.person,
                    label: l10n.navProfile,
                    isSelected: _currentIndex == 4,
                    onTap: () => setState(() => _currentIndex = 4),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? activeIcon : icon,
                color:
                    isSelected ? AppColors.navActive : AppColors.navInactive,
                size: isSelected ? 28 : AppDimensions.bottomNavIconSize,
              ),
            ),
            const SizedBox(height: 2),
            // Dot indicator for active tab
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: isSelected ? 5 : 0,
              height: isSelected ? 5 : 0,
              decoration: BoxDecoration(
                color: AppColors.navActive,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.fontXS,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color:
                    isSelected ? AppColors.navActive : AppColors.navInactive,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
