import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/presentation/atoms/wave_header.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

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
                  const Icon(Icons.description_outlined,
                      color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  const Text(
                    'Términos de Servicio',
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
                    _buildSection(
                      '1. Aceptación de Términos',
                      'Al acceder y utilizar la aplicación Reside, usted acepta quedar '
                          'vinculado por estos Términos de Servicio. Si no está de acuerdo con '
                          'alguna parte de estos términos, no podrá acceder al servicio. El uso '
                          'continuado de la plataforma constituye la aceptación de cualquier '
                          'modificación posterior a estos términos.',
                    ),
                    _buildSection(
                      '2. Uso del Servicio',
                      'Reside proporciona una plataforma digital para la gestión de '
                          'comunidades residenciales. El servicio incluye, entre otras funciones, '
                          'el reporte de pagos, la reservación de áreas comunes, el registro de '
                          'visitantes y la comunicación con la administración. Usted se compromete '
                          'a utilizar el servicio de manera responsable y conforme a la ley.',
                    ),
                    _buildSection(
                      '3. Cuenta de Usuario',
                      'Para utilizar Reside, debe crear una cuenta proporcionando información '
                          'veraz y actualizada. Usted es responsable de mantener la confidencialidad '
                          'de su contraseña y de todas las actividades realizadas bajo su cuenta. '
                          'Debe notificar de inmediato cualquier uso no autorizado de su cuenta.',
                    ),
                    _buildSection(
                      '4. Pagos y Facturación',
                      'Los reportes de pago realizados a través de la aplicación están sujetos '
                          'a verificación por parte de la administración. Reside actúa únicamente '
                          'como intermediario para facilitar el registro de pagos y no se hace '
                          'responsable por discrepancias entre los montos reportados y los recibidos.',
                    ),
                    _buildSection(
                      '5. Propiedad Intelectual',
                      'Todo el contenido de la aplicación, incluyendo pero no limitado a textos, '
                          'gráficos, logotipos, iconos y software, es propiedad de Reside o sus '
                          'licenciantes y está protegido por las leyes de propiedad intelectual '
                          'aplicables. Queda prohibida la reproducción no autorizada de cualquier '
                          'parte del servicio.',
                    ),
                    _buildSection(
                      '6. Limitación de Responsabilidad',
                      'Reside no será responsable por daños indirectos, incidentales, especiales '
                          'o consecuentes que resulten del uso o la imposibilidad de uso del servicio. '
                          'La responsabilidad total de Reside estará limitada al monto pagado por '
                          'el usuario en los últimos doce meses, si aplica.',
                    ),
                    _buildSection(
                      '7. Modificaciones',
                      'Nos reservamos el derecho de modificar estos Términos de Servicio en '
                          'cualquier momento. Las modificaciones entrarán en vigor al ser publicadas '
                          'en la aplicación. Es su responsabilidad revisar periódicamente los '
                          'términos. El uso continuado del servicio después de los cambios '
                          'constituye su aceptación de los nuevos términos.',
                    ),

                    const SizedBox(height: AppDimensions.paddingXL),
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
