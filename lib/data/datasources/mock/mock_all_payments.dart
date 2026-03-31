import 'package:prototype/domain/entities/payment.dart';

/// Extended payment list including all apartments (for admin view).
/// The first 4 entries match the existing mockPayments from mock_data.dart.
final mockAllPayments = <Payment>[
  // --- User usr-001, Apt 4-B (same as mockPayments) ---
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

  // --- User usr-002, Apt 2-A ---
  Payment(
    id: 'pay-005',
    userId: 'usr-002',
    amount: 150.00,
    reference: 'REF-20260302',
    method: PaymentMethod.transfer,
    status: PaymentStatus.approved,
    date: DateTime(2026, 3, 2),
    description: 'Condominio Marzo 2026',
  ),

  // --- User usr-003, Apt 6-C ---
  Payment(
    id: 'pay-006',
    userId: 'usr-003',
    amount: 150.00,
    reference: 'REF-20260305',
    method: PaymentMethod.mobilePay,
    status: PaymentStatus.pending,
    date: DateTime(2026, 3, 5),
    description: 'Condominio Marzo 2026',
  ),

  // --- User usr-004, Apt 1-D ---
  Payment(
    id: 'pay-007',
    userId: 'usr-004',
    amount: 150.00,
    reference: 'REF-20260310',
    method: PaymentMethod.zelle,
    status: PaymentStatus.approved,
    date: DateTime(2026, 3, 10),
    description: 'Condominio Marzo 2026',
  ),

  // --- User usr-005, Apt 3-A ---
  Payment(
    id: 'pay-008',
    userId: 'usr-005',
    amount: 150.00,
    reference: 'REF-20260318',
    method: PaymentMethod.cash,
    status: PaymentStatus.rejected,
    date: DateTime(2026, 3, 18),
    description: 'Condominio Marzo 2026',
  ),

  // --- User usr-006, Apt 5-B ---
  Payment(
    id: 'pay-009',
    userId: 'usr-006',
    amount: 225.00,
    reference: 'REF-20260320',
    method: PaymentMethod.transfer,
    status: PaymentStatus.approved,
    date: DateTime(2026, 3, 20),
    description: 'Condominio Marzo 2026 + Cuota extraordinaria',
  ),
];

/// Map of userId to apartment for display in admin view.
const userApartmentMap = <String, String>{
  'usr-001': '4-B',
  'usr-002': '2-A',
  'usr-003': '6-C',
  'usr-004': '1-D',
  'usr-005': '3-A',
  'usr-006': '5-B',
};
