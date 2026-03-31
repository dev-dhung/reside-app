import 'package:prototype/domain/entities/poll.dart';

final mockPolls = <Poll>[
  Poll(
    id: 'poll-001',
    title: 'Instalacion de camaras en estacionamiento',
    description:
        'Se propone la instalacion de un sistema de camaras de seguridad '
        'en el area de estacionamiento. El costo estimado es de \$1,200 '
        'que se distribuiria entre todos los apartamentos.',
    options: const [
      PollOption(id: 'opt-001a', label: 'A favor', votes: 28, percentage: 62.2),
      PollOption(id: 'opt-001b', label: 'En contra', votes: 12, percentage: 26.7),
      PollOption(id: 'opt-001c', label: 'Abstencion', votes: 5, percentage: 11.1),
    ],
    startDate: DateTime(2026, 3, 20),
    endDate: DateTime(2026, 4, 5),
    status: PollStatus.active,
    totalVotes: 45,
    userVote: null,
  ),
  Poll(
    id: 'poll-002',
    title: 'Horario de piscina fin de semana',
    description:
        'Seleccione el horario que prefiere para el uso de la piscina '
        'durante los fines de semana.',
    options: const [
      PollOption(id: 'opt-002a', label: '8:00 AM - 6:00 PM', votes: 14, percentage: 36.8),
      PollOption(id: 'opt-002b', label: '9:00 AM - 8:00 PM', votes: 16, percentage: 42.1),
      PollOption(id: 'opt-002c', label: '10:00 AM - 9:00 PM', votes: 8, percentage: 21.1),
    ],
    startDate: DateTime(2026, 3, 22),
    endDate: DateTime(2026, 4, 3),
    status: PollStatus.active,
    totalVotes: 38,
    userVote: 'opt-002b',
  ),
  Poll(
    id: 'poll-003',
    title: 'Pintura de fachada',
    description:
        'Votacion para aprobar la pintura de la fachada principal del '
        'edificio. El presupuesto presentado es de \$3,500.',
    options: const [
      PollOption(id: 'opt-003a', label: 'Aprobar', votes: 38, percentage: 73.1),
      PollOption(id: 'opt-003b', label: 'Rechazar', votes: 14, percentage: 26.9),
    ],
    startDate: DateTime(2026, 2, 15),
    endDate: DateTime(2026, 3, 1),
    status: PollStatus.closed,
    totalVotes: 52,
    userVote: 'opt-003a',
  ),
  Poll(
    id: 'poll-004',
    title: 'Proveedor de internet comunitario',
    description:
        'Se evaluara la contratacion de un servicio de internet comunitario '
        'para las areas comunes del edificio (lobby, salon de fiestas, piscina).',
    options: const [
      PollOption(id: 'opt-004a', label: 'Proveedor A - \$80/mes', votes: 0, percentage: 0),
      PollOption(id: 'opt-004b', label: 'Proveedor B - \$65/mes', votes: 0, percentage: 0),
      PollOption(id: 'opt-004c', label: 'No contratar', votes: 0, percentage: 0),
    ],
    startDate: DateTime(2026, 4, 10),
    endDate: DateTime(2026, 4, 25),
    status: PollStatus.upcoming,
    totalVotes: 0,
    userVote: null,
  ),
];
