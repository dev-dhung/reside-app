import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';

class ActivityPage extends StatelessWidget {
  final bool isAdmin;
  const ActivityPage({super.key, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    final activities = isAdmin ? _adminActivities : _residentActivities;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          WaveHeader(
            height: 130,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Text(
                      'Actividad Reciente',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              itemCount: activities.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final a = activities[index];
                return Container(
                  padding: const EdgeInsets.all(16),
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
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: a.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(a.icon, color: a.color, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              a.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              a.subtitle,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        a.time,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Activity {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color color;
  const _Activity({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.color,
  });
}

const _residentActivities = [
  _Activity(
    icon: Icons.check_circle_outline,
    title: 'Pago aprobado',
    subtitle: '\$150.00 - Condominio Marzo',
    time: 'Hace 2 días',
    color: AppColors.success,
  ),
  _Activity(
    icon: Icons.event_available,
    title: 'Reserva confirmada',
    subtitle: 'Parrillera Central - 05/04',
    time: 'Hace 3 días',
    color: AppColors.warning,
  ),
  _Activity(
    icon: Icons.campaign_outlined,
    title: 'Nuevo anuncio',
    subtitle: 'Corte de agua programado',
    time: 'Hace 5 días',
    color: AppColors.info,
  ),
  _Activity(
    icon: Icons.build_outlined,
    title: 'Solicitud recibida',
    subtitle: 'Fuga en cocina - En progreso',
    time: 'Hace 6 días',
    color: AppColors.accent,
  ),
  _Activity(
    icon: Icons.how_to_vote_outlined,
    title: 'Votación disponible',
    subtitle: 'Instalación de cámaras',
    time: 'Hace 1 sem',
    color: AppColors.primary,
  ),
  _Activity(
    icon: Icons.payment_outlined,
    title: 'Pago registrado',
    subtitle: '\$150.00 - Condominio Febrero',
    time: 'Hace 1 mes',
    color: AppColors.success,
  ),
];

const _adminActivities = [
  _Activity(
    icon: Icons.payment_outlined,
    title: 'Pago recibido',
    subtitle: 'Apto 4-B - \$150.00',
    time: 'Hace 1 día',
    color: AppColors.success,
  ),
  _Activity(
    icon: Icons.build_outlined,
    title: 'Nueva solicitud',
    subtitle: 'Apto 2-A - Fuga de agua',
    time: 'Hace 2 días',
    color: AppColors.warning,
  ),
  _Activity(
    icon: Icons.how_to_vote_outlined,
    title: 'Votación cerrada',
    subtitle: 'Pintura de fachada - 52 votos',
    time: 'Hace 4 días',
    color: AppColors.info,
  ),
  _Activity(
    icon: Icons.person_add_outlined,
    title: 'Visitante aprobado',
    subtitle: 'Apto 6-C - Juan Pérez',
    time: 'Hace 5 días',
    color: AppColors.accent,
  ),
  _Activity(
    icon: Icons.warning_amber_outlined,
    title: 'Solicitud urgente',
    subtitle: 'Ascensor Torre B fuera de servicio',
    time: 'Hace 1 sem',
    color: AppColors.error,
  ),
];
