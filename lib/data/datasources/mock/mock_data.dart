import 'package:prototype/domain/entities/user.dart';
import 'package:prototype/domain/entities/payment.dart';
import 'package:prototype/domain/entities/reservation.dart';
import 'package:prototype/domain/entities/announcement.dart';
import 'package:prototype/domain/entities/rule.dart';
import 'package:prototype/domain/entities/common_area.dart';
import 'package:prototype/domain/entities/metric.dart';

// ---------------------------------------------------------------------------
// Current user
// ---------------------------------------------------------------------------

final mockCurrentUser = User(
  id: 'usr-001',
  name: 'María García',
  email: 'maria.garcia@email.com',
  phone: '+58 412-5551234',
  apartment: '4-B',
  tower: 'Residencias La Molienda',
  isAdmin: false,
  isSolvent: true,
);

// ---------------------------------------------------------------------------
// Payments
// ---------------------------------------------------------------------------

final mockPayments = <Payment>[
  Payment(
    id: 'pay-001',
    userId: 'usr-001',
    amount: 150.00,
    reference: 'REF-20260301',
    method: PaymentMethod.transfer,
    status: PaymentStatus.approved,
    date: DateTime(2026, 3, 1),
    description: 'Condominio Marzo 2026',
  ),
  Payment(
    id: 'pay-002',
    userId: 'usr-001',
    amount: 150.00,
    reference: 'REF-20260201',
    method: PaymentMethod.mobilePay,
    status: PaymentStatus.approved,
    date: DateTime(2026, 2, 1),
    description: 'Condominio Febrero 2026',
  ),
  Payment(
    id: 'pay-003',
    userId: 'usr-001',
    amount: 150.00,
    reference: 'REF-20260401',
    method: PaymentMethod.zelle,
    status: PaymentStatus.pending,
    date: DateTime(2026, 3, 28),
    description: 'Condominio Abril 2026',
  ),
  Payment(
    id: 'pay-004',
    userId: 'usr-001',
    amount: 75.00,
    reference: 'REF-20260315',
    method: PaymentMethod.cash,
    status: PaymentStatus.rejected,
    date: DateTime(2026, 3, 15),
    description: 'Cuota extraordinaria',
  ),
];

// ---------------------------------------------------------------------------
// Common areas
// ---------------------------------------------------------------------------

final mockAreas = <CommonArea>[
  const CommonArea(
    id: 'area-001',
    name: 'Parrillera Central',
    iconName: 'outdoor_grill',
    status: AreaStatus.available,
    depositAmount: 50.0,
  ),
  const CommonArea(
    id: 'area-002',
    name: 'Salón de Fiestas',
    iconName: 'celebration',
    status: AreaStatus.occupied,
    statusDetail: 'Reservado hasta las 10:00 PM',
    depositAmount: 100.0,
  ),
  const CommonArea(
    id: 'area-003',
    name: 'Piscina',
    iconName: 'pool',
    status: AreaStatus.maintenance,
    statusDetail: 'Mantenimiento programado hasta el 05/04',
  ),
  const CommonArea(
    id: 'area-004',
    name: 'Cancha de Tenis',
    iconName: 'sports_tennis',
    status: AreaStatus.available,
    depositAmount: 30.0,
  ),
];

// ---------------------------------------------------------------------------
// Reservations
// ---------------------------------------------------------------------------

final mockReservations = <Reservation>[
  Reservation(
    id: 'res-001',
    userId: 'usr-001',
    areaId: 'area-001',
    areaName: 'Parrillera Central',
    date: DateTime(2026, 4, 5, 14, 0),
    status: ReservationStatus.approved,
    guestCount: 12,
    notes: 'Cumpleaños familiar',
  ),
  Reservation(
    id: 'res-002',
    userId: 'usr-001',
    areaId: 'area-002',
    areaName: 'Salón de Fiestas',
    date: DateTime(2026, 4, 12, 18, 0),
    status: ReservationStatus.pending,
    guestCount: 30,
    notes: 'Reunión de vecinos',
  ),
];

// ---------------------------------------------------------------------------
// Announcements
// ---------------------------------------------------------------------------

final mockAnnouncements = <Announcement>[
  Announcement(
    id: 'ann-001',
    title: 'Mantenimiento de ascensores',
    content:
        'Se informa que el día 02/04 se realizará mantenimiento preventivo '
        'en los ascensores de todas las torres. El servicio estará '
        'interrumpido de 8:00 AM a 12:00 PM.',
    date: DateTime(2026, 3, 28),
    priority: AnnouncementPriority.high,
    author: 'Administración',
  ),
  Announcement(
    id: 'ann-002',
    title: 'Corte de agua programado',
    content:
        'La empresa hidrológica ha notificado un corte de agua programado '
        'para el día 03/04 desde las 6:00 AM hasta las 2:00 PM. '
        'Se recomienda almacenar agua con anticipación.',
    date: DateTime(2026, 3, 27),
    priority: AnnouncementPriority.urgent,
    author: 'Administración',
  ),
  Announcement(
    id: 'ann-003',
    title: 'Fumigación de áreas comunes',
    content:
        'El próximo sábado 05/04 se realizará fumigación general en todas '
        'las áreas comunes. Se solicita mantener mascotas dentro de los '
        'apartamentos durante el proceso.',
    date: DateTime(2026, 3, 25),
    priority: AnnouncementPriority.normal,
    author: 'Administración',
  ),
];

// ---------------------------------------------------------------------------
// Rules
// ---------------------------------------------------------------------------

const mockRules = <Rule>[
  Rule(
    id: 'rule-001',
    category: 'Áreas comunes',
    detail: 'Las áreas comunes deben reservarse con al menos 48 horas de '
        'anticipación. El horario de uso es de 8:00 AM a 10:00 PM.',
    iconName: 'meeting_room',
  ),
  Rule(
    id: 'rule-002',
    category: 'Desechos',
    detail: 'Los desechos deben depositarse en los contenedores asignados '
        'en los horarios establecidos: 7:00 AM y 7:00 PM.',
    iconName: 'delete',
  ),
  Rule(
    id: 'rule-003',
    category: 'Ruidos',
    detail: 'El horario de silencio es de 10:00 PM a 7:00 AM. '
        'Actividades ruidosas deben limitarse a los horarios permitidos.',
    iconName: 'volume_off',
  ),
  Rule(
    id: 'rule-004',
    category: 'Mascotas',
    detail: 'Las mascotas deben circular en áreas comunes con correa y bajo '
        'supervisión del propietario. Es obligatorio recoger los desechos.',
    iconName: 'pets',
  ),
  Rule(
    id: 'rule-005',
    category: 'Estacionamiento',
    detail: 'Cada apartamento tiene asignado un puesto de estacionamiento. '
        'No se permite estacionar en puestos ajenos o áreas de circulación.',
    iconName: 'local_parking',
  ),
];

// ---------------------------------------------------------------------------
// Admin metrics
// ---------------------------------------------------------------------------

const mockAdminMetrics = <MetricCard>[
  MetricCard(
    title: 'Morosidad',
    value: '12%',
    subtitle: '6 apartamentos pendientes',
    trend: 'down',
  ),
  MetricCard(
    title: 'Fondo de Reserva',
    value: '\$2,450',
    subtitle: 'Disponible actualmente',
    trend: 'up',
  ),
  MetricCard(
    title: 'Resolución Chatbot',
    value: '92%',
    subtitle: 'Consultas resueltas automáticamente',
    trend: 'up',
  ),
];

// ---------------------------------------------------------------------------
// Resident metrics
// ---------------------------------------------------------------------------

const mockResidentMetrics = <MetricCard>[
  MetricCard(
    title: 'Consumo de Agua',
    value: 'Moderado',
    subtitle: 'Dentro del promedio del edificio',
    trend: 'stable',
  ),
  MetricCard(
    title: 'Puntualidad de Pago',
    value: 'Excelente',
    subtitle: '12 meses consecutivos al día',
    trend: 'up',
  ),
];

// ---------------------------------------------------------------------------
// Chatbot topics
// ---------------------------------------------------------------------------

const mockChatbotTopics = <ChatbotMetric>[
  ChatbotMetric(topic: 'Pagos', percentage: 85),
  ChatbotMetric(topic: 'Servicios', percentage: 60),
  ChatbotMetric(topic: 'Averías', percentage: 45),
];

// ---------------------------------------------------------------------------
// Chat logs
// ---------------------------------------------------------------------------

final mockChatLogs = <ChatLog>[
  ChatLog(
    apartment: '4-B',
    topic: 'Consulta de saldo',
    resolution: 'Resuelta',
    date: DateTime(2026, 3, 28, 10, 15),
  ),
  ChatLog(
    apartment: '2-A',
    topic: 'Reporte de avería',
    resolution: 'Derivada a administración',
    date: DateTime(2026, 3, 27, 14, 30),
  ),
  ChatLog(
    apartment: '6-C',
    topic: 'Reserva de área común',
    resolution: 'Resuelta',
    date: DateTime(2026, 3, 27, 9, 45),
  ),
];

// ---------------------------------------------------------------------------
// Monthly payments
// ---------------------------------------------------------------------------

const mockMonthlyPayments = <PaymentMetric>[
  PaymentMetric(month: 'Oct', collected: 4500, pending: 600),
  PaymentMetric(month: 'Nov', collected: 4800, pending: 300),
  PaymentMetric(month: 'Dic', collected: 4200, pending: 900),
  PaymentMetric(month: 'Ene', collected: 4700, pending: 400),
  PaymentMetric(month: 'Feb', collected: 4900, pending: 200),
  PaymentMetric(month: 'Mar', collected: 4600, pending: 500),
];

// ---------------------------------------------------------------------------
// Expense breakdown
// ---------------------------------------------------------------------------

const mockExpenseBreakdown = <ExpenseBreakdown>[
  ExpenseBreakdown(category: 'Mantenimiento', amount: 1200, percentage: 30),
  ExpenseBreakdown(category: 'Seguridad', amount: 1000, percentage: 25),
  ExpenseBreakdown(category: 'Limpieza', amount: 800, percentage: 20),
  ExpenseBreakdown(category: 'Servicios', amount: 600, percentage: 15),
  ExpenseBreakdown(category: 'Fondo de Reserva', amount: 400, percentage: 10),
];

// ---------------------------------------------------------------------------
// Team members
// ---------------------------------------------------------------------------

const mockTeamMembers = <Map<String, String>>[
  {
    'name': 'Wendy Díaz',
    'role': 'Redactor técnico',
    'avatar': 'WD',
    'image': 'assets/images/empty.jpg',
    'qr_image': 'assets/images/empty.jpg',
  },
  {
    'name': 'Diego Hung',
    'role': 'Desarrollador Full stack',
    'avatar': 'DH',
    'image': 'assets/images/me.png',
    'qr_image': 'assets/images/qr_dhung.png',
  },
  {
    'name': 'Yonahiderly Rosales',
    'role': 'Diseñador UI/UX',
    'avatar': 'YR',
    'image': 'assets/images/empty.jpg',
    'qr_image': 'assets/images/qr_yonahiderly.jpeg',
  },
  {
    'name': 'Gabriel Sanabria',
    'role': 'Investigador UX',
    'avatar': 'GS',
    'image': 'assets/images/gabo.jpeg',
    'qr_image': 'assets/images/qr_gabo.jpeg',
  },
];

// ---------------------------------------------------------------------------
// Tutor
// ---------------------------------------------------------------------------

const mockTutor = <String, String>{
  'name': 'Walter Carrasquero',
  'role': 'Tutor Académico',
  'avatar': 'WC',
  'titulo': 'Ing. de Sistemas',
  'phone': '0424-1938899',
  'image': 'assets/images/unexca.jpg',
};
