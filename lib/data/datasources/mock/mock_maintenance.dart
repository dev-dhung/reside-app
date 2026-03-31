import 'package:prototype/domain/entities/maintenance_request.dart';

final mockMaintenanceRequests = <MaintenanceRequest>[
  MaintenanceRequest(
    id: 'mnt-001',
    residentId: 'usr-001',
    apartment: '4-B',
    title: 'Fuga de agua en la cocina',
    description:
        'Se presenta una fuga de agua debajo del fregadero de la cocina. '
        'El goteo es constante y ha comenzado a acumularse agua en el piso. '
        'Se requiere revisión urgente de la tubería.',
    category: RequestCategory.plumbing,
    priority: RequestPriority.high,
    status: RequestStatus.inProgress,
    createdAt: DateTime(2026, 3, 25, 9, 30),
    assignedTo: 'Carlos Méndez',
    adminNotes: 'Se envió plomero el 26/03. Pendiente por repuesto.',
  ),
  MaintenanceRequest(
    id: 'mnt-002',
    residentId: 'usr-002',
    apartment: '2-A',
    title: 'Ascensor detenido en piso 3',
    description:
        'El ascensor de la torre A se quedó detenido en el piso 3 y no '
        'responde a los botones de llamada. La puerta permanece cerrada '
        'y no hay personas atrapadas dentro.',
    category: RequestCategory.elevator,
    priority: RequestPriority.urgent,
    status: RequestStatus.open,
    createdAt: DateTime(2026, 3, 28, 14, 15),
  ),
  MaintenanceRequest(
    id: 'mnt-003',
    residentId: 'usr-003',
    apartment: '6-C',
    title: 'Luz fundida en estacionamiento',
    description:
        'La luminaria del puesto de estacionamiento 12 se encuentra fundida '
        'desde hace varios días. La zona queda muy oscura en las noches, '
        'lo que representa un riesgo de seguridad.',
    category: RequestCategory.electrical,
    priority: RequestPriority.medium,
    status: RequestStatus.resolved,
    createdAt: DateTime(2026, 3, 20, 11, 0),
    resolvedAt: DateTime(2026, 3, 22, 16, 30),
    assignedTo: 'José Ramírez',
    adminNotes: 'Se reemplazó luminaria LED. Trabajo completado.',
  ),
  MaintenanceRequest(
    id: 'mnt-004',
    residentId: 'usr-001',
    apartment: '4-B',
    title: 'Bomba de agua con ruido extraño',
    description:
        'La bomba de agua del edificio emite un ruido metálico fuerte '
        'durante las horas de la madrugada. Varios vecinos han reportado '
        'que el sonido les impide descansar adecuadamente.',
    category: RequestCategory.plumbing,
    priority: RequestPriority.medium,
    status: RequestStatus.open,
    createdAt: DateTime(2026, 3, 27, 7, 45),
  ),
  MaintenanceRequest(
    id: 'mnt-005',
    residentId: 'usr-004',
    apartment: '1-A',
    title: 'Grieta en pared del pasillo piso 1',
    description:
        'Se observa una grieta diagonal en la pared del pasillo del primer '
        'piso, cerca de la entrada principal. La grieta mide aproximadamente '
        '50 cm y parece haber crecido en las últimas semanas.',
    category: RequestCategory.structural,
    priority: RequestPriority.high,
    status: RequestStatus.inProgress,
    createdAt: DateTime(2026, 3, 22, 10, 20),
    assignedTo: 'Ing. Pérez',
    adminNotes: 'Ingeniero estructural evaluará el 01/04.',
  ),
  MaintenanceRequest(
    id: 'mnt-006',
    residentId: 'usr-005',
    apartment: '3-D',
    title: 'Cámara de seguridad desconectada',
    description:
        'La cámara de seguridad ubicada en la entrada del estacionamiento '
        'del sótano no está funcionando. La pantalla del monitor muestra '
        'señal perdida desde el pasado viernes.',
    category: RequestCategory.security,
    priority: RequestPriority.low,
    status: RequestStatus.closed,
    createdAt: DateTime(2026, 3, 15, 8, 0),
    resolvedAt: DateTime(2026, 3, 18, 12, 0),
    assignedTo: 'TecnoSeg C.A.',
    adminNotes: 'Se reconectó cableado y se verificó funcionamiento.',
  ),
];
