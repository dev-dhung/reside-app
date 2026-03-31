import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appName.
  ///
  /// In es, this message translates to:
  /// **'Reside'**
  String get appName;

  /// No description provided for @appSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Tu comunidad, conectada'**
  String get appSubtitle;

  /// No description provided for @appTitle.
  ///
  /// In es, this message translates to:
  /// **'Reside'**
  String get appTitle;

  /// No description provided for @emailOrPhoneLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico o teléfono'**
  String get emailOrPhoneLabel;

  /// No description provided for @passwordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get passwordLabel;

  /// No description provided for @rememberMe.
  ///
  /// In es, this message translates to:
  /// **'Recordarme'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In es, this message translates to:
  /// **'¿Olvidaste tu contraseña?'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In es, this message translates to:
  /// **'INGRESAR'**
  String get loginButton;

  /// No description provided for @registerLink.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta? Regístrate aquí'**
  String get registerLink;

  /// No description provided for @developedBy.
  ///
  /// In es, this message translates to:
  /// **'Desarrollado por...'**
  String get developedBy;

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Registro'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Activa tu cuenta'**
  String get registerSubtitle;

  /// No description provided for @registerDescription.
  ///
  /// In es, this message translates to:
  /// **'Complete sus datos para registrarse'**
  String get registerDescription;

  /// No description provided for @invitationCodeLabel.
  ///
  /// In es, this message translates to:
  /// **'Código de invitación'**
  String get invitationCodeLabel;

  /// No description provided for @invitationCodeHint.
  ///
  /// In es, this message translates to:
  /// **'Ej: RES-4B-2026'**
  String get invitationCodeHint;

  /// No description provided for @emailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get emailLabel;

  /// No description provided for @phoneLabel.
  ///
  /// In es, this message translates to:
  /// **'Número de teléfono'**
  String get phoneLabel;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Confirmar contraseña'**
  String get confirmPasswordLabel;

  /// No description provided for @registerButton.
  ///
  /// In es, this message translates to:
  /// **'CREAR CUENTA'**
  String get registerButton;

  /// No description provided for @apartmentLabel.
  ///
  /// In es, this message translates to:
  /// **'Apartamento'**
  String get apartmentLabel;

  /// No description provided for @fullNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre Completo'**
  String get fullNameLabel;

  /// No description provided for @cedulaLabel.
  ///
  /// In es, this message translates to:
  /// **'Número de Cédula'**
  String get cedulaLabel;

  /// No description provided for @towerApartmentLabel.
  ///
  /// In es, this message translates to:
  /// **'Torre / Apartamento'**
  String get towerApartmentLabel;

  /// No description provided for @welcomeMessage.
  ///
  /// In es, this message translates to:
  /// **'Bienvenido'**
  String get welcomeMessage;

  /// No description provided for @homeAdminTitle.
  ///
  /// In es, this message translates to:
  /// **'Reside - Gestión Admin'**
  String get homeAdminTitle;

  /// No description provided for @homeResidentTitle.
  ///
  /// In es, this message translates to:
  /// **'Reside - Mi tablero'**
  String get homeResidentTitle;

  /// No description provided for @adminSectionTitle.
  ///
  /// In es, this message translates to:
  /// **'Panel de Control Administrativo'**
  String get adminSectionTitle;

  /// No description provided for @residentSectionTitle.
  ///
  /// In es, this message translates to:
  /// **'Servicios y Gestión'**
  String get residentSectionTitle;

  /// No description provided for @modeResident.
  ///
  /// In es, this message translates to:
  /// **'Modo Vecino'**
  String get modeResident;

  /// No description provided for @modeAdmin.
  ///
  /// In es, this message translates to:
  /// **'Modo Admin'**
  String get modeAdmin;

  /// No description provided for @menuPay.
  ///
  /// In es, this message translates to:
  /// **'Pagar'**
  String get menuPay;

  /// No description provided for @menuHistory.
  ///
  /// In es, this message translates to:
  /// **'Historial'**
  String get menuHistory;

  /// No description provided for @menuReservations.
  ///
  /// In es, this message translates to:
  /// **'Reservas'**
  String get menuReservations;

  /// No description provided for @menuVisitors.
  ///
  /// In es, this message translates to:
  /// **'Visitantes'**
  String get menuVisitors;

  /// No description provided for @menuMaintenance.
  ///
  /// In es, this message translates to:
  /// **'Solicitudes'**
  String get menuMaintenance;

  /// No description provided for @menuVoting.
  ///
  /// In es, this message translates to:
  /// **'Votaciones'**
  String get menuVoting;

  /// No description provided for @menuAnnouncements.
  ///
  /// In es, this message translates to:
  /// **'Anuncios'**
  String get menuAnnouncements;

  /// No description provided for @menuRules.
  ///
  /// In es, this message translates to:
  /// **'Normativa'**
  String get menuRules;

  /// No description provided for @menuReports.
  ///
  /// In es, this message translates to:
  /// **'Reportes'**
  String get menuReports;

  /// No description provided for @menuEmergency.
  ///
  /// In es, this message translates to:
  /// **'Emergencias'**
  String get menuEmergency;

  /// No description provided for @adminRecaudation.
  ///
  /// In es, this message translates to:
  /// **'Recaudación Total Mensual'**
  String get adminRecaudation;

  /// No description provided for @adminCajaLabel.
  ///
  /// In es, this message translates to:
  /// **'Fondo de la Residencia'**
  String get adminCajaLabel;

  /// No description provided for @residentAccountStatus.
  ///
  /// In es, this message translates to:
  /// **'Estado de Cuenta'**
  String get residentAccountStatus;

  /// No description provided for @residentPendingLabel.
  ///
  /// In es, this message translates to:
  /// **'Pendiente - Enero 2026'**
  String get residentPendingLabel;

  /// No description provided for @paymentTitle.
  ///
  /// In es, this message translates to:
  /// **'Reportar Pago'**
  String get paymentTitle;

  /// No description provided for @transactionDetails.
  ///
  /// In es, this message translates to:
  /// **'Detalles de la Transacción'**
  String get transactionDetails;

  /// No description provided for @paymentMethodLabel.
  ///
  /// In es, this message translates to:
  /// **'Método de Pago'**
  String get paymentMethodLabel;

  /// No description provided for @methodTransfer.
  ///
  /// In es, this message translates to:
  /// **'Transferencia'**
  String get methodTransfer;

  /// No description provided for @methodMobilePay.
  ///
  /// In es, this message translates to:
  /// **'Pago Móvil'**
  String get methodMobilePay;

  /// No description provided for @methodZelle.
  ///
  /// In es, this message translates to:
  /// **'Zelle'**
  String get methodZelle;

  /// No description provided for @methodCash.
  ///
  /// In es, this message translates to:
  /// **'Efectivo'**
  String get methodCash;

  /// No description provided for @referenceNumberLabel.
  ///
  /// In es, this message translates to:
  /// **'Número de Referencia'**
  String get referenceNumberLabel;

  /// No description provided for @amountLabel.
  ///
  /// In es, this message translates to:
  /// **'Monto (\$)'**
  String get amountLabel;

  /// No description provided for @attachReceipt.
  ///
  /// In es, this message translates to:
  /// **'Adjuntar Comprobante'**
  String get attachReceipt;

  /// No description provided for @sendReportButton.
  ///
  /// In es, this message translates to:
  /// **'ENVIAR REPORTE'**
  String get sendReportButton;

  /// No description provided for @paymentSuccessMessage.
  ///
  /// In es, this message translates to:
  /// **'Su reporte de pago ha sido enviado con éxito a la junta de condominio. Será validado en las próximas 24 horas.'**
  String get paymentSuccessMessage;

  /// No description provided for @understoodButton.
  ///
  /// In es, this message translates to:
  /// **'ENTENDIDO'**
  String get understoodButton;

  /// No description provided for @paymentHistoryAdminTitle.
  ///
  /// In es, this message translates to:
  /// **'Registro de Pagos'**
  String get paymentHistoryAdminTitle;

  /// No description provided for @paymentHistoryResidentTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial de Pagos'**
  String get paymentHistoryResidentTitle;

  /// No description provided for @collectedThisMonth.
  ///
  /// In es, this message translates to:
  /// **'Recaudado\neste mes'**
  String get collectedThisMonth;

  /// No description provided for @toCollect.
  ///
  /// In es, this message translates to:
  /// **'Por cobrar'**
  String get toCollect;

  /// No description provided for @defaulters.
  ///
  /// In es, this message translates to:
  /// **'Morosos'**
  String get defaulters;

  /// No description provided for @totalPaid.
  ///
  /// In es, this message translates to:
  /// **'Total pagado'**
  String get totalPaid;

  /// No description provided for @pending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get pending;

  /// No description provided for @searchByApartment.
  ///
  /// In es, this message translates to:
  /// **'Buscar por apartamento'**
  String get searchByApartment;

  /// No description provided for @searchHintApt.
  ///
  /// In es, this message translates to:
  /// **'Ej: 4-B'**
  String get searchHintApt;

  /// No description provided for @filterAll.
  ///
  /// In es, this message translates to:
  /// **'Todos'**
  String get filterAll;

  /// No description provided for @filterApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobados'**
  String get filterApproved;

  /// No description provided for @filterPending.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get filterPending;

  /// No description provided for @filterRejected.
  ///
  /// In es, this message translates to:
  /// **'Rechazados'**
  String get filterRejected;

  /// No description provided for @noPaymentsMatch.
  ///
  /// In es, this message translates to:
  /// **'No hay pagos que coincidan con el filtro'**
  String get noPaymentsMatch;

  /// No description provided for @statusApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobado'**
  String get statusApproved;

  /// No description provided for @statusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get statusPending;

  /// No description provided for @statusRejected.
  ///
  /// In es, this message translates to:
  /// **'Rechazado'**
  String get statusRejected;

  /// No description provided for @aptLabel.
  ///
  /// In es, this message translates to:
  /// **'Apto {apartment}'**
  String aptLabel(String apartment);

  /// No description provided for @refLabel.
  ///
  /// In es, this message translates to:
  /// **'Ref: {reference}'**
  String refLabel(String reference);

  /// No description provided for @defaultPaymentDesc.
  ///
  /// In es, this message translates to:
  /// **'Pago'**
  String get defaultPaymentDesc;

  /// No description provided for @reservationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Reservas'**
  String get reservationsTitle;

  /// No description provided for @statusAvailable.
  ///
  /// In es, this message translates to:
  /// **'Disponible'**
  String get statusAvailable;

  /// No description provided for @statusOccupied.
  ///
  /// In es, this message translates to:
  /// **'Ocupado'**
  String get statusOccupied;

  /// No description provided for @statusMaintenance.
  ///
  /// In es, this message translates to:
  /// **'En mantenimiento'**
  String get statusMaintenance;

  /// No description provided for @reserveButton.
  ///
  /// In es, this message translates to:
  /// **'RESERVAR'**
  String get reserveButton;

  /// No description provided for @reservationSentTitle.
  ///
  /// In es, this message translates to:
  /// **'Reserva Enviada'**
  String get reservationSentTitle;

  /// No description provided for @reservationSentMessage.
  ///
  /// In es, this message translates to:
  /// **'Su solicitud de reserva para \"{areaName}\" el {date} ha sido enviada para aprobación.'**
  String reservationSentMessage(String areaName, String date);

  /// No description provided for @acceptButton.
  ///
  /// In es, this message translates to:
  /// **'ACEPTAR'**
  String get acceptButton;

  /// No description provided for @announcementsTitle.
  ///
  /// In es, this message translates to:
  /// **'Anuncios'**
  String get announcementsTitle;

  /// No description provided for @urgentLabel.
  ///
  /// In es, this message translates to:
  /// **'¡URGENTE!'**
  String get urgentLabel;

  /// No description provided for @noticeLabel.
  ///
  /// In es, this message translates to:
  /// **'AVISO'**
  String get noticeLabel;

  /// No description provided for @rulesTitle.
  ///
  /// In es, this message translates to:
  /// **'Normativa'**
  String get rulesTitle;

  /// No description provided for @rulesBanner.
  ///
  /// In es, this message translates to:
  /// **'Reglamento de Convivencia vigente para el año 2026.'**
  String get rulesBanner;

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Mi Perfil'**
  String get profileTitle;

  /// No description provided for @ownerInfo.
  ///
  /// In es, this message translates to:
  /// **'Propietario: Apto {apartment}'**
  String ownerInfo(String apartment);

  /// No description provided for @emailInfoLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo'**
  String get emailInfoLabel;

  /// No description provided for @phoneInfoLabel.
  ///
  /// In es, this message translates to:
  /// **'Teléfono'**
  String get phoneInfoLabel;

  /// No description provided for @solvencyStatusLabel.
  ///
  /// In es, this message translates to:
  /// **'Estatus de Solvencia'**
  String get solvencyStatusLabel;

  /// No description provided for @solvencyStatusValue.
  ///
  /// In es, this message translates to:
  /// **'SOLVENTE'**
  String get solvencyStatusValue;

  /// No description provided for @pushNotifications.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones Push'**
  String get pushNotifications;

  /// No description provided for @changePassword.
  ///
  /// In es, this message translates to:
  /// **'Cambiar Contraseña'**
  String get changePassword;

  /// No description provided for @logoutButton.
  ///
  /// In es, this message translates to:
  /// **'CERRAR SESIÓN'**
  String get logoutButton;

  /// No description provided for @chatbotTitle.
  ///
  /// In es, this message translates to:
  /// **'Asistente Virtual Reside'**
  String get chatbotTitle;

  /// No description provided for @chatbotGreeting.
  ///
  /// In es, this message translates to:
  /// **'¡Hola! Soy Reside-Bot, tu asistente virtual. ¿En qué puedo ayudarte hoy?'**
  String get chatbotGreeting;

  /// No description provided for @chatbotPaymentMethods.
  ///
  /// In es, this message translates to:
  /// **'Aceptamos: \n• Transferencia (Banesco)\n• Pago Móvil\n• Zelle\n• Efectivo en oficina.\n\nAl pagar, recuerda subir tu comprobante en el módulo \'Pagar\' del menú principal.'**
  String get chatbotPaymentMethods;

  /// No description provided for @chatbotGenericFollowup.
  ///
  /// In es, this message translates to:
  /// **'Entendido. ¿Hay alguna otra consulta en la que pueda ayudarte?'**
  String get chatbotGenericFollowup;

  /// No description provided for @chatbotReservationGuide.
  ///
  /// In es, this message translates to:
  /// **'¡Perfecto! Para reservar:\n1. Ve al menú \'Reservas\'.\n2. Selecciona el área (Piscina, Parrillera, etc.).\n3. Elige la fecha.\n\nNota: Algunas áreas requieren un depósito de garantía de \$20. ¿Deseas ver las normas de uso de áreas?'**
  String get chatbotReservationGuide;

  /// No description provided for @chatbotReservationReminder.
  ///
  /// In es, this message translates to:
  /// **'De acuerdo. Recuerda que las reservas deben hacerse con 48h de antelación.'**
  String get chatbotReservationReminder;

  /// No description provided for @chatbotAreaRules.
  ///
  /// In es, this message translates to:
  /// **'Las normas principales son: \n• No música a alto volumen.\n• Máximo 15 invitados.\n• Entrega del área limpia.\n\n¿Deseas ayuda con algo más?'**
  String get chatbotAreaRules;

  /// No description provided for @chatbotEventWish.
  ///
  /// In es, this message translates to:
  /// **'Entendido. ¡Que disfrutes tu evento!'**
  String get chatbotEventWish;

  /// No description provided for @chatbotPaymentStatus.
  ///
  /// In es, this message translates to:
  /// **'Tu apartamento (4-B) tiene un saldo pendiente de \$45.00 (Enero). ¿Deseas ver los métodos de pago disponibles?'**
  String get chatbotPaymentStatus;

  /// No description provided for @chatbotTechnicalStatus.
  ///
  /// In es, this message translates to:
  /// **'Hay un reporte activo sobre la bomba de agua. El personal técnico ya está trabajando en el sitio. Estiman restablecer el servicio a las 4:00 PM.'**
  String get chatbotTechnicalStatus;

  /// No description provided for @chatbotReservationAvailable.
  ///
  /// In es, this message translates to:
  /// **'El módulo de reservas está habilitado para la Parrillera y el Salón de Fiestas. ¿Deseas que te explique el paso a paso para reservar?'**
  String get chatbotReservationAvailable;

  /// No description provided for @chatbotRulesQuery.
  ///
  /// In es, this message translates to:
  /// **'El reglamento prohibe ruidos molestos después de las 8:00 PM. Las mascotas deben usar correa siempre. ¿Quieres consultar algún artículo específico?'**
  String get chatbotRulesQuery;

  /// No description provided for @chatbotIntro.
  ///
  /// In es, this message translates to:
  /// **'¡Hola! Soy Reside-Bot. Estoy listo para ayudarte con la gestión de tu apartamento. ¿Qué necesitas?'**
  String get chatbotIntro;

  /// No description provided for @chatbotCourtesy.
  ///
  /// In es, this message translates to:
  /// **'¡Siempre a la orden! ¿Algo más?'**
  String get chatbotCourtesy;

  /// No description provided for @chatbotCapabilities.
  ///
  /// In es, this message translates to:
  /// **'Puedo informarte sobre tus pagos, registrar fallas técnicas, ayudarte con reservas o leerte las normas del edificio.'**
  String get chatbotCapabilities;

  /// No description provided for @chatbotError.
  ///
  /// In es, this message translates to:
  /// **'No logré procesar esa solicitud. Intenta preguntarme por \'pagos\', \'fallas técnicas\' o \'reservas\'.'**
  String get chatbotError;

  /// No description provided for @quickReplyDebt.
  ///
  /// In es, this message translates to:
  /// **'¿Cuánto debo?'**
  String get quickReplyDebt;

  /// No description provided for @quickReplyWaterIssue.
  ///
  /// In es, this message translates to:
  /// **'Falla de agua'**
  String get quickReplyWaterIssue;

  /// No description provided for @quickReplyReserveArea.
  ///
  /// In es, this message translates to:
  /// **'Reservar áreas'**
  String get quickReplyReserveArea;

  /// No description provided for @quickReplyNoiseRules.
  ///
  /// In es, this message translates to:
  /// **'Normas de ruido'**
  String get quickReplyNoiseRules;

  /// No description provided for @typingIndicator.
  ///
  /// In es, this message translates to:
  /// **'Escribiendo...'**
  String get typingIndicator;

  /// No description provided for @chatInputHint.
  ///
  /// In es, this message translates to:
  /// **'Escribe un mensaje...'**
  String get chatInputHint;

  /// No description provided for @creditsTitle.
  ///
  /// In es, this message translates to:
  /// **'Equipo de Desarrollo'**
  String get creditsTitle;

  /// No description provided for @teamMembersSection.
  ///
  /// In es, this message translates to:
  /// **'Integrantes del Equipo'**
  String get teamMembersSection;

  /// No description provided for @tutorSection.
  ///
  /// In es, this message translates to:
  /// **'Tutor Académico'**
  String get tutorSection;

  /// No description provided for @scanProfile.
  ///
  /// In es, this message translates to:
  /// **'Escanea para ver su perfil'**
  String get scanProfile;

  /// No description provided for @closeButton.
  ///
  /// In es, this message translates to:
  /// **'Cerrar'**
  String get closeButton;

  /// No description provided for @copyrightNotice.
  ///
  /// In es, this message translates to:
  /// **'© 2026 UNEXCA'**
  String get copyrightNotice;

  /// No description provided for @profileOf.
  ///
  /// In es, this message translates to:
  /// **'Perfil de {name}'**
  String profileOf(String name);

  /// No description provided for @visitorsAdminTitle.
  ///
  /// In es, this message translates to:
  /// **'Control de Visitantes'**
  String get visitorsAdminTitle;

  /// No description provided for @visitorsResidentTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis Visitantes'**
  String get visitorsResidentTitle;

  /// No description provided for @searchLabel.
  ///
  /// In es, this message translates to:
  /// **'Buscar'**
  String get searchLabel;

  /// No description provided for @searchVisitorHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre del visitante o apartamento...'**
  String get searchVisitorHint;

  /// No description provided for @todayLabel.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get todayLabel;

  /// No description provided for @inBuildingLabel.
  ///
  /// In es, this message translates to:
  /// **'En edificio'**
  String get inBuildingLabel;

  /// No description provided for @pendingLabel.
  ///
  /// In es, this message translates to:
  /// **'Pendientes'**
  String get pendingLabel;

  /// No description provided for @visitorStatusPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get visitorStatusPending;

  /// No description provided for @visitorStatusApproved.
  ///
  /// In es, this message translates to:
  /// **'Aprobado'**
  String get visitorStatusApproved;

  /// No description provided for @visitorStatusInBuilding.
  ///
  /// In es, this message translates to:
  /// **'En edificio'**
  String get visitorStatusInBuilding;

  /// No description provided for @visitorStatusExited.
  ///
  /// In es, this message translates to:
  /// **'Salió'**
  String get visitorStatusExited;

  /// No description provided for @visitorStatusRejected.
  ///
  /// In es, this message translates to:
  /// **'Rechazado'**
  String get visitorStatusRejected;

  /// No description provided for @noVisitorsFound.
  ///
  /// In es, this message translates to:
  /// **'No se encontraron visitantes'**
  String get noVisitorsFound;

  /// No description provided for @noVisitorsRegistered.
  ///
  /// In es, this message translates to:
  /// **'No tienes visitantes registrados'**
  String get noVisitorsRegistered;

  /// No description provided for @accessCodeLabel.
  ///
  /// In es, this message translates to:
  /// **'Código de acceso: {code}'**
  String accessCodeLabel(String code);

  /// No description provided for @approveButton.
  ///
  /// In es, this message translates to:
  /// **'Aprobar'**
  String get approveButton;

  /// No description provided for @rejectButton.
  ///
  /// In es, this message translates to:
  /// **'Rechazar'**
  String get rejectButton;

  /// No description provided for @approveVisitorTitle.
  ///
  /// In es, this message translates to:
  /// **'Aprobar Visitante'**
  String get approveVisitorTitle;

  /// No description provided for @rejectVisitorTitle.
  ///
  /// In es, this message translates to:
  /// **'Rechazar Visitante'**
  String get rejectVisitorTitle;

  /// No description provided for @visitorActionConfirm.
  ///
  /// In es, this message translates to:
  /// **'¿Está seguro que desea {action} la visita de \"{name}\" al apartamento {apartment}?'**
  String visitorActionConfirm(String action, String name, String apartment);

  /// No description provided for @cancelButton.
  ///
  /// In es, this message translates to:
  /// **'CANCELAR'**
  String get cancelButton;

  /// No description provided for @approveButtonUpper.
  ///
  /// In es, this message translates to:
  /// **'APROBAR'**
  String get approveButtonUpper;

  /// No description provided for @rejectButtonUpper.
  ///
  /// In es, this message translates to:
  /// **'RECHAZAR'**
  String get rejectButtonUpper;

  /// No description provided for @visitorActionSuccess.
  ///
  /// In es, this message translates to:
  /// **'Visitante {status} exitosamente'**
  String visitorActionSuccess(String status);

  /// No description provided for @registerVisitorTitle.
  ///
  /// In es, this message translates to:
  /// **'Registrar Visitante'**
  String get registerVisitorTitle;

  /// No description provided for @visitorNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get visitorNameLabel;

  /// No description provided for @visitorCedulaLabel.
  ///
  /// In es, this message translates to:
  /// **'Cédula (V-XX.XXX.XXX)'**
  String get visitorCedulaLabel;

  /// No description provided for @visitorNameRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingrese el nombre del visitante'**
  String get visitorNameRequired;

  /// No description provided for @visitorCedulaRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingrese la cédula del visitante'**
  String get visitorCedulaRequired;

  /// No description provided for @expectedDateLabel.
  ///
  /// In es, this message translates to:
  /// **'Fecha esperada'**
  String get expectedDateLabel;

  /// No description provided for @vehiclePlateLabel.
  ///
  /// In es, this message translates to:
  /// **'Placa del vehículo (opcional)'**
  String get vehiclePlateLabel;

  /// No description provided for @notesOptionalLabel.
  ///
  /// In es, this message translates to:
  /// **'Notas (opcional)'**
  String get notesOptionalLabel;

  /// No description provided for @registerVisitorButton.
  ///
  /// In es, this message translates to:
  /// **'Registrar Visitante'**
  String get registerVisitorButton;

  /// No description provided for @visitorRegisteredSuccess.
  ///
  /// In es, this message translates to:
  /// **'Visitante registrado exitosamente'**
  String get visitorRegisteredSuccess;

  /// No description provided for @maintenanceAdminTitle.
  ///
  /// In es, this message translates to:
  /// **'Gestión de Solicitudes'**
  String get maintenanceAdminTitle;

  /// No description provided for @maintenanceResidentTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis Solicitudes'**
  String get maintenanceResidentTitle;

  /// No description provided for @categoryPlumbing.
  ///
  /// In es, this message translates to:
  /// **'Plomería'**
  String get categoryPlumbing;

  /// No description provided for @categoryElectrical.
  ///
  /// In es, this message translates to:
  /// **'Electricidad'**
  String get categoryElectrical;

  /// No description provided for @categoryElevator.
  ///
  /// In es, this message translates to:
  /// **'Ascensor'**
  String get categoryElevator;

  /// No description provided for @categoryCommonAreas.
  ///
  /// In es, this message translates to:
  /// **'Áreas comunes'**
  String get categoryCommonAreas;

  /// No description provided for @categoryStructural.
  ///
  /// In es, this message translates to:
  /// **'Estructura'**
  String get categoryStructural;

  /// No description provided for @categorySecurity.
  ///
  /// In es, this message translates to:
  /// **'Seguridad'**
  String get categorySecurity;

  /// No description provided for @categoryOther.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get categoryOther;

  /// No description provided for @priorityLow.
  ///
  /// In es, this message translates to:
  /// **'Baja'**
  String get priorityLow;

  /// No description provided for @priorityMedium.
  ///
  /// In es, this message translates to:
  /// **'Media'**
  String get priorityMedium;

  /// No description provided for @priorityHigh.
  ///
  /// In es, this message translates to:
  /// **'Alta'**
  String get priorityHigh;

  /// No description provided for @priorityUrgent.
  ///
  /// In es, this message translates to:
  /// **'Urgente'**
  String get priorityUrgent;

  /// No description provided for @statusOpen.
  ///
  /// In es, this message translates to:
  /// **'Abierta'**
  String get statusOpen;

  /// No description provided for @statusInProgress.
  ///
  /// In es, this message translates to:
  /// **'En Progreso'**
  String get statusInProgress;

  /// No description provided for @statusResolved.
  ///
  /// In es, this message translates to:
  /// **'Resuelta'**
  String get statusResolved;

  /// No description provided for @statusClosed.
  ///
  /// In es, this message translates to:
  /// **'Cerrada'**
  String get statusClosed;

  /// No description provided for @adminStatsOpen.
  ///
  /// In es, this message translates to:
  /// **'Abiertas: {count}'**
  String adminStatsOpen(int count);

  /// No description provided for @adminStatsInProgress.
  ///
  /// In es, this message translates to:
  /// **'En progreso: {count}'**
  String adminStatsInProgress(int count);

  /// No description provided for @adminStatsUrgent.
  ///
  /// In es, this message translates to:
  /// **'Urgentes: {count}'**
  String adminStatsUrgent(int count);

  /// No description provided for @filterOpen.
  ///
  /// In es, this message translates to:
  /// **'Abiertas'**
  String get filterOpen;

  /// No description provided for @filterInProgress.
  ///
  /// In es, this message translates to:
  /// **'En Progreso'**
  String get filterInProgress;

  /// No description provided for @filterResolved.
  ///
  /// In es, this message translates to:
  /// **'Resueltas'**
  String get filterResolved;

  /// No description provided for @noRequestsFilter.
  ///
  /// In es, this message translates to:
  /// **'No hay solicitudes con este filtro'**
  String get noRequestsFilter;

  /// No description provided for @noRequestsRegistered.
  ///
  /// In es, this message translates to:
  /// **'No tienes solicitudes registradas'**
  String get noRequestsRegistered;

  /// No description provided for @newRequestTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva Solicitud'**
  String get newRequestTitle;

  /// No description provided for @categoryLabel.
  ///
  /// In es, this message translates to:
  /// **'Categoría'**
  String get categoryLabel;

  /// No description provided for @priorityLabel.
  ///
  /// In es, this message translates to:
  /// **'Prioridad'**
  String get priorityLabel;

  /// No description provided for @titleLabel.
  ///
  /// In es, this message translates to:
  /// **'Título'**
  String get titleLabel;

  /// No description provided for @titleHint.
  ///
  /// In es, this message translates to:
  /// **'Ej: Fuga de agua en la cocina'**
  String get titleHint;

  /// No description provided for @titleRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingrese un título'**
  String get titleRequired;

  /// No description provided for @descriptionLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get descriptionLabel;

  /// No description provided for @descriptionHint.
  ///
  /// In es, this message translates to:
  /// **'Describa el problema con detalle...'**
  String get descriptionHint;

  /// No description provided for @descriptionRequired.
  ///
  /// In es, this message translates to:
  /// **'Ingrese una descripción'**
  String get descriptionRequired;

  /// No description provided for @attachPhotos.
  ///
  /// In es, this message translates to:
  /// **'Adjuntar fotos (próximamente)'**
  String get attachPhotos;

  /// No description provided for @sendRequestButton.
  ///
  /// In es, this message translates to:
  /// **'Enviar Solicitud'**
  String get sendRequestButton;

  /// No description provided for @requestSentSuccess.
  ///
  /// In es, this message translates to:
  /// **'Solicitud enviada exitosamente'**
  String get requestSentSuccess;

  /// No description provided for @statusLabel.
  ///
  /// In es, this message translates to:
  /// **'Estado'**
  String get statusLabel;

  /// No description provided for @assignToLabel.
  ///
  /// In es, this message translates to:
  /// **'Asignar a'**
  String get assignToLabel;

  /// No description provided for @assignToHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre del responsable'**
  String get assignToHint;

  /// No description provided for @adminNotesLabel.
  ///
  /// In es, this message translates to:
  /// **'Notas de administración'**
  String get adminNotesLabel;

  /// No description provided for @adminNotesHint.
  ///
  /// In es, this message translates to:
  /// **'Observaciones internas...'**
  String get adminNotesHint;

  /// No description provided for @saveButton.
  ///
  /// In es, this message translates to:
  /// **'GUARDAR'**
  String get saveButton;

  /// No description provided for @requestUpdatedSuccess.
  ///
  /// In es, this message translates to:
  /// **'Solicitud actualizada'**
  String get requestUpdatedSuccess;

  /// No description provided for @assignedTo.
  ///
  /// In es, this message translates to:
  /// **'Asignado a: {name}'**
  String assignedTo(String name);

  /// No description provided for @votingAdminTitle.
  ///
  /// In es, this message translates to:
  /// **'Gestión de Votaciones'**
  String get votingAdminTitle;

  /// No description provided for @votingResidentTitle.
  ///
  /// In es, this message translates to:
  /// **'Votaciones'**
  String get votingResidentTitle;

  /// No description provided for @tabActive.
  ///
  /// In es, this message translates to:
  /// **'Activas'**
  String get tabActive;

  /// No description provided for @tabClosed.
  ///
  /// In es, this message translates to:
  /// **'Cerradas'**
  String get tabClosed;

  /// No description provided for @tabUpcoming.
  ///
  /// In es, this message translates to:
  /// **'Próximas'**
  String get tabUpcoming;

  /// No description provided for @noActivePolls.
  ///
  /// In es, this message translates to:
  /// **'No hay votaciones activas'**
  String get noActivePolls;

  /// No description provided for @noClosedPolls.
  ///
  /// In es, this message translates to:
  /// **'No hay votaciones cerradas'**
  String get noClosedPolls;

  /// No description provided for @noUpcomingPolls.
  ///
  /// In es, this message translates to:
  /// **'No hay votaciones próximas'**
  String get noUpcomingPolls;

  /// No description provided for @createPollTitle.
  ///
  /// In es, this message translates to:
  /// **'Crear Nueva Votación'**
  String get createPollTitle;

  /// No description provided for @pollTitleLabel.
  ///
  /// In es, this message translates to:
  /// **'Título'**
  String get pollTitleLabel;

  /// No description provided for @pollDescriptionLabel.
  ///
  /// In es, this message translates to:
  /// **'Descripción'**
  String get pollDescriptionLabel;

  /// No description provided for @optionsLabel.
  ///
  /// In es, this message translates to:
  /// **'Opciones'**
  String get optionsLabel;

  /// No description provided for @optionNumber.
  ///
  /// In es, this message translates to:
  /// **'Opción {number}'**
  String optionNumber(int number);

  /// No description provided for @addOptionButton.
  ///
  /// In es, this message translates to:
  /// **'Agregar opción'**
  String get addOptionButton;

  /// No description provided for @startDateLabel.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get startDateLabel;

  /// No description provided for @endDateLabel.
  ///
  /// In es, this message translates to:
  /// **'Fin'**
  String get endDateLabel;

  /// No description provided for @createPollButton.
  ///
  /// In es, this message translates to:
  /// **'CREAR VOTACIÓN'**
  String get createPollButton;

  /// No description provided for @voteRegisteredSuccess.
  ///
  /// In es, this message translates to:
  /// **'Voto registrado exitosamente'**
  String get voteRegisteredSuccess;

  /// No description provided for @pollCreatedSuccess.
  ///
  /// In es, this message translates to:
  /// **'Votación creada exitosamente'**
  String get pollCreatedSuccess;

  /// No description provided for @pollStatusActive.
  ///
  /// In es, this message translates to:
  /// **'Activa'**
  String get pollStatusActive;

  /// No description provided for @pollStatusClosed.
  ///
  /// In es, this message translates to:
  /// **'Cerrada'**
  String get pollStatusClosed;

  /// No description provided for @pollStatusUpcoming.
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get pollStatusUpcoming;

  /// No description provided for @pollStartsOn.
  ///
  /// In es, this message translates to:
  /// **'Inicia: {date}'**
  String pollStartsOn(String date);

  /// No description provided for @pollEndsOn.
  ///
  /// In es, this message translates to:
  /// **'Finaliza: {date}'**
  String pollEndsOn(String date);

  /// No description provided for @voteButton.
  ///
  /// In es, this message translates to:
  /// **'VOTAR'**
  String get voteButton;

  /// No description provided for @voteResults.
  ///
  /// In es, this message translates to:
  /// **'{votes} ({percentage}%)'**
  String voteResults(int votes, String percentage);

  /// No description provided for @participationActive.
  ///
  /// In es, this message translates to:
  /// **'{count}/50 residentes han votado'**
  String participationActive(int count);

  /// No description provided for @closePollButton.
  ///
  /// In es, this message translates to:
  /// **'Cerrar votación'**
  String get closePollButton;

  /// No description provided for @participationClosed.
  ///
  /// In es, this message translates to:
  /// **'{count}/50 residentes votaron'**
  String participationClosed(int count);

  /// No description provided for @emergencyTitle.
  ///
  /// In es, this message translates to:
  /// **'Contactos de Emergencia'**
  String get emergencyTitle;

  /// No description provided for @emergencyBanner.
  ///
  /// In es, this message translates to:
  /// **'En caso de emergencia, contacte inmediatamente'**
  String get emergencyBanner;

  /// No description provided for @emergencySection.
  ///
  /// In es, this message translates to:
  /// **'Emergencias'**
  String get emergencySection;

  /// No description provided for @buildingSection.
  ///
  /// In es, this message translates to:
  /// **'Edificio'**
  String get buildingSection;

  /// No description provided for @technicalSection.
  ///
  /// In es, this message translates to:
  /// **'Servicios Técnicos'**
  String get technicalSection;

  /// No description provided for @callingTo.
  ///
  /// In es, this message translates to:
  /// **'Llamando a {name}...'**
  String callingTo(String name);

  /// No description provided for @available24h.
  ///
  /// In es, this message translates to:
  /// **'24h'**
  String get available24h;

  /// No description provided for @reportsAdminTitle.
  ///
  /// In es, this message translates to:
  /// **'Panel de Reportes Reside'**
  String get reportsAdminTitle;

  /// No description provided for @reportsResidentTitle.
  ///
  /// In es, this message translates to:
  /// **'Mis Estadísticas'**
  String get reportsResidentTitle;

  /// No description provided for @reportsAdminHeading.
  ///
  /// In es, this message translates to:
  /// **'Resumen de Gestión'**
  String get reportsAdminHeading;

  /// No description provided for @reportsResidentHeading.
  ///
  /// In es, this message translates to:
  /// **'Tu Actividad en el Condominio'**
  String get reportsResidentHeading;

  /// No description provided for @expenseBreakdownTitle.
  ///
  /// In es, this message translates to:
  /// **'Distribución de Gastos'**
  String get expenseBreakdownTitle;

  /// No description provided for @monthlyCollectionTitle.
  ///
  /// In es, this message translates to:
  /// **'Recaudación Mensual'**
  String get monthlyCollectionTitle;

  /// No description provided for @chatbotTopicsTitle.
  ///
  /// In es, this message translates to:
  /// **'Temas más consultados al Chatbot'**
  String get chatbotTopicsTitle;

  /// No description provided for @chatLogsTitle.
  ///
  /// In es, this message translates to:
  /// **'Últimos reportes vía Chatbot'**
  String get chatLogsTitle;

  /// No description provided for @collectedLabel.
  ///
  /// In es, this message translates to:
  /// **'Cobrado'**
  String get collectedLabel;

  /// No description provided for @pendingLegendLabel.
  ///
  /// In es, this message translates to:
  /// **'Pendiente'**
  String get pendingLegendLabel;

  /// No description provided for @resolvedByAI.
  ///
  /// In es, this message translates to:
  /// **'Resuelto por IA'**
  String get resolvedByAI;

  /// No description provided for @escalatedToBoard.
  ///
  /// In es, this message translates to:
  /// **'Escalado a Junta'**
  String get escalatedToBoard;

  /// No description provided for @adminInsight.
  ///
  /// In es, this message translates to:
  /// **'Sugerencia: El volumen de dudas sobre \'Pagos\' indica que el botón de ayuda debe ser más visible.'**
  String get adminInsight;

  /// No description provided for @residentInsight.
  ///
  /// In es, this message translates to:
  /// **'Gracias por tu solvencia. Esto permite el mantenimiento de las áreas comunes.'**
  String get residentInsight;

  /// No description provided for @notificationMessage.
  ///
  /// In es, this message translates to:
  /// **'Tienes un nuevo anuncio: Corte de agua programado'**
  String get notificationMessage;

  /// No description provided for @navHome.
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navPayments.
  ///
  /// In es, this message translates to:
  /// **'Pagos'**
  String get navPayments;

  /// No description provided for @navCommunity.
  ///
  /// In es, this message translates to:
  /// **'Comunidad'**
  String get navCommunity;

  /// No description provided for @navServices.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get navServices;

  /// No description provided for @navProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// No description provided for @paymentsHubTitle.
  ///
  /// In es, this message translates to:
  /// **'Pagos'**
  String get paymentsHubTitle;

  /// No description provided for @reportPayment.
  ///
  /// In es, this message translates to:
  /// **'Reportar Pago'**
  String get reportPayment;

  /// No description provided for @reportPaymentDesc.
  ///
  /// In es, this message translates to:
  /// **'Registra un nuevo pago realizado'**
  String get reportPaymentDesc;

  /// No description provided for @paymentHistoryTitle.
  ///
  /// In es, this message translates to:
  /// **'Historial de Pagos'**
  String get paymentHistoryTitle;

  /// No description provided for @paymentHistoryDesc.
  ///
  /// In es, this message translates to:
  /// **'Consulta tus pagos anteriores'**
  String get paymentHistoryDesc;

  /// No description provided for @communityHubTitle.
  ///
  /// In es, this message translates to:
  /// **'Comunidad'**
  String get communityHubTitle;

  /// No description provided for @announcementsDesc.
  ///
  /// In es, this message translates to:
  /// **'Noticias y comunicados del edificio'**
  String get announcementsDesc;

  /// No description provided for @votingDesc.
  ///
  /// In es, this message translates to:
  /// **'Participa en las decisiones'**
  String get votingDesc;

  /// No description provided for @rulesDesc.
  ///
  /// In es, this message translates to:
  /// **'Reglamento de convivencia'**
  String get rulesDesc;

  /// No description provided for @visitorsDesc.
  ///
  /// In es, this message translates to:
  /// **'Gestiona el acceso de visitantes'**
  String get visitorsDesc;

  /// No description provided for @servicesHubTitle.
  ///
  /// In es, this message translates to:
  /// **'Servicios'**
  String get servicesHubTitle;

  /// No description provided for @maintenanceDesc.
  ///
  /// In es, this message translates to:
  /// **'Reporta problemas o fallas'**
  String get maintenanceDesc;

  /// No description provided for @reservationsDesc.
  ///
  /// In es, this message translates to:
  /// **'Reserva áreas comunes'**
  String get reservationsDesc;

  /// No description provided for @emergencyDesc.
  ///
  /// In es, this message translates to:
  /// **'Números de contacto importantes'**
  String get emergencyDesc;

  /// No description provided for @greetingMorning.
  ///
  /// In es, this message translates to:
  /// **'Buenos días'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In es, this message translates to:
  /// **'Buenas tardes'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In es, this message translates to:
  /// **'Buenas noches'**
  String get greetingEvening;

  /// No description provided for @quickActions.
  ///
  /// In es, this message translates to:
  /// **'Acciones Rápidas'**
  String get quickActions;

  /// No description provided for @recentActivity.
  ///
  /// In es, this message translates to:
  /// **'Actividad Reciente'**
  String get recentActivity;

  /// No description provided for @viewAll.
  ///
  /// In es, this message translates to:
  /// **'Ver todo'**
  String get viewAll;

  /// No description provided for @chatbot.
  ///
  /// In es, this message translates to:
  /// **'Chatbot'**
  String get chatbot;

  /// No description provided for @reserve.
  ///
  /// In es, this message translates to:
  /// **'Reservar'**
  String get reserve;

  /// No description provided for @report.
  ///
  /// In es, this message translates to:
  /// **'Reportar'**
  String get report;

  /// No description provided for @activityPaymentApproved.
  ///
  /// In es, this message translates to:
  /// **'Pago aprobado'**
  String get activityPaymentApproved;

  /// No description provided for @activityReservationSent.
  ///
  /// In es, this message translates to:
  /// **'Reserva enviada'**
  String get activityReservationSent;

  /// No description provided for @activityNewAnnouncement.
  ///
  /// In es, this message translates to:
  /// **'Nuevo anuncio'**
  String get activityNewAnnouncement;

  /// No description provided for @activityPaymentAmount.
  ///
  /// In es, this message translates to:
  /// **'\$150.00'**
  String get activityPaymentAmount;

  /// No description provided for @activityReservationArea.
  ///
  /// In es, this message translates to:
  /// **'Parrillera Central'**
  String get activityReservationArea;

  /// No description provided for @activityAnnouncementText.
  ///
  /// In es, this message translates to:
  /// **'Corte de agua programado'**
  String get activityAnnouncementText;

  /// No description provided for @daysAgo.
  ///
  /// In es, this message translates to:
  /// **'Hace {count} días'**
  String daysAgo(int count);

  /// No description provided for @adminQuickMorosos.
  ///
  /// In es, this message translates to:
  /// **'Morosos'**
  String get adminQuickMorosos;

  /// No description provided for @adminQuickSolicitudes.
  ///
  /// In es, this message translates to:
  /// **'Solicitudes'**
  String get adminQuickSolicitudes;

  /// No description provided for @adminQuickAnuncios.
  ///
  /// In es, this message translates to:
  /// **'Anuncios'**
  String get adminQuickAnuncios;

  /// No description provided for @adminQuickReportes.
  ///
  /// In es, this message translates to:
  /// **'Reportes'**
  String get adminQuickReportes;

  /// No description provided for @adminActivityPaymentReceived.
  ///
  /// In es, this message translates to:
  /// **'Pago recibido'**
  String get adminActivityPaymentReceived;

  /// No description provided for @adminActivityPaymentApt.
  ///
  /// In es, this message translates to:
  /// **'Apto 3-A - Transferencia'**
  String get adminActivityPaymentApt;

  /// No description provided for @adminActivityNewRequest.
  ///
  /// In es, this message translates to:
  /// **'Nueva solicitud'**
  String get adminActivityNewRequest;

  /// No description provided for @adminActivityRequestText.
  ///
  /// In es, this message translates to:
  /// **'Fuga de agua - Apto 7-C'**
  String get adminActivityRequestText;

  /// No description provided for @adminActivityPollClosed.
  ///
  /// In es, this message translates to:
  /// **'Votación cerrada'**
  String get adminActivityPollClosed;

  /// No description provided for @adminActivityPollText.
  ///
  /// In es, this message translates to:
  /// **'Pintura de fachada - 38 votos'**
  String get adminActivityPollText;

  /// No description provided for @adminBadge.
  ///
  /// In es, this message translates to:
  /// **'Administrador'**
  String get adminBadge;
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return L10nEn();
    case 'es':
      return L10nEs();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
