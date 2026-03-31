import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';
import 'package:prototype/domain/entities/common_area.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';

class ReservationsPage extends StatefulWidget {
  const ReservationsPage({super.key});

  @override
  State<ReservationsPage> createState() => _ReservationsPageState();
}

class _ReservationsPageState extends State<ReservationsPage>
    with TickerProviderStateMixin {
  final Map<String, DateTime?> _selectedDates = {};
  final Map<String, AnimationController> _cardControllers = {};
  final Map<String, Animation<double>> _cardAnimations = {};

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < mockAreas.length; i++) {
      final area = mockAreas[i];
      final controller = AnimationController(
        duration: Duration(milliseconds: 400 + (i * 120)),
        vsync: this,
      );
      _cardControllers[area.id] = controller;
      _cardAnimations[area.id] = CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      );
      Future.delayed(Duration(milliseconds: 80 * i), () {
        if (mounted) controller.forward();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _cardControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

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

  static List<Color> _gradientForArea(String iconName, bool isAvailable) {
    if (!isAvailable) {
      return [const Color(0xFFBDBDBD), const Color(0xFF9E9E9E)];
    }
    switch (iconName) {
      case 'outdoor_grill':
        return [const Color(0xFFE8854A), const Color(0xFFD4956B)];
      case 'celebration':
        return [const Color(0xFF7E57C2), const Color(0xFF5C6BC0)];
      case 'pool':
        return [const Color(0xFF42A5F5), const Color(0xFF5B9BD5)];
      case 'sports_tennis':
        return [const Color(0xFF43A047), const Color(0xFF66BB6A)];
      default:
        return AppColors.gradientPrimary;
    }
  }

  static IconData _decorativeIcon(String iconName) {
    switch (iconName) {
      case 'outdoor_grill':
        return Icons.local_fire_department_rounded;
      case 'celebration':
        return Icons.music_note_rounded;
      case 'pool':
        return Icons.water_rounded;
      case 'sports_tennis':
        return Icons.emoji_events_rounded;
      default:
        return Icons.star_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context);
    final areas = mockAreas;
    final availableCount =
        areas.where((a) => a.status == AreaStatus.available).length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Wave header
          WaveHeader(
            height: 140,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium,
                            ),
                          ),
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            color: AppColors.textOnPrimary,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingMedium),
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.calendar_month_rounded,
                          color: AppColors.textOnPrimary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingMedium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.reservationsTitle,
                              style: const TextStyle(
                                fontSize: AppDimensions.fontXL,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textOnPrimary,
                                letterSpacing: -0.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n.reservationsDesc,
                              style: TextStyle(
                                fontSize: AppDimensions.fontSmall,
                                color: Colors.white.withValues(alpha: 0.85),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Body
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.paddingLarge,
                AppDimensions.paddingMedium,
                AppDimensions.paddingLarge,
                AppDimensions.paddingXXL,
              ),
              children: [
                // Summary bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium,
                    vertical: AppDimensions.paddingSmall + 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primarySurface,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusPill),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$availableCount ${l10n.statusAvailable.toLowerCase()} de ${areas.length} total',
                        style: const TextStyle(
                          fontSize: AppDimensions.fontBody,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDark,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingLarge),

                // Area cards
                ...List.generate(areas.length, (index) {
                  final area = areas[index];
                  final animation = _cardAnimations[area.id];
                  if (animation == null) return const SizedBox.shrink();

                  return AnimatedBuilder(
                    animation: animation,
                    area: area,
                    isLast: index == areas.length - 1,
                    child: _buildAreaCard(context, l10n, area),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaCard(BuildContext context, L10n l10n, CommonArea area) {
    final isAvailable = area.status == AreaStatus.available;
    final gradient = _gradientForArea(area.iconName, isAvailable);
    final selectedDate = _selectedDates[area.id];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXXL),
        boxShadow: [
          BoxShadow(
            color: isAvailable
                ? AppColors.shadowMedium
                : AppColors.shadow,
            blurRadius: isAvailable ? 16 : 8,
            offset: const Offset(0, 4),
            spreadRadius: isAvailable ? 1 : 0,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient banner
          Container(
            height: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Decorative circle
                Positioned(
                  right: -12,
                  top: -12,
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.10),
                    ),
                  ),
                ),
                // Main icon
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLarge,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Icon(
                          _iconForArea(area.iconName),
                          size: 26,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        _decorativeIcon(area.iconName),
                        size: 18,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingLarge),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Area name
                Text(
                  area.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isAvailable
                        ? AppColors.textPrimary
                        : AppColors.textTertiary,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 6),

                // Status row
                Row(
                  children: [
                    Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: _statusDotColor(area.status),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color:
                                _statusDotColor(area.status).withValues(alpha: 0.4),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        _statusLabel(l10n, area.status, area.statusDetail),
                        style: TextStyle(
                          fontSize: AppDimensions.fontBody,
                          color: isAvailable
                              ? AppColors.textSecondary
                              : AppColors.textTertiary,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingMedium),

                // Deposit + date row
                if (isAvailable) ...[
                  // Deposit info
                  if (area.depositAmount != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentLight.withValues(alpha: 0.4),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusPill),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_rounded,
                            size: 14,
                            color: AppColors.accentDark.withValues(alpha: 0.8),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Dep\u00f3sito: \$${area.depositAmount!.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: AppDimensions.fontSmall,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accentDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: AppDimensions.paddingMedium),

                  // Date selector
                  GestureDetector(
                    onTap: () => _pickDate(context, area),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingMedium,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: selectedDate != null
                            ? AppColors.primarySurface
                            : AppColors.inputBackground,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusMedium),
                        border: Border.all(
                          color: selectedDate != null
                              ? AppColors.primary.withValues(alpha: 0.3)
                              : AppColors.divider,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            selectedDate != null
                                ? Icons.event_available_rounded
                                : Icons.calendar_today_rounded,
                            size: 18,
                            color: selectedDate != null
                                ? AppColors.primary
                                : AppColors.textTertiary,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              selectedDate != null
                                  ? _formatDate(selectedDate)
                                  : 'Seleccionar fecha',
                              style: TextStyle(
                                fontSize: AppDimensions.fontBody,
                                fontWeight: selectedDate != null
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: selectedDate != null
                                    ? AppColors.primaryDark
                                    : AppColors.textTertiary,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: selectedDate != null
                                ? AppColors.primary
                                : AppColors.textTertiary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),

                  // Reserve button
                  GestureDetector(
                    onTap: selectedDate != null
                        ? () => _onReserve(context, area, selectedDate)
                        : () => _pickDate(context, area),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      width: double.infinity,
                      height: AppDimensions.buttonHeight,
                      decoration: BoxDecoration(
                        gradient: selectedDate != null
                            ? const LinearGradient(
                                colors: AppColors.gradientPrimary,
                              )
                            : null,
                        color: selectedDate != null ? null : AppColors.primary.withValues(alpha: 0.7),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusLarge),
                        boxShadow: selectedDate != null
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.35),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: AppColors.textOnPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            l10n.reserveButton,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontMedium,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textOnPrimary,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  // Unavailable chip
                  const SizedBox(height: 4),
                  Container(
                    width: double.infinity,
                    height: AppDimensions.buttonHeight,
                    decoration: BoxDecoration(
                      color: AppColors.inputBackground,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusLarge),
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          area.status == AreaStatus.maintenance
                              ? Icons.build_rounded
                              : Icons.lock_outline_rounded,
                          color: AppColors.textTertiary,
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          area.status == AreaStatus.maintenance
                              ? l10n.statusMaintenance
                              : l10n.statusOccupied,
                          style: const TextStyle(
                            fontSize: AppDimensions.fontBody,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    const weekDays = [
      'Lun', 'Mar', 'Mi\u00e9', 'Jue', 'Vie', 'S\u00e1b', 'Dom'
    ];
    final weekDay = weekDays[date.weekday - 1];
    return '$weekDay, $day/$month/$year';
  }

  Future<void> _pickDate(BuildContext context, CommonArea area) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 2)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.textOnPrimary,
              surface: AppColors.cardBackground,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedDates[area.id] = picked;
      });
    }
  }

  void _onReserve(
    BuildContext context,
    CommonArea area,
    DateTime date,
  ) {
    final l10n = L10n.of(context);
    final dateStr =
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'dismiss',
      barrierColor: AppColors.overlay,
      transitionDuration: const Duration(milliseconds: 350),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
        );
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(curvedAnimation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width - 56,
              padding: const EdgeInsets.all(AppDimensions.paddingXXL),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusXXL + 4),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated check icon
                  _AnimatedCheckCircle(animation: animation),
                  const SizedBox(height: AppDimensions.paddingLarge),

                  // Title
                  Text(
                    l10n.reservationSentTitle,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontXL,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingSmall + 4),

                  // Area + date details
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    decoration: BoxDecoration(
                      color: AppColors.primarySurface,
                      borderRadius:
                          BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _iconForArea(area.iconName),
                              size: 18,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              area.name,
                              style: const TextStyle(
                                fontSize: AppDimensions.fontMedium,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.calendar_today_rounded,
                              size: 14,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              dateStr,
                              style: const TextStyle(
                                fontSize: AppDimensions.fontBody,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingMedium),

                  // Message
                  Text(
                    l10n.reservationSentMessage(area.name, dateStr),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontBody,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.paddingXL),

                  // OK button
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      height: AppDimensions.buttonHeight,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: AppColors.gradientPrimary,
                        ),
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusLarge),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        l10n.acceptButton,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontMedium,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textOnPrimary,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------------------------
// Animated check circle for confirmation dialog
// ---------------------------------------------------------------------------

class _AnimatedCheckCircle extends StatelessWidget {
  const _AnimatedCheckCircle({required this.animation});
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder._buildCheck(animation);
  }
}

// ---------------------------------------------------------------------------
// Helper widget for staggered card entrance animation
// ---------------------------------------------------------------------------

class AnimatedBuilder extends StatelessWidget {
  const AnimatedBuilder({
    super.key,
    required this.animation,
    required this.area,
    required this.child,
    required this.isLast,
  });

  final Animation<double> animation;
  final CommonArea area;
  final Widget child;
  final bool isLast;

  static Widget _buildCheck(Animation<double> animation) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: const Interval(0.3, 0.8, curve: Curves.elasticOut),
      ),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: AppColors.gradientPrimary,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Icon(
          Icons.check_rounded,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(animation),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: isLast ? 0 : AppDimensions.paddingMedium,
          ),
          child: child,
        ),
      ),
    );
  }
}
