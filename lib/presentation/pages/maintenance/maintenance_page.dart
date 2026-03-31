import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/data/repositories/maintenance_repository_impl.dart';
import 'package:prototype/domain/entities/maintenance_request.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/atoms/app_button.dart';
import 'package:prototype/presentation/atoms/app_card.dart';
import 'package:prototype/presentation/atoms/app_text_field.dart';
import 'package:prototype/presentation/atoms/status_badge.dart';
import 'package:prototype/presentation/templates/base_scaffold.dart';

class MaintenancePage extends StatefulWidget {
  final bool isAdmin;

  const MaintenancePage({super.key, this.isAdmin = false});

  @override
  State<MaintenancePage> createState() => _MaintenancePageState();
}

class _MaintenancePageState extends State<MaintenancePage> {
  final _repository = MockMaintenanceRepository();
  List<MaintenanceRequest> _requests = [];
  RequestStatus? _statusFilter;
  bool _isLoading = true;

  L10n get l10n => L10n.of(context);

  @override
  void initState() {
    super.initState();
    _loadRequests();
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
  }

  List<MaintenanceRequest> get _filteredRequests {
    if (_statusFilter == null) return _requests;
    return _requests.where((r) => r.status == _statusFilter).toList();
  }

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

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: widget.isAdmin
          ? l10n.maintenanceAdminTitle
          : l10n.maintenanceResidentTitle,
      floatingActionButton: widget.isAdmin
          ? null
          : FloatingActionButton(
              backgroundColor: AppColors.primary,
              onPressed: () => _showCreateForm(context),
              child: const Icon(Icons.add, color: AppColors.textOnPrimary),
            ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (widget.isAdmin) ...[
                  _buildAdminStats(),
                  _buildFilterChips(),
                ],
                Expanded(
                  child: _filteredRequests.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.all(
                              AppDimensions.paddingMedium),
                          itemCount: _filteredRequests.length,
                          itemBuilder: (context, index) =>
                              _buildRequestCard(_filteredRequests[index]),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildAdminStats() {
    final open =
        _requests.where((r) => r.status == RequestStatus.open).length;
    final inProgress = _requests
        .where((r) => r.status == RequestStatus.inProgress)
        .length;
    final urgent = _requests
        .where((r) => r.priority == RequestPriority.urgent)
        .length;

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        AppDimensions.paddingMedium,
        0,
      ),
      child: AppCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingMedium,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _statDot(AppColors.info, l10n.adminStatsOpen(open)),
            _statDot(Colors.amber.shade700,
                l10n.adminStatsInProgress(inProgress)),
            _statDot(AppColors.error, l10n.adminStatsUrgent(urgent)),
          ],
        ),
      ),
    );
  }

  Widget _statDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppDimensions.paddingSmall),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppDimensions.fontSmall,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

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

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingSmall + 4,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(filters.length, (i) {
            final isSelected = _statusFilter == filters[i];
            return Padding(
              padding:
                  const EdgeInsets.only(right: AppDimensions.paddingSmall),
              child: GestureDetector(
                onTap: () => setState(() => _statusFilter = filters[i]),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingMedium,
                    vertical: AppDimensions.paddingSmall,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.cardBackground,
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusPill),
                    boxShadow: isSelected
                        ? null
                        : const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      fontSize: AppDimensions.fontSmall,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color: isSelected
                          ? AppColors.textOnPrimary
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: AppColors.primarySurface,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.build_circle_outlined,
                size: AppDimensions.iconXL, color: AppColors.textTertiary),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          Text(
            widget.isAdmin
                ? l10n.noRequestsFilter
                : l10n.noRequestsRegistered,
            style: const TextStyle(
              fontSize: AppDimensions.fontMedium,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(MaintenanceRequest request) {
    final catColor = _categoryColor(request.category);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      child: AppCard(
        onTap: widget.isAdmin
            ? () => _showAdminDetail(context, request)
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: catColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _categoryIcon(request.category),
                    color: catColor,
                    size: AppDimensions.iconSmall,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall + 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: AppDimensions.fontBody,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.isAdmin
                            ? 'Apto. ${request.apartment} - ${_formatDate(request.createdAt)}'
                            : '${_categoryLabel(request.category)} - ${_formatDate(request.createdAt)}',
                        style: const TextStyle(
                          fontSize: AppDimensions.fontSmall,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSmall + 4),
            Row(
              children: [
                StatusBadge(
                  label: _priorityLabel(request.priority),
                  color: _priorityColor(request.priority),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                StatusBadge(
                  label: _statusLabel(request.status),
                  color: _statusColor(request.status),
                ),
              ],
            ),
            if (request.assignedTo != null) ...[
              const SizedBox(height: AppDimensions.paddingSmall),
              Text(
                l10n.assignedTo(request.assignedTo!),
                style: const TextStyle(
                  fontSize: AppDimensions.fontSmall,
                  color: AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showCreateForm(BuildContext context) {
    RequestCategory selectedCategory = RequestCategory.plumbing;
    RequestPriority selectedPriority = RequestPriority.medium;
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXXL),
        ),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: AppDimensions.paddingLarge,
                right: AppDimensions.paddingLarge,
                top: AppDimensions.paddingLarge,
                bottom: MediaQuery.of(ctx).viewInsets.bottom +
                    AppDimensions.paddingLarge,
              ),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(
                              bottom: AppDimensions.paddingMedium),
                          decoration: BoxDecoration(
                            color: AppColors.divider,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                      Text(
                        l10n.newRequestTitle,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontXL,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXL),

                      // Category icon grid selector
                      Text(
                        l10n.categoryLabel,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontBody,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingSmall),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 4,
                        mainAxisSpacing: AppDimensions.paddingSmall,
                        crossAxisSpacing: AppDimensions.paddingSmall,
                        childAspectRatio: 1.0,
                        children:
                            RequestCategory.values.map((cat) {
                          final isSelected = selectedCategory == cat;
                          final catColor = _categoryColor(cat);
                          return GestureDetector(
                            onTap: () {
                              setModalState(
                                  () => selectedCategory = cat);
                            },
                            child: AnimatedContainer(
                              duration:
                                  const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? catColor.withValues(alpha: 0.15)
                                    : AppColors.inputBackground,
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.radiusMedium),
                                border: isSelected
                                    ? Border.all(
                                        color: catColor, width: 1.5)
                                    : null,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    _categoryIcon(cat),
                                    size: AppDimensions.iconMedium,
                                    color: isSelected
                                        ? catColor
                                        : AppColors.textTertiary,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _categoryLabel(cat),
                                    style: TextStyle(
                                      fontSize: AppDimensions.fontXS,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: isSelected
                                          ? catColor
                                          : AppColors.textTertiary,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),

                      // Priority as colored pill chips
                      Text(
                        l10n.priorityLabel,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontBody,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingSmall),
                      Row(
                        children: RequestPriority.values.map((p) {
                          final isSelected = selectedPriority == p;
                          final pColor = _priorityColor(p);
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3),
                              child: GestureDetector(
                                onTap: () {
                                  setModalState(
                                      () => selectedPriority = p);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(
                                      milliseconds: 200),
                                  padding: const EdgeInsets.symmetric(
                                      vertical:
                                          AppDimensions.paddingSmall),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? pColor
                                        : pColor.withValues(
                                            alpha: 0.08),
                                    borderRadius:
                                        BorderRadius.circular(
                                            AppDimensions.radiusPill),
                                  ),
                                  child: Center(
                                    child: Text(
                                      _priorityLabel(p),
                                      style: TextStyle(
                                        fontSize:
                                            AppDimensions.fontSmall,
                                        fontWeight: isSelected
                                            ? FontWeight.w600
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
                      const SizedBox(height: AppDimensions.paddingMedium),

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
                      const SizedBox(height: AppDimensions.paddingMedium),

                      AppTextField(
                        label: l10n.descriptionLabel,
                        controller: descCtrl,
                        hintText: l10n.descriptionHint,
                        maxLines: 4,
                        validator: (val) {
                          if (val == null || val.trim().isEmpty) {
                            return l10n.descriptionRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: AppDimensions.paddingMedium),

                      Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.inputBackground,
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium),
                          border: Border.all(color: AppColors.divider),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt,
                                size: AppDimensions.iconLarge,
                                color: AppColors.textTertiary),
                            const SizedBox(
                                height: AppDimensions.paddingXS),
                            Text(
                              l10n.attachPhotos,
                              style: const TextStyle(
                                fontSize: AppDimensions.fontSmall,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXL),

                      AppButton(
                        label: l10n.sendRequestButton,
                        icon: Icons.send,
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
                      const SizedBox(height: AppDimensions.paddingSmall),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
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
          content: Text(l10n.requestSentSuccess),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  void _showAdminDetail(BuildContext context, MaintenanceRequest request) {
    RequestStatus selectedStatus = request.status;
    final assignCtrl =
        TextEditingController(text: request.assignedTo ?? '');
    final notesCtrl =
        TextEditingController(text: request.adminNotes ?? '');

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusXL),
              ),
              title: Text(
                request.title,
                style: const TextStyle(
                  fontSize: AppDimensions.fontLarge,
                  fontWeight: FontWeight.w700,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        StatusBadge(
                          label: 'Apto. ${request.apartment}',
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: AppDimensions.paddingSmall),
                        StatusBadge(
                          label: _priorityLabel(request.priority),
                          color: _priorityColor(request.priority),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.paddingSmall),
                    Text(
                      '${_categoryLabel(request.category)} - ${_formatDate(request.createdAt)}',
                      style: const TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    Text(
                      request.description,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontBody,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Divider(height: AppDimensions.paddingXL),
                    DropdownButtonFormField<RequestStatus>(
                      initialValue: selectedStatus,
                      decoration: InputDecoration(
                        labelText: l10n.statusLabel,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              AppDimensions.radiusMedium),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingMedium,
                          vertical: AppDimensions.paddingSmall + 4,
                        ),
                      ),
                      items: RequestStatus.values.map((s) {
                        return DropdownMenuItem(
                          value: s,
                          child: Text(_statusLabel(s)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setDialogState(() => selectedStatus = val);
                        }
                      },
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    AppTextField(
                      label: l10n.assignToLabel,
                      controller: assignCtrl,
                      hintText: l10n.assignToHint,
                    ),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    AppTextField(
                      label: l10n.adminNotesLabel,
                      controller: notesCtrl,
                      hintText: l10n.adminNotesHint,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(l10n.cancelButton),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.textOnPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          AppDimensions.radiusMedium),
                    ),
                  ),
                  onPressed: () async {
                    await _repository.updateStatus(
                        request.id, selectedStatus);
                    if (assignCtrl.text.trim().isNotEmpty) {
                      await _repository.assignRequest(
                          request.id, assignCtrl.text.trim());
                    }
                    if (ctx.mounted) Navigator.of(ctx).pop();
                    _loadRequests();

                    if (mounted) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.requestUpdatedSuccess),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  },
                  child: Text(l10n.saveButton),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
