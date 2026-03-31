import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/repositories/maintenance_repository_impl.dart';
import 'package:prototype/domain/entities/maintenance_request.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_button.dart';
import 'package:prototype/presentation/atoms/app_text_field.dart';
import 'package:prototype/presentation/atoms/status_badge.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';

class MaintenancePage extends StatefulWidget {
  final bool isAdmin;

  const MaintenancePage({super.key, this.isAdmin = false});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage>
    with SingleTickerProviderStateMixin {
  final _repository = MockMaintenanceRepository();
  List<MaintenanceRequest> _requests = [];
  RequestStatus? _statusFilter;
  bool _isLoading = true;
  late AnimationController _fabController;

  L10n get l10n => L10n.of(context);

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _loadRequests();
  }

  @override
  void dispose() {
    _fabController.dispose();
    super.dispose();
  }

  Future<void> _loadRequests() async {
    setState(() => _isLoading = true);
    final data = widget.isAdmin
        ? await _repository.getAllRequests()
        : await _repository.getRequestsByResident('usr-001');
    setState(() {
      _requests = data;
      _isLoading = false;
    });
    _fabController.forward();
  }

  List<MaintenanceRequest> get _filteredRequests {
    if (_statusFilter == null) return _requests;
    return _requests.where((r) => r.status == _statusFilter).toList();
  }

  // ---------------------------------------------------------------------------
  // Label / icon / color helpers (preserve ALL L10n)
  // ---------------------------------------------------------------------------

  String _categoryLabel(RequestCategory category) {
    switch (category) {
      case RequestCategory.plumbing:
        return l10n.categoryPlumbing;
      case RequestCategory.electrical:
        return l10n.categoryElectrical;
      case RequestCategory.elevator:
        return l10n.categoryElevator;
      case RequestCategory.commonAreas:
        return l10n.categoryCommonAreas;
      case RequestCategory.structural:
        return l10n.categoryStructural;
      case RequestCategory.security:
        return l10n.categorySecurity;
      case RequestCategory.other:
        return l10n.categoryOther;
    }
  }

  static IconData _categoryIcon(RequestCategory category) {
    switch (category) {
      case RequestCategory.plumbing:
        return Icons.plumbing;
      case RequestCategory.electrical:
        return Icons.electrical_services;
      case RequestCategory.elevator:
        return Icons.elevator;
      case RequestCategory.commonAreas:
        return Icons.meeting_room;
      case RequestCategory.structural:
        return Icons.foundation;
      case RequestCategory.security:
        return Icons.security;
      case RequestCategory.other:
        return Icons.build;
    }
  }

  static Color _categoryColor(RequestCategory category) {
    switch (category) {
      case RequestCategory.plumbing:
        return AppColors.info;
      case RequestCategory.electrical:
        return AppColors.warning;
      case RequestCategory.elevator:
        return AppColors.primary;
      case RequestCategory.commonAreas:
        return AppColors.accent;
      case RequestCategory.structural:
        return AppColors.primaryDark;
      case RequestCategory.security:
        return AppColors.error;
      case RequestCategory.other:
        return AppColors.textSecondary;
    }
  }

  static Color _priorityColor(RequestPriority priority) {
    switch (priority) {
      case RequestPriority.low:
        return AppColors.success;
      case RequestPriority.medium:
        return Colors.amber.shade700;
      case RequestPriority.high:
        return Colors.orange;
      case RequestPriority.urgent:
        return AppColors.error;
    }
  }

  String _priorityLabel(RequestPriority priority) {
    switch (priority) {
      case RequestPriority.low:
        return l10n.priorityLow;
      case RequestPriority.medium:
        return l10n.priorityMedium;
      case RequestPriority.high:
        return l10n.priorityHigh;
      case RequestPriority.urgent:
        return l10n.priorityUrgent;
    }
  }

  static Color _statusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.open:
        return AppColors.info;
      case RequestStatus.inProgress:
        return Colors.amber.shade700;
      case RequestStatus.resolved:
        return AppColors.success;
      case RequestStatus.closed:
        return AppColors.textSecondary;
    }
  }

  String _statusLabel(RequestStatus status) {
    switch (status) {
      case RequestStatus.open:
        return l10n.statusOpen;
      case RequestStatus.inProgress:
        return l10n.statusInProgress;
      case RequestStatus.resolved:
        return l10n.statusResolved;
      case RequestStatus.closed:
        return l10n.statusClosed;
    }
  }

  static String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildWaveHeader(),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 3,
                    ),
                  )
                : RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: _loadRequests,
                    child: CustomScrollView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      slivers: [
                        if (widget.isAdmin)
                          SliverToBoxAdapter(child: _buildAdminStats()),
                        SliverToBoxAdapter(child: _buildFilterChips()),
                        if (_filteredRequests.isEmpty)
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: _buildEmptyState(),
                          )
                        else
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(
                              AppDimensions.paddingMedium,
                              AppDimensions.paddingSmall,
                              AppDimensions.paddingMedium,
                              100, // space for FAB
                            ),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  return _buildTicketCard(
                                    _filteredRequests[index],
                                    index,
                                  );
                                },
                                childCount: _filteredRequests.length,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: widget.isAdmin
          ? null
          : ScaleTransition(
              scale: CurvedAnimation(
                parent: _fabController,
                curve: Curves.elasticOut,
              ),
              child: FloatingActionButton.extended(
                heroTag: 'maintenance_fab',
                backgroundColor: AppColors.primary,
                elevation: 6,
                highlightElevation: 10,
                onPressed: () => _showCreateForm(context),
                icon: const Icon(Icons.add_rounded,
                    color: AppColors.textOnPrimary, size: 22),
                label: Text(
                  l10n.newRequestTitle,
                  style: const TextStyle(
                    color: AppColors.textOnPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: AppDimensions.fontBody,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusPill),
                ),
              ),
            ),
    );
  }

  // ---------------------------------------------------------------------------
  // WAVE HEADER
  // ---------------------------------------------------------------------------

  Widget _buildWaveHeader() {
    return WaveHeader(
      height: 140,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
        ),
        child: Row(
          children: [
            // Back button
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingMedium),
            // Icon
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: const Icon(
                Icons.build_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall + 4),
            // Title
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isAdmin
                        ? l10n.maintenanceAdminTitle
                        : l10n.maintenanceResidentTitle,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontLarge,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.isAdmin
                        ? '${_requests.length} solicitudes'
                        : 'Centro de soporte',
                    style: TextStyle(
                      fontSize: AppDimensions.fontSmall,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // ADMIN STATS BAR
  // ---------------------------------------------------------------------------

  Widget _buildAdminStats() {
    final open =
        _requests.where((r) => r.status == RequestStatus.open).length;
    final inProgress =
        _requests.where((r) => r.status == RequestStatus.inProgress).length;
    final urgent =
        _requests.where((r) => r.priority == RequestPriority.urgent).length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: _statPill(
              color: AppColors.info,
              count: open,
              label: l10n.adminStatsOpen(open),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingSmall),
          Expanded(
            child: _statPill(
              color: Colors.amber.shade700,
              count: inProgress,
              label: l10n.adminStatsInProgress(inProgress),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingSmall),
          Expanded(
            child: _statPill(
              color: AppColors.error,
              count: urgent,
              label: l10n.adminStatsUrgent(urgent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statPill({
    required Color color,
    required int count,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingSmall + 4,
        horizontal: AppDimensions.paddingSmall,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.4),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  count.toString(),
                  style: TextStyle(
                    fontSize: AppDimensions.fontLarge,
                    fontWeight: FontWeight.w800,
                    color: color,
                    height: 1.1,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontXS,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // FILTER CHIPS
  // ---------------------------------------------------------------------------

  Widget _buildFilterChips() {
    final filters = <RequestStatus?>[
      null,
      RequestStatus.open,
      RequestStatus.inProgress,
      RequestStatus.resolved,
    ];
    final labels = [
      l10n.filterAll,
      l10n.filterOpen,
      l10n.filterInProgress,
      l10n.filterResolved,
    ];
    final chipColors = <Color>[
      AppColors.primary,
      AppColors.info,
      Colors.amber.shade700,
      AppColors.success,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingMedium,
      ),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
          ),
          separatorBuilder: (_, _) =>
              const SizedBox(width: AppDimensions.paddingSmall),
          itemCount: filters.length,
          itemBuilder: (context, i) {
            final isSelected = _statusFilter == filters[i];
            final chipColor = chipColors[i];
            return GestureDetector(
              onTap: () => setState(() => _statusFilter = filters[i]),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMedium + 4,
                  vertical: AppDimensions.paddingSmall,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? chipColor
                      : AppColors.cardBackground,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusPill),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected
                          ? chipColor.withValues(alpha: 0.3)
                          : AppColors.shadow,
                      blurRadius: isSelected ? 12 : 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: isSelected
                      ? null
                      : Border.all(
                          color: AppColors.divider,
                          width: 1,
                        ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                    ],
                    Text(
                      labels[i],
                      style: TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // EMPTY STATE
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingXXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primarySurface,
                    AppColors.primarySurface.withValues(alpha: 0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.build_circle_outlined,
                size: AppDimensions.iconXL,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            Text(
              widget.isAdmin
                  ? l10n.noRequestsFilter
                  : l10n.noRequestsRegistered,
              style: const TextStyle(
                fontSize: AppDimensions.fontMedium,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Text(
              'No hay solicitudes',
              style: TextStyle(
                fontSize: AppDimensions.fontBody,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // TICKET CARD
  // ---------------------------------------------------------------------------

  Widget _buildTicketCard(MaintenanceRequest request, int index) {
    final catColor = _categoryColor(request.category);
    final prioColor = _priorityColor(request.priority);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 400 + (index * 60)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Opacity(
          opacity: value.clamp(0, 1),
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall + 4),
        child: GestureDetector(
          onTap: widget.isAdmin
              ? () => _showAdminDetail(context, request)
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusXL),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: prioColor.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusXL),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    // Left accent bar (priority color)
                    Container(
                      width: 4,
                      decoration: BoxDecoration(
                        color: prioColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppDimensions.radiusXL),
                          bottomLeft:
                              Radius.circular(AppDimensions.radiusXL),
                        ),
                      ),
                    ),
                    // Card content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(
                            AppDimensions.paddingMedium),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top row: category icon + title + date
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category icon in rounded square
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color:
                                        catColor.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(
                                        AppDimensions.radiusMedium),
                                  ),
                                  child: Icon(
                                    _categoryIcon(request.category),
                                    color: catColor,
                                    size: AppDimensions.iconSmall,
                                  ),
                                ),
                                const SizedBox(
                                    width: AppDimensions.paddingSmall + 4),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        request.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              AppDimensions.fontBody,
                                          color: AppColors.textPrimary,
                                          height: 1.2,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (widget.isAdmin)
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 2),
                                          child: Text(
                                            'Apto. ${request.apartment}',
                                            style: TextStyle(
                                              fontSize:
                                                  AppDimensions.fontSmall,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary
                                                  .withValues(alpha: 0.8),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDate(request.createdAt),
                                  style: const TextStyle(
                                    fontSize: AppDimensions.fontXS,
                                    color: AppColors.textTertiary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            // Description preview
                            Padding(
                              padding: const EdgeInsets.only(
                                top: AppDimensions.paddingSmall,
                                left: 54, // align with text after icon
                              ),
                              child: Text(
                                request.description,
                                style: const TextStyle(
                                  fontSize: AppDimensions.fontSmall,
                                  color: AppColors.textTertiary,
                                  height: 1.4,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            // Bottom row: badges + assigned person
                            Padding(
                              padding: const EdgeInsets.only(
                                top: AppDimensions.paddingSmall + 2,
                                left: 54,
                              ),
                              child: Row(
                                children: [
                                  StatusBadge(
                                    label:
                                        _priorityLabel(request.priority),
                                    color: prioColor,
                                  ),
                                  const SizedBox(
                                      width: AppDimensions.paddingSmall),
                                  StatusBadge(
                                    label:
                                        _statusLabel(request.status),
                                    color:
                                        _statusColor(request.status),
                                  ),
                                  if (request.assignedTo != null) ...[
                                    const Spacer(),
                                    Icon(
                                      Icons.person_outline_rounded,
                                      size: 14,
                                      color: AppColors.textTertiary,
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        request.assignedTo!,
                                        style: const TextStyle(
                                          fontSize:
                                              AppDimensions.fontXS,
                                          color:
                                              AppColors.textSecondary,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow:
                                            TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Admin tap indicator
                    if (widget.isAdmin)
                      Padding(
                        padding: const EdgeInsets.only(
                            right: AppDimensions.paddingSmall + 4),
                        child: Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.textTertiary
                              .withValues(alpha: 0.5),
                          size: 22,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CREATE REQUEST FORM (Bottom Sheet)
  // ---------------------------------------------------------------------------

  void _showCreateForm(BuildContext context) {
    RequestCategory selectedCategory = RequestCategory.plumbing;
    RequestPriority selectedPriority = RequestPriority.medium;
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Container(
              constraints: BoxConstraints(
                maxHeight:
                    MediaQuery.of(ctx).size.height * 0.92,
              ),
              decoration: const BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppDimensions.radiusXXL),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(ctx).viewInsets.bottom,
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.paddingLarge,
                      0,
                      AppDimensions.paddingLarge,
                      AppDimensions.paddingLarge,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Grab handle
                        Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            margin: const EdgeInsets.only(
                              top: AppDimensions.paddingSmall + 4,
                              bottom: AppDimensions.paddingLarge,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.divider,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),

                        // Title
                        Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.primary
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusMedium),
                              ),
                              child: const Icon(
                                Icons.add_task_rounded,
                                color: AppColors.primary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(
                                width: AppDimensions.paddingSmall + 4),
                            Text(
                              l10n.newRequestTitle,
                              style: const TextStyle(
                                fontSize: AppDimensions.fontXL,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.paddingXL),

                        // Category label
                        _sectionLabel(l10n.categoryLabel),
                        const SizedBox(height: AppDimensions.paddingSmall),

                        // Category icon grid (2x4)
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          mainAxisSpacing: AppDimensions.paddingSmall,
                          crossAxisSpacing: AppDimensions.paddingSmall,
                          childAspectRatio: 0.85,
                          children:
                              RequestCategory.values.map((cat) {
                            final isSelected = selectedCategory == cat;
                            final catColor = _categoryColor(cat);
                            return GestureDetector(
                              onTap: () => setModalState(
                                  () => selectedCategory = cat),
                              child: AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 200),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? catColor.withValues(alpha: 0.12)
                                      : AppColors.inputBackground,
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.radiusMedium),
                                  border: Border.all(
                                    color: isSelected
                                        ? catColor
                                        : Colors.transparent,
                                    width: 2,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: catColor.withValues(
                                                alpha: 0.2),
                                            blurRadius: 8,
                                            offset:
                                                const Offset(0, 2),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? catColor.withValues(
                                                alpha: 0.15)
                                            : AppColors.divider
                                                .withValues(
                                                    alpha: 0.5),
                                        borderRadius:
                                            BorderRadius.circular(
                                                AppDimensions
                                                    .radiusSmall),
                                      ),
                                      child: Icon(
                                        _categoryIcon(cat),
                                        size: AppDimensions.iconSmall,
                                        color: isSelected
                                            ? catColor
                                            : AppColors.textTertiary,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _categoryLabel(cat),
                                      style: TextStyle(
                                        fontSize:
                                            AppDimensions.fontXS,
                                        fontWeight: isSelected
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isSelected
                                            ? catColor
                                            : AppColors.textTertiary,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow:
                                          TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                            height: AppDimensions.paddingLarge),

                        // Priority label
                        _sectionLabel(l10n.priorityLabel),
                        const SizedBox(height: AppDimensions.paddingSmall),

                        // Priority colored pill chips
                        Row(
                          children: RequestPriority.values.map((p) {
                            final isSelected = selectedPriority == p;
                            final pColor = _priorityColor(p);
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 3),
                                child: GestureDetector(
                                  onTap: () => setModalState(
                                      () => selectedPriority = p),
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                        milliseconds: 200),
                                    padding:
                                        const EdgeInsets.symmetric(
                                            vertical: AppDimensions
                                                    .paddingSmall +
                                                2),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? pColor
                                          : pColor.withValues(
                                              alpha: 0.08),
                                      borderRadius:
                                          BorderRadius.circular(
                                              AppDimensions
                                                  .radiusPill),
                                      boxShadow: isSelected
                                          ? [
                                              BoxShadow(
                                                color:
                                                    pColor.withValues(
                                                        alpha: 0.35),
                                                blurRadius: 8,
                                                offset:
                                                    const Offset(
                                                        0, 2),
                                              ),
                                            ]
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _priorityLabel(p),
                                        style: TextStyle(
                                          fontSize: AppDimensions
                                              .fontSmall,
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          color: isSelected
                                              ? Colors.white
                                              : pColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                            height: AppDimensions.paddingLarge),

                        // Title field
                        AppTextField(
                          label: l10n.titleLabel,
                          controller: titleCtrl,
                          hintText: l10n.titleHint,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return l10n.titleRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                            height: AppDimensions.paddingMedium),

                        // Description field
                        AppTextField(
                          label: l10n.descriptionLabel,
                          controller: descCtrl,
                          hintText: l10n.descriptionHint,
                          maxLines: 3,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return l10n.descriptionRequired;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                            height: AppDimensions.paddingMedium),

                        // Photo placeholder with groovy dashed border
                        _buildPhotoPlaceholder(),
                        const SizedBox(height: AppDimensions.paddingXL),

                        // Submit button
                        AppButton(
                          label: l10n.sendRequestButton,
                          icon: Icons.send_rounded,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              _submitRequest(
                                context: ctx,
                                title: titleCtrl.text.trim(),
                                description: descCtrl.text.trim(),
                                category: selectedCategory,
                                priority: selectedPriority,
                              );
                            }
                          },
                        ),
                        const SizedBox(
                            height: AppDimensions.paddingSmall),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: AppDimensions.fontBody,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondary,
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _buildPhotoPlaceholder() {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: AppColors.accent.withValues(alpha: 0.5),
        strokeWidth: 2,
        gap: 6,
        radius: AppDimensions.radiusLarge,
      ),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.04),
          borderRadius:
              BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.accent.withValues(alpha: 0.1),
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusMedium),
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                size: AppDimensions.iconMedium,
                color: AppColors.accent.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Text(
              l10n.attachPhotos,
              style: TextStyle(
                fontSize: AppDimensions.fontSmall,
                fontWeight: FontWeight.w500,
                color: AppColors.accent.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitRequest({
    required BuildContext context,
    required String title,
    required String description,
    required RequestCategory category,
    required RequestPriority priority,
  }) async {
    final newRequest = MaintenanceRequest(
      id: 'mnt-${DateTime.now().millisecondsSinceEpoch}',
      residentId: 'usr-001',
      apartment: '4-B',
      title: title,
      description: description,
      category: category,
      priority: priority,
      status: RequestStatus.open,
      createdAt: DateTime.now(),
    );
    await _repository.createRequest(newRequest);
    if (context.mounted) Navigator.of(context).pop();
    _loadRequests();

    if (mounted) {
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded,
                  color: Colors.white, size: 20),
              const SizedBox(width: 10),
              Text(l10n.requestSentSuccess),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          margin: const EdgeInsets.all(AppDimensions.paddingMedium),
        ),
      );
    }
  }

  // ---------------------------------------------------------------------------
  // ADMIN DETAIL DIALOG
  // ---------------------------------------------------------------------------

  void _showAdminDetail(BuildContext context, MaintenanceRequest request) {
    RequestStatus selectedStatus = request.status;
    final assignCtrl =
        TextEditingController(text: request.assignedTo ?? '');
    final notesCtrl =
        TextEditingController(text: request.adminNotes ?? '');
    final catColor = _categoryColor(request.category);

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return Dialog(
              backgroundColor: AppColors.cardBackground,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusXXL),
              ),
              insetPadding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingXL,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with gradient
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(
                          AppDimensions.paddingLarge),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            catColor.withValues(alpha: 0.12),
                            catColor.withValues(alpha: 0.04),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(
                              AppDimensions.radiusXXL),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // Close button row
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: catColor.withValues(
                                      alpha: 0.15),
                                  borderRadius:
                                      BorderRadius.circular(
                                          AppDimensions
                                              .radiusMedium),
                                ),
                                child: Icon(
                                  _categoryIcon(
                                      request.category),
                                  color: catColor,
                                  size:
                                      AppDimensions.iconMedium,
                                ),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Navigator.of(ctx).pop(),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: AppColors.textTertiary
                                        .withValues(
                                            alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                    color: AppColors
                                        .textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingMedium),
                          Text(
                            request.title,
                            style: const TextStyle(
                              fontSize:
                                  AppDimensions.fontLarge,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingSmall),
                          // Badges row
                          Wrap(
                            spacing:
                                AppDimensions.paddingSmall,
                            runSpacing:
                                AppDimensions.paddingXS,
                            children: [
                              StatusBadge(
                                label:
                                    'Apto. ${request.apartment}',
                                color: AppColors.primary,
                              ),
                              StatusBadge(
                                label: _priorityLabel(
                                    request.priority),
                                color: _priorityColor(
                                    request.priority),
                              ),
                              StatusBadge(
                                label: _categoryLabel(
                                    request.category),
                                color: catColor,
                              ),
                            ],
                          ),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingXS),
                          Text(
                            _formatDate(request.createdAt),
                            style: const TextStyle(
                              fontSize:
                                  AppDimensions.fontSmall,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Content
                    Padding(
                      padding: const EdgeInsets.all(
                          AppDimensions.paddingLarge),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Description
                          Text(
                            request.description,
                            style: const TextStyle(
                              fontSize:
                                  AppDimensions.fontBody,
                              color: AppColors.textPrimary,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingLarge),
                          Container(
                            height: 1,
                            color: AppColors.divider,
                          ),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingLarge),

                          // Status dropdown
                          _sectionLabel(l10n.statusLabel),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingSmall),
                          Container(
                            decoration: BoxDecoration(
                              color:
                                  AppColors.inputBackground,
                              borderRadius:
                                  BorderRadius.circular(
                                      AppDimensions
                                          .radiusLarge),
                            ),
                            child:
                                DropdownButtonFormField<
                                    RequestStatus>(
                              initialValue: selectedStatus,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          AppDimensions
                                              .radiusLarge),
                                  borderSide:
                                      BorderSide.none,
                                ),
                                contentPadding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: AppDimensions
                                      .paddingMedium,
                                  vertical: AppDimensions
                                      .paddingSmall,
                                ),
                              ),
                              dropdownColor: AppColors
                                  .cardBackground,
                              borderRadius:
                                  BorderRadius.circular(
                                      AppDimensions
                                          .radiusLarge),
                              items: RequestStatus.values
                                  .map((s) {
                                final sColor =
                                    _statusColor(s);
                                return DropdownMenuItem(
                                  value: s,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration:
                                            BoxDecoration(
                                          color: sColor,
                                          shape: BoxShape
                                              .circle,
                                        ),
                                      ),
                                      const SizedBox(
                                          width: 10),
                                      Text(
                                        _statusLabel(s),
                                        style:
                                            const TextStyle(
                                          fontSize:
                                              AppDimensions
                                                  .fontBody,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setDialogState(() =>
                                      selectedStatus =
                                          val);
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingMedium),

                          // Assign field
                          AppTextField(
                            label: l10n.assignToLabel,
                            controller: assignCtrl,
                            hintText: l10n.assignToHint,
                            prefixIcon: const Icon(
                              Icons
                                  .person_outline_rounded,
                              size: 20,
                              color:
                                  AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingMedium),

                          // Notes field
                          AppTextField(
                            label: l10n.adminNotesLabel,
                            controller: notesCtrl,
                            hintText: l10n.adminNotesHint,
                            maxLines: 3,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(
                                  bottom: 40),
                              child: Icon(
                                Icons
                                    .note_alt_outlined,
                                size: 20,
                                color: AppColors
                                    .textTertiary,
                              ),
                            ),
                          ),
                          const SizedBox(
                              height:
                                  AppDimensions.paddingXL),

                          // Action buttons
                          Row(
                            children: [
                              Expanded(
                                child: AppButton(
                                  label:
                                      l10n.cancelButton,
                                  isOutlined: true,
                                  onPressed: () =>
                                      Navigator.of(ctx)
                                          .pop(),
                                ),
                              ),
                              const SizedBox(
                                  width: AppDimensions
                                      .paddingSmall +
                                      4),
                              Expanded(
                                child: AppButton(
                                  label:
                                      l10n.saveButton,
                                  icon: Icons
                                      .check_rounded,
                                  onPressed: () async {
                                    await _repository
                                        .updateStatus(
                                            request.id,
                                            selectedStatus);
                                    if (assignCtrl.text
                                        .trim()
                                        .isNotEmpty) {
                                      await _repository
                                          .assignRequest(
                                              request
                                                  .id,
                                              assignCtrl
                                                  .text
                                                  .trim());
                                    }
                                    if (ctx.mounted) {
                                      Navigator.of(ctx)
                                          .pop();
                                    }
                                    _loadRequests();

                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                              this.context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Row(
                                            children: [
                                              const Icon(
                                                  Icons
                                                      .check_circle_rounded,
                                                  color: Colors
                                                      .white,
                                                  size:
                                                      20),
                                              const SizedBox(
                                                  width:
                                                      10),
                                              Text(l10n
                                                  .requestUpdatedSuccess),
                                            ],
                                          ),
                                          backgroundColor:
                                              AppColors
                                                  .success,
                                          behavior:
                                              SnackBarBehavior
                                                  .floating,
                                          shape:
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(
                                                    AppDimensions
                                                        .radiusMedium),
                                          ),
                                          margin: const EdgeInsets
                                              .all(
                                              AppDimensions
                                                  .paddingMedium),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// -----------------------------------------------------------------------------
// Dashed border painter for the photo placeholder
// -----------------------------------------------------------------------------

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final len = draw ? gap * 1.5 : gap;
        final end = (distance + len).clamp(0, metric.length).toDouble();
        if (draw) {
          final extracted = metric.extractPath(distance, end);
          canvas.drawPath(extracted, paint);
        }
        distance = end;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
