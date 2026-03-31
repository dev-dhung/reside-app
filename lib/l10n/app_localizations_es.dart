// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Reside';

  @override
  String get appSubtitle => 'Tu comunidad, conectada';

  @override
  String get appTitle => 'Reside';

  @override
  String get emailOrPhoneLabel => 'Correo electrónico o teléfono';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get rememberMe => 'Recordarme';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginButton => 'INGRESAR';

  @override
  String get registerLink => '¿No tienes cuenta? Regístrate aquí';

  @override
  String get developedBy => 'Desarrollado por...';

  @override
  String get registerTitle => 'Registro';

  @override
  String get registerSubtitle => 'Activa tu cuenta';

  @override
  String get registerDescription => 'Complete sus datos para registrarse';

  @override
  String get invitationCodeLabel => 'Código de invitación';

  @override
  String get invitationCodeHint => 'Ej: RES-4B-2026';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get phoneLabel => 'Número de teléfono';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get registerButton => 'CREAR CUENTA';

  @override
  String get apartmentLabel => 'Apartamento';

  @override
  String get fullNameLabel => 'Nombre Completo';

  @override
  String get cedulaLabel => 'Número de Cédula';

  @override
  String get towerApartmentLabel => 'Torre / Apartamento';

  @override
  String get welcomeMessage => 'Bienvenido';

  @override
  String get homeAdminTitle => 'Reside - Gestión Admin';

  @override
  String get homeResidentTitle => 'Reside - Mi tablero';

  @override
  String get adminSectionTitle => 'Panel de Control Administrativo';

  @override
  String get residentSectionTitle => 'Servicios y Gestión';

  @override
  String get modeResident => 'Modo Vecino';

  @override
  String get modeAdmin => 'Modo Admin';

  @override
  String get menuPay => 'Pagar';

  @override
  String get menuHistory => 'Historial';

  @override
  String get menuReservations => 'Reservas';

  @override
  String get menuVisitors => 'Visitantes';

  @override
  String get menuMaintenance => 'Solicitudes';

  @override
  String get menuVoting => 'Votaciones';

  @override
  String get menuAnnouncements => 'Anuncios';

  @override
  String get menuRules => 'Normativa';

  @override
  String get menuReports => 'Reportes';

  @override
  String get menuEmergency => 'Emergencias';

  @override
  String get adminRecaudation => 'Recaudación Total Mensual';

  @override
  String get adminCajaLabel => 'Fondo de la Residencia';

  @override
  String get residentAccountStatus => 'Estado de Cuenta';

  @override
  String get residentPendingLabel => 'Pendiente - Enero 2026';

  @override
  String get paymentTitle => 'Reportar Pago';

  @override
  String get transactionDetails => 'Detalles de la Transacción';

  @override
  String get paymentMethodLabel => 'Método de Pago';

  @override
  String get methodTransfer => 'Transferencia';

  @override
  String get methodMobilePay => 'Pago Móvil';

  @override
  String get methodZelle => 'Zelle';

  @override
  String get methodCash => 'Efectivo';

  @override
  String get referenceNumberLabel => 'Número de Referencia';

  @override
  String get amountLabel => 'Monto (\$)';

  @override
  String get attachReceipt => 'Adjuntar Comprobante';

  @override
  String get sendReportButton => 'ENVIAR REPORTE';

  @override
  String get paymentSuccessMessage =>
      'Su reporte de pago ha sido enviado con éxito a la junta de condominio. Será validado en las próximas 24 horas.';

  @override
  String get understoodButton => 'ENTENDIDO';

  @override
  String get paymentHistoryAdminTitle => 'Registro de Pagos';

  @override
  String get paymentHistoryResidentTitle => 'Historial de Pagos';

  @override
  String get collectedThisMonth => 'Recaudado\neste mes';

  @override
  String get toCollect => 'Por cobrar';

  @override
  String get defaulters => 'Morosos';

  @override
  String get totalPaid => 'Total pagado';

  @override
  String get pending => 'Pendiente';

  @override
  String get searchByApartment => 'Buscar por apartamento';

  @override
  String get searchHintApt => 'Ej: 4-B';

  @override
  String get filterAll => 'Todos';

  @override
  String get filterApproved => 'Aprobados';

  @override
  String get filterPending => 'Pendientes';

  @override
  String get filterRejected => 'Rechazados';

  @override
  String get noPaymentsMatch => 'No hay pagos que coincidan con el filtro';

  @override
  String get statusApproved => 'Aprobado';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusRejected => 'Rechazado';

  @override
  String aptLabel(String apartment) {
    return 'Apto $apartment';
  }

  @override
  String refLabel(String reference) {
    return 'Ref: $reference';
  }

  @override
  String get defaultPaymentDesc => 'Pago';

  @override
  String get reservationsTitle => 'Reservas';

  @override
  String get statusAvailable => 'Disponible';

  @override
  String get statusOccupied => 'Ocupado';

  @override
  String get statusMaintenance => 'En mantenimiento';

  @override
  String get reserveButton => 'RESERVAR';

  @override
  String get reservationSentTitle => 'Reserva Enviada';

  @override
  String reservationSentMessage(String areaName, String date) {
    return 'Su solicitud de reserva para \"$areaName\" el $date ha sido enviada para aprobación.';
  }

  @override
  String get acceptButton => 'ACEPTAR';

  @override
  String get announcementsTitle => 'Anuncios';

  @override
  String get urgentLabel => '¡URGENTE!';

  @override
  String get noticeLabel => 'AVISO';

  @override
  String get rulesTitle => 'Normativa';

  @override
  String get rulesBanner =>
      'Reglamento de Convivencia vigente para el año 2026.';

  @override
  String get profileTitle => 'Mi Perfil';

  @override
  String ownerInfo(String apartment) {
    return 'Propietario: Apto $apartment';
  }

  @override
  String get emailInfoLabel => 'Correo';

  @override
  String get phoneInfoLabel => 'Teléfono';

  @override
  String get solvencyStatusLabel => 'Estatus de Solvencia';

  @override
  String get solvencyStatusValue => 'SOLVENTE';

  @override
  String get pushNotifications => 'Notificaciones Push';

  @override
  String get changePassword => 'Cambiar Contraseña';

  @override
  String get logoutButton => 'CERRAR SESIÓN';

  @override
  String get chatbotTitle => 'Asistente Virtual Reside';

  @override
  String get chatbotGreeting =>
      '¡Hola! Soy Reside-Bot, tu asistente virtual. ¿En qué puedo ayudarte hoy?';

  @override
  String get chatbotPaymentMethods =>
      'Aceptamos: \n• Transferencia (Banesco)\n• Pago Móvil\n• Zelle\n• Efectivo en oficina.\n\nAl pagar, recuerda subir tu comprobante en el módulo \'Pagar\' del menú principal.';

  @override
  String get chatbotGenericFollowup =>
      'Entendido. ¿Hay alguna otra consulta en la que pueda ayudarte?';

  @override
  String get chatbotReservationGuide =>
      '¡Perfecto! Para reservar:\n1. Ve al menú \'Reservas\'.\n2. Selecciona el área (Piscina, Parrillera, etc.).\n3. Elige la fecha.\n\nNota: Algunas áreas requieren un depósito de garantía de \$20. ¿Deseas ver las normas de uso de áreas?';

  @override
  String get chatbotReservationReminder =>
      'De acuerdo. Recuerda que las reservas deben hacerse con 48h de antelación.';

  @override
  String get chatbotAreaRules =>
      'Las normas principales son: \n• No música a alto volumen.\n• Máximo 15 invitados.\n• Entrega del área limpia.\n\n¿Deseas ayuda con algo más?';

  @override
  String get chatbotEventWish => 'Entendido. ¡Que disfrutes tu evento!';

  @override
  String get chatbotPaymentStatus =>
      'Tu apartamento (4-B) tiene un saldo pendiente de \$45.00 (Enero). ¿Deseas ver los métodos de pago disponibles?';

  @override
  String get chatbotTechnicalStatus =>
      'Hay un reporte activo sobre la bomba de agua. El personal técnico ya está trabajando en el sitio. Estiman restablecer el servicio a las 4:00 PM.';

  @override
  String get chatbotReservationAvailable =>
      'El módulo de reservas está habilitado para la Parrillera y el Salón de Fiestas. ¿Deseas que te explique el paso a paso para reservar?';

  @override
  String get chatbotRulesQuery =>
      'El reglamento prohibe ruidos molestos después de las 8:00 PM. Las mascotas deben usar correa siempre. ¿Quieres consultar algún artículo específico?';

  @override
  String get chatbotIntro =>
      '¡Hola! Soy Reside-Bot. Estoy listo para ayudarte con la gestión de tu apartamento. ¿Qué necesitas?';

  @override
  String get chatbotCourtesy => '¡Siempre a la orden! ¿Algo más?';

  @override
  String get chatbotCapabilities =>
      'Puedo informarte sobre tus pagos, registrar fallas técnicas, ayudarte con reservas o leerte las normas del edificio.';

  @override
  String get chatbotError =>
      'No logré procesar esa solicitud. Intenta preguntarme por \'pagos\', \'fallas técnicas\' o \'reservas\'.';

  @override
  String get quickReplyDebt => '¿Cuánto debo?';

  @override
  String get quickReplyWaterIssue => 'Falla de agua';

  @override
  String get quickReplyReserveArea => 'Reservar áreas';

  @override
  String get quickReplyNoiseRules => 'Normas de ruido';

  @override
  String get typingIndicator => 'Escribiendo...';

  @override
  String get chatInputHint => 'Escribe un mensaje...';

  @override
  String get creditsTitle => 'Equipo de Desarrollo';

  @override
  String get teamMembersSection => 'Integrantes del Equipo';

  @override
  String get tutorSection => 'Tutor Académico';

  @override
  String get scanProfile => 'Escanea para ver su perfil';

  @override
  String get closeButton => 'Cerrar';

  @override
  String get copyrightNotice => '© 2026 UNEXCA';

  @override
  String profileOf(String name) {
    return 'Perfil de $name';
  }

  @override
  String get visitorsAdminTitle => 'Control de Visitantes';

  @override
  String get visitorsResidentTitle => 'Mis Visitantes';

  @override
  String get searchLabel => 'Buscar';

  @override
  String get searchVisitorHint => 'Nombre del visitante o apartamento...';

  @override
  String get todayLabel => 'Hoy';

  @override
  String get inBuildingLabel => 'En edificio';

  @override
  String get pendingLabel => 'Pendientes';

  @override
  String get visitorStatusPending => 'Pendiente';

  @override
  String get visitorStatusApproved => 'Aprobado';

  @override
  String get visitorStatusInBuilding => 'En edificio';

  @override
  String get visitorStatusExited => 'Salió';

  @override
  String get visitorStatusRejected => 'Rechazado';

  @override
  String get noVisitorsFound => 'No se encontraron visitantes';

  @override
  String get noVisitorsRegistered => 'No tienes visitantes registrados';

  @override
  String accessCodeLabel(String code) {
    return 'Código de acceso: $code';
  }

  @override
  String get approveButton => 'Aprobar';

  @override
  String get rejectButton => 'Rechazar';

  @override
  String get approveVisitorTitle => 'Aprobar Visitante';

  @override
  String get rejectVisitorTitle => 'Rechazar Visitante';

  @override
  String visitorActionConfirm(String action, String name, String apartment) {
    return '¿Está seguro que desea $action la visita de \"$name\" al apartamento $apartment?';
  }

  @override
  String get cancelButton => 'CANCELAR';

  @override
  String get approveButtonUpper => 'APROBAR';

  @override
  String get rejectButtonUpper => 'RECHAZAR';

  @override
  String visitorActionSuccess(String status) {
    return 'Visitante $status exitosamente';
  }

  @override
  String get registerVisitorTitle => 'Registrar Visitante';

  @override
  String get visitorNameLabel => 'Nombre completo';

  @override
  String get visitorCedulaLabel => 'Cédula (V-XX.XXX.XXX)';

  @override
  String get visitorNameRequired => 'Ingrese el nombre del visitante';

  @override
  String get visitorCedulaRequired => 'Ingrese la cédula del visitante';

  @override
  String get expectedDateLabel => 'Fecha esperada';

  @override
  String get vehiclePlateLabel => 'Placa del vehículo (opcional)';

  @override
  String get notesOptionalLabel => 'Notas (opcional)';

  @override
  String get registerVisitorButton => 'Registrar Visitante';

  @override
  String get visitorRegisteredSuccess => 'Visitante registrado exitosamente';

  @override
  String get maintenanceAdminTitle => 'Gestión de Solicitudes';

  @override
  String get maintenanceResidentTitle => 'Mis Solicitudes';

  @override
  String get categoryPlumbing => 'Plomería';

  @override
  String get categoryElectrical => 'Electricidad';

  @override
  String get categoryElevator => 'Ascensor';

  @override
  String get categoryCommonAreas => 'Áreas comunes';

  @override
  String get categoryStructural => 'Estructura';

  @override
  String get categorySecurity => 'Seguridad';

  @override
  String get categoryOther => 'Otro';

  @override
  String get priorityLow => 'Baja';

  @override
  String get priorityMedium => 'Media';

  @override
  String get priorityHigh => 'Alta';

  @override
  String get priorityUrgent => 'Urgente';

  @override
  String get statusOpen => 'Abierta';

  @override
  String get statusInProgress => 'En Progreso';

  @override
  String get statusResolved => 'Resuelta';

  @override
  String get statusClosed => 'Cerrada';

  @override
  String adminStatsOpen(int count) {
    return 'Abiertas: $count';
  }

  @override
  String adminStatsInProgress(int count) {
    return 'En progreso: $count';
  }

  @override
  String adminStatsUrgent(int count) {
    return 'Urgentes: $count';
  }

  @override
  String get filterOpen => 'Abiertas';

  @override
  String get filterInProgress => 'En Progreso';

  @override
  String get filterResolved => 'Resueltas';

  @override
  String get noRequestsFilter => 'No hay solicitudes con este filtro';

  @override
  String get noRequestsRegistered => 'No tienes solicitudes registradas';

  @override
  String get newRequestTitle => 'Nueva Solicitud';

  @override
  String get categoryLabel => 'Categoría';

  @override
  String get priorityLabel => 'Prioridad';

  @override
  String get titleLabel => 'Título';

  @override
  String get titleHint => 'Ej: Fuga de agua en la cocina';

  @override
  String get titleRequired => 'Ingrese un título';

  @override
  String get descriptionLabel => 'Descripción';

  @override
  String get descriptionHint => 'Describa el problema con detalle...';

  @override
  String get descriptionRequired => 'Ingrese una descripción';

  @override
  String get attachPhotos => 'Adjuntar fotos (próximamente)';

  @override
  String get sendRequestButton => 'Enviar Solicitud';

  @override
  String get requestSentSuccess => 'Solicitud enviada exitosamente';

  @override
  String get statusLabel => 'Estado';

  @override
  String get assignToLabel => 'Asignar a';

  @override
  String get assignToHint => 'Nombre del responsable';

  @override
  String get adminNotesLabel => 'Notas de administración';

  @override
  String get adminNotesHint => 'Observaciones internas...';

  @override
  String get saveButton => 'GUARDAR';

  @override
  String get requestUpdatedSuccess => 'Solicitud actualizada';

  @override
  String assignedTo(String name) {
    return 'Asignado a: $name';
  }

  @override
  String get votingAdminTitle => 'Gestión de Votaciones';

  @override
  String get votingResidentTitle => 'Votaciones';

  @override
  String get tabActive => 'Activas';

  @override
  String get tabClosed => 'Cerradas';

  @override
  String get tabUpcoming => 'Próximas';

  @override
  String get noActivePolls => 'No hay votaciones activas';

  @override
  String get noClosedPolls => 'No hay votaciones cerradas';

  @override
  String get noUpcomingPolls => 'No hay votaciones próximas';

  @override
  String get createPollTitle => 'Crear Nueva Votación';

  @override
  String get pollTitleLabel => 'Título';

  @override
  String get pollDescriptionLabel => 'Descripción';

  @override
  String get optionsLabel => 'Opciones';

  @override
  String optionNumber(int number) {
    return 'Opción $number';
  }

  @override
  String get addOptionButton => 'Agregar opción';

  @override
  String get startDateLabel => 'Inicio';

  @override
  String get endDateLabel => 'Fin';

  @override
  String get createPollButton => 'CREAR VOTACIÓN';

  @override
  String get voteRegisteredSuccess => 'Voto registrado exitosamente';

  @override
  String get pollCreatedSuccess => 'Votación creada exitosamente';

  @override
  String get pollStatusActive => 'Activa';

  @override
  String get pollStatusClosed => 'Cerrada';

  @override
  String get pollStatusUpcoming => 'Próximamente';

  @override
  String pollStartsOn(String date) {
    return 'Inicia: $date';
  }

  @override
  String pollEndsOn(String date) {
    return 'Finaliza: $date';
  }

  @override
  String get voteButton => 'VOTAR';

  @override
  String voteResults(int votes, String percentage) {
    return '$votes ($percentage%)';
  }

  @override
  String participationActive(int count) {
    return '$count/50 residentes han votado';
  }

  @override
  String get closePollButton => 'Cerrar votación';

  @override
  String participationClosed(int count) {
    return '$count/50 residentes votaron';
  }

  @override
  String get emergencyTitle => 'Contactos de Emergencia';

  @override
  String get emergencyBanner =>
      'En caso de emergencia, contacte inmediatamente';

  @override
  String get emergencySection => 'Emergencias';

  @override
  String get buildingSection => 'Edificio';

  @override
  String get technicalSection => 'Servicios Técnicos';

  @override
  String callingTo(String name) {
    return 'Llamando a $name...';
  }

  @override
  String get available24h => '24h';

  @override
  String get reportsAdminTitle => 'Panel de Reportes Reside';

  @override
  String get reportsResidentTitle => 'Mis Estadísticas';

  @override
  String get reportsAdminHeading => 'Resumen de Gestión';

  @override
  String get reportsResidentHeading => 'Tu Actividad en el Condominio';

  @override
  String get expenseBreakdownTitle => 'Distribución de Gastos';

  @override
  String get monthlyCollectionTitle => 'Recaudación Mensual';

  @override
  String get chatbotTopicsTitle => 'Temas más consultados al Chatbot';

  @override
  String get chatLogsTitle => 'Últimos reportes vía Chatbot';

  @override
  String get collectedLabel => 'Cobrado';

  @override
  String get pendingLegendLabel => 'Pendiente';

  @override
  String get resolvedByAI => 'Resuelto por IA';

  @override
  String get escalatedToBoard => 'Escalado a Junta';

  @override
  String get adminInsight =>
      'Sugerencia: El volumen de dudas sobre \'Pagos\' indica que el botón de ayuda debe ser más visible.';

  @override
  String get residentInsight =>
      'Gracias por tu solvencia. Esto permite el mantenimiento de las áreas comunes.';

  @override
  String get notificationMessage =>
      'Tienes un nuevo anuncio: Corte de agua programado';

  @override
  String get navHome => 'Inicio';

  @override
  String get navPayments => 'Pagos';

  @override
  String get navCommunity => 'Comunidad';

  @override
  String get navServices => 'Servicios';

  @override
  String get navProfile => 'Perfil';

  @override
  String get paymentsHubTitle => 'Pagos';

  @override
  String get reportPayment => 'Reportar Pago';

  @override
  String get reportPaymentDesc => 'Registra un nuevo pago realizado';

  @override
  String get paymentHistoryTitle => 'Historial de Pagos';

  @override
  String get paymentHistoryDesc => 'Consulta tus pagos anteriores';

  @override
  String get communityHubTitle => 'Comunidad';

  @override
  String get announcementsDesc => 'Noticias y comunicados del edificio';

  @override
  String get votingDesc => 'Participa en las decisiones';

  @override
  String get rulesDesc => 'Reglamento de convivencia';

  @override
  String get visitorsDesc => 'Gestiona el acceso de visitantes';

  @override
  String get servicesHubTitle => 'Servicios';

  @override
  String get maintenanceDesc => 'Reporta problemas o fallas';

  @override
  String get reservationsDesc => 'Reserva áreas comunes';

  @override
  String get emergencyDesc => 'Números de contacto importantes';

  @override
  String get greetingMorning => 'Buenos días';

  @override
  String get greetingAfternoon => 'Buenas tardes';

  @override
  String get greetingEvening => 'Buenas noches';

  @override
  String get quickActions => 'Acciones Rápidas';

  @override
  String get recentActivity => 'Actividad Reciente';

  @override
  String get viewAll => 'Ver todo';

  @override
  String get chatbot => 'Chatbot';

  @override
  String get reserve => 'Reservar';

  @override
  String get report => 'Reportar';

  @override
  String get activityPaymentApproved => 'Pago aprobado';

  @override
  String get activityReservationSent => 'Reserva enviada';

  @override
  String get activityNewAnnouncement => 'Nuevo anuncio';

  @override
  String get activityPaymentAmount => '\$150.00';

  @override
  String get activityReservationArea => 'Parrillera Central';

  @override
  String get activityAnnouncementText => 'Corte de agua programado';

  @override
  String daysAgo(int count) {
    return 'Hace $count días';
  }

  @override
  String get adminQuickMorosos => 'Morosos';

  @override
  String get adminQuickSolicitudes => 'Solicitudes';

  @override
  String get adminQuickAnuncios => 'Anuncios';

  @override
  String get adminQuickReportes => 'Reportes';

  @override
  String get adminActivityPaymentReceived => 'Pago recibido';

  @override
  String get adminActivityPaymentApt => 'Apto 3-A - Transferencia';

  @override
  String get adminActivityNewRequest => 'Nueva solicitud';

  @override
  String get adminActivityRequestText => 'Fuga de agua - Apto 7-C';

  @override
  String get adminActivityPollClosed => 'Votación cerrada';

  @override
  String get adminActivityPollText => 'Pintura de fachada - 38 votos';

  @override
  String get adminBadge => 'Administrador';
}
