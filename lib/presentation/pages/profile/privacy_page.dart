import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // -- Wave Header --
          WaveHeader(
            height: 120,
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
                  const Icon(Icons.privacy_tip_outlined,
                      color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  const Flexible(
                    child: Text(
                      'Política de Privacidad',
                      style: TextStyle(
                        fontSize: AppDimensions.fontXL,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // -- Content --
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: Container(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusLarge),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'En Reside, la privacidad de nuestros usuarios es una prioridad. '
                      'Esta política describe cómo recopilamos, usamos y protegemos su '
                      'información personal.',
                      style: TextStyle(
                        fontSize: AppDimensions.fontBody,
                        height: 1.6,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.paddingLarge),

                    _buildSection(
                      'Datos que Recopilamos',
                      'Recopilamos información que usted nos proporciona directamente al '
                          'registrarse, como su nombre completo, correo electrónico, número de '
                          'apartamento y número de teléfono. También recopilamos datos de uso '
                          'como reportes de pago, reservaciones realizadas y solicitudes de '
                          'mantenimiento para mejorar nuestro servicio.',
                    ),
                    _buildSection(
                      'Cómo Usamos su Información',
                      'Utilizamos su información para gestionar su cuenta, procesar reportes '
                          'de pago, facilitar la comunicación con la administración de su residencia '
                          'y enviar notificaciones relevantes. No vendemos ni compartimos su '
                          'información personal con terceros para fines de marketing.',
                    ),
                    _buildSection(
                      'Compartir Información',
                      'Su información solo es compartida con la administración de su residencia '
                          'para los fines operativos de la comunidad. Podemos compartir datos '
                          'agregados y anonimizados con fines estadísticos. En caso de requerimiento '
                          'legal, podemos divulgar información según lo exija la ley aplicable.',
                    ),
                    _buildSection(
                      'Seguridad de Datos',
                      'Implementamos medidas de seguridad técnicas y organizativas para proteger '
                          'su información personal contra acceso no autorizado, alteración, '
                          'divulgación o destrucción. Utilizamos cifrado en tránsito y en reposo '
                          'para garantizar la integridad de sus datos.',
                    ),
                    _buildSection(
                      'Sus Derechos',
                      'Usted tiene derecho a acceder, rectificar y eliminar sus datos personales. '
                          'Puede solicitar una copia de su información, actualizar datos incorrectos '
                          'o solicitar la eliminación de su cuenta. Para ejercer estos derechos, '
                          'contacte a nuestro equipo de soporte.',
                    ),
                    _buildSection(
                      'Contacto',
                      'Si tiene preguntas sobre esta Política de Privacidad o sobre el '
                          'tratamiento de sus datos personales, puede contactarnos a través de '
                          'la sección de soporte en la aplicación o escribirnos a '
                          'privacidad@reside.app.',
                    ),

                    const SizedBox(height: AppDimensions.paddingMedium),
                    const Divider(color: AppColors.divider),
                    const SizedBox(height: AppDimensions.paddingMedium),
                    Center(
                      child: Text(
                        'Última actualización: Marzo 2026',
                        style: TextStyle(
                          fontSize: AppDimensions.fontSmall,
                          color: AppColors.textTertiary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: AppDimensions.fontMedium,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryDark,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: const TextStyle(
              fontSize: AppDimensions.fontBody,
              height: 1.6,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
