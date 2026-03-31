import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/core/routes/app_routes.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  static const List<_FaqItem> _faqs = [
    _FaqItem(
      question: '¿Cómo reporto un pago?',
      answer:
          'Dirígete a la sección "Pagos" desde el menú principal. Pulsa "Reportar Pago", '
          'selecciona el método de pago utilizado, adjunta el comprobante y completa los datos '
          'solicitados. La administración verificará tu pago en un plazo de 24 a 48 horas.',
    ),
    _FaqItem(
      question: '¿Cómo reservo un área común?',
      answer:
          'Accede a "Reservaciones" en el menú principal. Selecciona el área que deseas '
          'reservar (salón de fiestas, parrillera, cancha, etc.), elige la fecha y el horario '
          'disponible y confirma tu reservación. Recibirás una notificación con los detalles.',
    ),
    _FaqItem(
      question: '¿Qué hago si olvidé mi contraseña?',
      answer:
          'En la pantalla de inicio de sesión, pulsa "¿Olvidaste tu contraseña?". Ingresa '
          'el correo electrónico asociado a tu cuenta y recibirás un enlace para restablecerla. '
          'Si no recibes el correo, revisa tu carpeta de spam o contacta a soporte.',
    ),
    _FaqItem(
      question: '¿Cómo registro un visitante?',
      answer:
          'Ve a la sección "Visitantes" y pulsa "Registrar Visitante". Ingresa el nombre '
          'completo del visitante, su documento de identidad, la fecha y hora estimada de '
          'visita. La vigilancia recibirá la notificación para autorizar su ingreso.',
    ),
    _FaqItem(
      question: '¿Cómo reporto una avería?',
      answer:
          'Desde "Mantenimiento" en el menú, selecciona "Nuevo Reporte". Describe la avería, '
          'selecciona la ubicación (área común o tu apartamento), adjunta fotos si es posible '
          'y envía el reporte. Podrás seguir el estado de tu solicitud en tiempo real.',
    ),
    _FaqItem(
      question: '¿Cómo contacto a la administración?',
      answer:
          'Puedes contactar a la administración de varias formas: a través del chat integrado '
          'en la app, enviando un mensaje desde la sección "Contactar Soporte", o llamando '
          'directamente al número de la administración que aparece en tu perfil.',
    ),
    _FaqItem(
      question: '¿Puedo cambiar mi apartamento asignado?',
      answer:
          'El cambio de apartamento debe ser solicitado directamente a la administración de '
          'la residencia. Puedes enviar una solicitud formal a través de "Contactar Soporte" '
          'explicando el motivo del cambio. La administración evaluará tu caso y te notificará.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // -- Wave Header --
          WaveHeader(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMedium,
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_rounded,
                        color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.help_outline_rounded,
                      color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Centro de Ayuda',
                    style: TextStyle(
                      fontSize: AppDimensions.fontXL,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -- FAQ List --
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingMedium,
              ),
              children: [
                ..._faqs.map((faq) => _FaqCard(faq: faq)),
                const SizedBox(height: AppDimensions.paddingXXL),

                // -- Bottom CTA --
                Center(
                  child: Column(
                    children: [
                      Icon(Icons.support_agent_rounded,
                          size: 40, color: AppColors.textTertiary),
                      const SizedBox(height: 8),
                      const Text(
                        '¿No encontraste tu respuesta?',
                        style: TextStyle(
                          fontSize: AppDimensions.fontMedium,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Nuestro equipo está listo para ayudarte',
                        style: TextStyle(
                          fontSize: AppDimensions.fontBody,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: AppDimensions.buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.contactSupport);
                          },
                          icon: const Icon(Icons.chat_bubble_outline_rounded),
                          label: const Text('Contactar Soporte'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.radiusLarge),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingXXL),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FaqItem {
  const _FaqItem({required this.question, required this.answer});
  final String question;
  final String answer;
}

class _FaqCard extends StatelessWidget {
  const _FaqCard({required this.faq});
  final _FaqItem faq;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
      child: Material(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        elevation: 0,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
              vertical: AppDimensions.paddingXS,
            ),
            childrenPadding: const EdgeInsets.only(
              left: AppDimensions.paddingMedium,
              right: AppDimensions.paddingMedium,
              bottom: AppDimensions.paddingMedium,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            ),
            iconColor: AppColors.primary,
            collapsedIconColor: AppColors.textTertiary,
            title: Text(
              faq.question,
              style: const TextStyle(
                fontSize: AppDimensions.fontBody,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                decoration: BoxDecoration(
                  color: AppColors.primarySurface,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: Text(
                  faq.answer,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontBody,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
