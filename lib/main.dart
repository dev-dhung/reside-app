import 'package:flutter/material.dart';

void main() => runApp(SigraApp());

class SigraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIGRA - La Molienda',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF1A237E),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Color(0xFFFFA000),
        ),
        // ESTA ES LA PARTE CLAVE:
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1A237E), // Fondo azul marino
          foregroundColor: Colors.white, // Todo el texto e iconos en blanco
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ), // Icono de atrás en blanco
        ),
      ),
      home: LoginScreen(),
    );
  }
}

// --- PANTALLA DE LOGIN ---
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Evita que el teclado mueva los elementos de forma extraña
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // Capa 1: Formulario Centrado
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.apartment, size: 80, color: Color(0xFF1A237E)),
                  Text(
                    "SIGRA",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  Text("Residencias La Molienda"),
                  SizedBox(height: 40),
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Apartamento",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Contraseña",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF1A237E),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      ),
                      child: Text(
                        "INGRESAR",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistroScreen()),
                    ),
                    child: Text("¿No tienes cuenta? Regístrate aquí"),
                  ),
                ],
              ),
            ),
          ),

          // Capa 2: Pie de página anclado abajo a la izquierda
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreditosScreen()),
              ),
              child: Text(
                "Desarrollado por...",
                style: TextStyle(
                  color: Colors.blue[800], // Azul de link
                  fontStyle: FontStyle.italic, // Cursiva
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- PANTALLA PRINCIPAL (DASHBOARD) ---
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variable de estado para alternar vistas
  bool _esAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_esAdmin ? "SIGRA - Gestión Admin" : "SIGRA - Mi tablero"),
        backgroundColor: Color(0xFF1A237E),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.notifications_none, size: 28),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Tienes un nuevo anuncio: Corte de agua programado",
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: 12,
                top: 12,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(minWidth: 14, minHeight: 14),
                  child: Text(
                    '1',
                    style: TextStyle(color: Colors.white, fontSize: 8),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.account_circle, size: 30),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PerfilScreen()),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildRoleSelector(), // El switch para tu presentación
          SizedBox(height: 20),
          // Cambia la tarjeta principal según el rol
          _esAdmin ? _buildAdminDashboard() : _buildStatusCard(),
          SizedBox(height: 20),
          Text(
            _esAdmin
                ? "Panel de Control Administrativo"
                : "Servicios y Gestión",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _buildMenuGrid(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatBotScreen()),
          );
        },
        child: Icon(Icons.smart_toy, color: Colors.white),
        backgroundColor: Color(0xFFFFA000),
      ),
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildRoleSelector() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ToggleButtons(
          isSelected: [!_esAdmin, _esAdmin],
          onPressed: (index) {
            setState(() {
              _esAdmin = index == 1;
            });
          },
          borderRadius: BorderRadius.circular(10),
          selectedColor: Colors.white,
          fillColor: _esAdmin ? Color(0xFFFFA000) : Color(0xFF1A237E),
          constraints: BoxConstraints(minHeight: 40, minWidth: 100),
          children: [Text("Modo Vecino"), Text("Modo Admin")],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Estado de Cuenta", style: TextStyle(color: Colors.white70)),
            SizedBox(height: 10),
            Text(
              "\$45.00",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Pendiente - Enero 2026",
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminDashboard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFA000), Color(0xFFFF6F00)],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recaudación Total Mensual",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
            Text(
              "\$12,450.80",
              style: TextStyle(
                color: Colors.white,
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Caja de Residencia La Molienda",
              style: TextStyle(color: Colors.white60),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildGestureItem(context, Icons.payment, "Pagar", PaymentScreen()),
        _buildGestureItem(
          context,
          Icons.event_available,
          "Reservas",
          ReservasScreen(),
        ),
        _buildGestureItem(
          context,
          Icons.campaign,
          "Anuncios",
          AnunciosScreen(),
        ),
        _buildGestureItem(
          context,
          Icons.description,
          "Normativa",
          NormativaScreen(),
        ),
        _buildGestureItem(
          context,
          Icons.analytics,
          "Reportes",
          ReportesScreen(soyAdmin: _esAdmin), // Pasamos el rol
        ),
      ],
    );
  }

  Widget _buildGestureItem(
    BuildContext context,
    IconData icon,
    String label,
    Widget screen,
  ) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Color(0xFF1A237E)),
            SizedBox(height: 10),
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

// --- PANTALLA DEL CHATBOT INTERACTIVO ---
// --- PANTALLA DEL CHATBOT PROFESIONAL CON QUICK REPLIES ---
class ChatBotScreen extends StatefulWidget {
  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Map<String, String>> _mensajes = [
    {
      "autor": "bot",
      "texto":
          "¡Hola! Soy el asistente virtual de SIGRA. ¿En qué puedo apoyarle hoy?",
      "hora": "10:30 AM",
    },
  ];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // VARIABLE CRÍTICA: Controla el flujo de la conversación
  String _estadoActual = "inicio";

  final List<String> _quickReplies = [
    "¿Cuánto debo?",
    "Falla de agua",
    "Reservar áreas",
    "Normas de ruido",
  ];

  String _obtenerRespuestaIA(String mensaje) {
    String m = mensaje
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'[áàäâ]'), 'a')
        .replaceAll(RegExp(r'[éèëê]'), 'e')
        .replaceAll(RegExp(r'[íìïî]'), 'i')
        .replaceAll(RegExp(r'[óòöô]'), 'o')
        .replaceAll(RegExp(r'[úùüû]'), 'u');

    // --- FLUJO DE RESPUESTAS POR ESTADO (CONTEXTO) ---

    // 1. CONTEXTO: PAGOS
    if (_estadoActual == "esperando_metodos_pago") {
      if (m.contains("si") ||
          m.contains("claro") ||
          m.contains("cuales") ||
          m.contains("ver")) {
        _estadoActual = "inicio";
        return "Aceptamos: \n• Transferencia (Banesco)\n• Pago Móvil\n• Zelle\n• Efectivo en oficina.\n\nAl pagar, recuerda subir tu comprobante en el módulo 'Pagar' del menú principal.";
      } else {
        _estadoActual = "inicio";
        return "Entendido. ¿Hay alguna otra consulta en la que pueda ayudarte?";
      }
    }

    // 2. CONTEXTO: RESERVAS
    if (_estadoActual == "esperando_guia_reserva") {
      if (m.contains("si") ||
          m.contains("por favor") ||
          m.contains("guiame") ||
          m.contains("como")) {
        _estadoActual = "esperando_confirmacion_deposito";
        return "¡Perfecto! Para reservar:\n1. Ve al menú 'Reservas'.\n2. Selecciona el área (Piscina, Parrillera, etc.).\n3. Elige la fecha.\n\nNota: Algunas áreas requieren un depósito de garantía de \$20. ¿Deseas ver las normas de uso de áreas?";
      } else {
        _estadoActual = "inicio";
        return "De acuerdo. Recuerda que las reservas deben hacerse con 48h de antelación.";
      }
    }

    if (_estadoActual == "esperando_confirmacion_deposito") {
      if (m.contains("si") || m.contains("ok") || m.contains("ver")) {
        _estadoActual = "inicio";
        return "Las normas principales son: \n• No música a alto volumen.\n• Máximo 15 invitados.\n• Entrega del área limpia.\n\n¿Deseas ayuda con algo más?";
      } else {
        _estadoActual = "inicio";
        return "Entendido. ¡Que disfrutes tu evento!";
      }
    }

    // --- DETECCIÓN DE INTENCIONES (DISPARADORES) ---

    if (RegExp(r"(debo|pago|monto|deuda|dinero|cuenta|saldo)").hasMatch(m)) {
      _estadoActual = "esperando_metodos_pago";
      return "Tu apartamento (4-B) tiene un saldo pendiente de \$45.00 (Enero). ¿Deseas ver los métodos de pago disponibles?";
    }

    if (RegExp(
      r"(agua|luz|electricidad|bomba|ascensor|falla|averia|danado)",
    ).hasMatch(m)) {
      return "Hay un reporte activo sobre la bomba de agua. El personal técnico ya está trabajando en el sitio. Estiman restablecer el servicio a las 4:00 PM.";
    }

    if (RegExp(
      r"(reserva|parrillera|piscina|salon|fiesta|areas)",
    ).hasMatch(m)) {
      _estadoActual = "esperando_guia_reserva";
      return "El módulo de reservas está habilitado para la Parrillera y el Salón de Fiestas. ¿Deseas que te explique el paso a paso para reservar?";
    }

    if (RegExp(
      r"(norma|regla|ruido|multa|convivencia|perro|mascota)",
    ).hasMatch(m)) {
      return "El reglamento de La Molienda prohibe ruidos molestos después de las 8:00 PM. Las mascotas deben usar correa siempre. ¿Quieres consultar algún artículo específico?";
    }

    // Respuestas Generales
    if (m.contains("hola") || m.contains("buen"))
      return "¡Hola! Soy SIGRA-Bot. Estoy listo para ayudarte con la gestión de tu apartamento. ¿Qué necesitas?";
    if (m.contains("gracias") || m.contains("ok") || m.contains("entendido"))
      return "¡Siempre a la orden! ¿Algo más?";
    if (m.contains("ayuda") || m.contains("que haces"))
      return "Puedo informarte sobre tus pagos, registrar fallas técnicas, ayudarte con reservas o leerte las normas del edificio.";

    return "No logré procesar esa solicitud. Intenta preguntarme por 'pagos', 'fallas técnicas' o 'reservas'.";
  }

  void _enviarMensaje(String texto) {
    if (texto.isEmpty) return;
    String hora =
        "${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}";

    setState(() {
      _mensajes.add({"autor": "user", "texto": texto, "hora": hora});
      _mensajes.add({"autor": "bot", "texto": "...", "escribiendo": "true"});
    });
    _controller.clear();
    _scrollToBottom();

    Future.delayed(Duration(milliseconds: 1500), () {
      setState(() {
        _mensajes.removeWhere((m) => m["escribiendo"] == "true");
        _mensajes.add({
          "autor": "bot",
          "texto": _obtenerRespuestaIA(texto),
          "hora": hora,
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Asistente Virtual SIGRA")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.all(15),
              itemCount: _mensajes.length,
              itemBuilder: (context, index) {
                bool isBot = _mensajes[index]["autor"] == "bot";
                bool isTyping = _mensajes[index]["escribiendo"] == "true";
                return Align(
                  alignment: isBot
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: isBot
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isBot ? Colors.grey[200] : Color(0xFF1A237E),
                          borderRadius: BorderRadius.circular(18).copyWith(
                            bottomLeft: isBot
                                ? Radius.circular(0)
                                : Radius.circular(18),
                            bottomRight: isBot
                                ? Radius.circular(18)
                                : Radius.circular(0),
                          ),
                        ),
                        child: isTyping
                            ? Text(
                                "Escribiendo...",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey,
                                ),
                              )
                            : Text(
                                _mensajes[index]["texto"]!,
                                style: TextStyle(
                                  color: isBot ? Colors.black87 : Colors.white,
                                ),
                              ),
                      ),
                      Text(
                        _mensajes[index]["hora"] ?? "",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Quick Replies
          Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: _quickReplies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ActionChip(
                    backgroundColor: Colors.amber[100],
                    label: Text(
                      _quickReplies[index],
                      style: TextStyle(
                        color: Colors.amber[900],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () => _enviarMensaje(_quickReplies[index]),
                  ),
                );
              },
            ),
          ),
          // Input
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _enviarMensaje,
                    decoration: InputDecoration(
                      hintText: "Escriba un mensaje...",
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Color(0xFF1A237E),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: () => _enviarMensaje(_controller.text),
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

// --- PANTALLA DE REPORTE DE PAGOS ---
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _metodoSeleccionado = 'Transferencia';

  void _simularEnvio() {
    // Simulamos una carga
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: Text(
          "Su reporte de pago ha sido enviado con éxito a la junta de condominio. Será validado en las próximas 24 horas.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cierra el diálogo
              Navigator.pop(context); // Vuelve al Home
            },
            child: Text("ENTENDIDO"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reportar Pago"),
        backgroundColor: Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Detalles de la Transacción",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField(
              value: _metodoSeleccionado,
              decoration: InputDecoration(
                labelText: "Método de Pago",
                border: OutlineInputBorder(),
              ),
              items: ['Transferencia', 'Pago Móvil', 'Zelle', 'Efectivo'].map((
                String value,
              ) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (val) =>
                  setState(() => _metodoSeleccionado = val.toString()),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Número de Referencia",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Monto (\$)",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Simulador de subida de archivo
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 50, color: Colors.grey[600]),
                  SizedBox(height: 10),
                  Text(
                    "Adjuntar Comprobante",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A237E),
                ),
                onPressed: _simularEnvio,
                child: Text(
                  "ENVIAR REPORTE",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- PANTALLA DE RESERVAS ---
class ReservasScreen extends StatelessWidget {
  final List<Map<String, dynamic>> areas = [
    {
      "nombre": "Parrillera Central",
      "icon": Icons.outdoor_grill,
      "status": "Disponible",
    },
    {
      "nombre": "Salón de Fiestas",
      "icon": Icons.celebration,
      "status": "Ocupado este Sábado",
    },
    {
      "nombre": "Piscina / Área Social",
      "icon": Icons.pool,
      "status": "Mantenimiento",
    },
    {
      "nombre": "Cancha de Tenis",
      "icon": Icons.sports_tennis,
      "status": "Disponible",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reservas La Molienda"),
        backgroundColor: Color(0xFF1A237E),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: areas.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.only(bottom: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(0xFF1A237E),
                child: Icon(areas[index]["icon"], color: Colors.white),
              ),
              title: Text(
                areas[index]["nombre"],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(areas[index]["status"]),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: areas[index]["status"] == "Disponible"
                      ? Color(0xFFFFA000)
                      : Colors.grey,
                ),
                onPressed: areas[index]["status"] == "Disponible"
                    ? () =>
                          _mostrarSelectorFecha(context, areas[index]["nombre"])
                    : null, // Deshabilitado si no está disponible
                child: Text(
                  "RESERVAR",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _mostrarSelectorFecha(BuildContext context, String area) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)),
    ).then((fecha) {
      if (fecha != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Solicitud Enviada"),
            content: Text(
              "Tu solicitud para usar el area '$area' el día ${fecha.day}/${fecha.month}/${fecha.year} ha sido enviada a la Junta para su aprobación.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    });
  }
}

// --- PANTALLA DE ANUNCIOS (CARTELERA DIGITAL) ---
class AnunciosScreen extends StatelessWidget {
  final List<Map<String, String>> anuncios = [
    {
      "titulo": "Mantenimiento de Ascensores",
      "fecha": "29 Ene 2026",
      "contenido":
          "Se informa que el ascensor B estará fuera de servicio por mantenimiento preventivo de 8:00 AM a 12:00 PM.",
      "prioridad": "Alta",
    },
    {
      "titulo": "Corte de Agua Programado",
      "fecha": "30 Ene 2026",
      "contenido":
          "Hidrocapital realizará labores en la zona. Recomendamos tomar previsiones y llenar sus tanques internos.",
      "prioridad": "Urgente",
    },
    {
      "titulo": "Jornada de Fumigación",
      "fecha": "02 Feb 2026",
      "contenido":
          "Se realizará fumigación en áreas comunes y pasillos. Favor mantener puertas cerradas durante la mañana.",
      "prioridad": "Normal",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anuncios La Molienda"),
        backgroundColor: Color(0xFF1A237E),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: anuncios.length,
        itemBuilder: (context, index) {
          bool esUrgente = anuncios[index]["prioridad"] == "Urgente";

          return Card(
            elevation: 2,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    color: esUrgente ? Colors.red[700] : Color(0xFF1A237E),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10),
                    ),
                  ),
                  child: Text(
                    esUrgente ? "¡URGENTE!" : "AVISO",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              anuncios[index]["titulo"]!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            anuncios[index]["fecha"]!,
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      Divider(),
                      Text(
                        anuncios[index]["contenido"]!,
                        style: TextStyle(color: Colors.black87, height: 1.4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// --- PANTALLA DE NORMATIVA (REGLAMENTO INTERNO) ---
class NormativaScreen extends StatelessWidget {
  final List<Map<String, String>> reglas = [
    {
      "categoria": "Uso de Áreas Comunes",
      "detalle":
          "El horario de la piscina es de 9:00 AM a 6:00 PM. Se requiere vestimenta adecuada y no se permiten envases de vidrio.",
    },
    {
      "categoria": "Manejo de Desechos",
      "detalle":
          "La basura debe bajarse al cuarto de desechos de 6:00 PM a 9:00 PM en bolsas debidamente cerradas.",
    },
    {
      "categoria": "Ruidos y Convivencia",
      "detalle":
          "Se prohiben ruidos molestos, música a alto volumen o reparaciones civiles después de las 8:00 PM de lunes a viernes.",
    },
    {
      "categoria": "Mascotas",
      "detalle":
          "Las mascotas deben circular por áreas comunes con correa. El propietario es responsable de la limpieza inmediata de desechos.",
    },
    {
      "categoria": "Puestos de Estacionamiento",
      "detalle":
          "Cada apartamento debe usar exclusivamente su puesto asignado. El puesto de visitantes es para uso máximo de 4 horas.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Normativa La Molienda"),
        backgroundColor: Color(0xFF1A237E),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.indigo[50],
            child: Row(
              children: [
                Icon(Icons.gavel, color: Color(0xFF1A237E), size: 40),
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    "Reglamento de Convivencia vigente para el año 2026.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: reglas.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  leading: Icon(
                    Icons.bookmark_outline,
                    color: Color(0xFFFFA000),
                  ),
                  title: Text(
                    reglas[index]["categoria"]!,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: Text(
                        reglas[index]["detalle"]!,
                        style: TextStyle(color: Colors.black87, fontSize: 15),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// --- PANTALLA DE PERFIL DE USUARIO ---
class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Perfil"),
        backgroundColor: Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                color: Color(0xFF1A237E),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Propietario: Apto 4-B",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Residencias La Molienda",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _infoTile(Icons.email, "Correo", "vecino_4b@email.com"),
                  _infoTile(Icons.phone, "Teléfono", "+58 412-1234567"),
                  _infoTile(
                    Icons.verified_user,
                    "Estatus de Solvencia",
                    "SOLVENTE",
                    color: Colors.green,
                  ),
                  Divider(height: 40),
                  ListTile(
                    leading: Icon(
                      Icons.notifications_active,
                      color: Color(0xFF1A237E),
                    ),
                    title: Text("Notificaciones Push"),
                    trailing: Switch(value: true, onChanged: (val) {}),
                  ),
                  ListTile(
                    leading: Icon(Icons.security, color: Color(0xFF1A237E)),
                    title: Text("Cambiar Contraseña"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      icon: Icon(Icons.exit_to_app, color: Colors.red),
                      label: Text(
                        "CERRAR SESIÓN",
                        style: TextStyle(color: Colors.red),
                      ),
                      onPressed: () {
                        // Regresa a la pantalla de Login y quita todas las anteriores
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(
    IconData icon,
    String label,
    String value, {
    Color color = Colors.black87,
  }) {
    return ListTile(
      leading: Icon(icon, color: Color(0xFF1A237E)),
      title: Text(
        label,
        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class RegistroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registro SIGRA"),
        backgroundColor: Color(0xFF1A237E),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              "Crea tu cuenta de residente",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: "Nombre Completo",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Número de Cédula",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Torre / Apartamento",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                labelText: "Correo Electrónico",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A237E),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "REGISTRARME",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditosScreen extends StatelessWidget {
  // Lista de integrantes del equipo
  final List<Map<String, String>> integrantes = [
    {
      "nombre": "Wendy Díaz",
      "rol": "Redactor técnico",
      "imagen": "https://i.ibb.co/L5gqX1r/avatar-1.png",
      "qr_imagen": "https://i.ibb.co/C0wR4d2/qr-placeholder.png",
    },
    {
      "nombre": "Diego Hung",
      "rol": "Desarrollador Full stack",
      "imagen": "https://i.ibb.co/S68v4G7/avatar-2.png",
      "qr_imagen": "assets/images/qr_dhung.png",
    },
    {
      "nombre": "Yonahiderly Rosales",
      "rol": "Diseñador UI/UX",
      "imagen": "https://i.ibb.co/P4w8h5p/avatar-3.png",
      "qr_imagen": "https://i.ibb.co/C0wR4d2/qr-placeholder.png",
    },
    {
      "nombre": "Gabriel Sanabria",
      "rol": "Investigador UX",
      "imagen": "assets/images/gabo.jpeg",
      "qr_imagen": "assets/images/qr_gabo.jpeg",
    },
  ];

  final Map<String, String> tutor = {
    "nombre": "Walter Carrasquero",
    "rol": "Tutor Académico",
    "titulo": "Ing. de Sistemas",
    "telf": "0424-1938899",
    "imagen": "assets/images/unexca.jpg",
  };

  // --- FUNCIÓN CLAVE PARA CARGAR IMÁGENES DINÁMICAMENTE ---
  ImageProvider _configurarImagen(String ruta) {
    if (ruta.startsWith('http')) {
      return NetworkImage(ruta);
    } else {
      return AssetImage(ruta);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Equipo de Desarrollo",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A237E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Integrantes del Equipo",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: integrantes.length,
                    itemBuilder: (context, index) {
                      return _buildIntegranteCard(context, integrantes[index]);
                    },
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Tutor Académico",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: _configurarImagen(
                              tutor["imagen"]!,
                            ),
                            backgroundColor: Colors.grey[200],
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tutor["nombre"]!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  tutor["rol"]!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  tutor["titulo"]!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  tutor["telf"]!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            color: Colors.grey[100],
            child: Center(
              child: Text(
                "© 2026 UNEXCA",
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntegranteCard(
    BuildContext context,
    Map<String, String> integrante,
  ) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                "Perfil de ${integrante["nombre"]}",
                textAlign: TextAlign.center,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ajuste para el QR
                  Image(
                    image: _configurarImagen(integrante["qr_imagen"]!),
                    width: 200,
                    height: 200,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 200),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Escanea para ver su perfil",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cerrar"),
                ),
              ],
            );
          },
        );
      },
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 40,
              backgroundImage: _configurarImagen(integrante["imagen"]!),
              backgroundColor: Colors.grey[200],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                integrante["nombre"]!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black87,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                integrante["rol"]!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class ReportesScreen extends StatelessWidget {
  final bool soyAdmin;

  ReportesScreen({this.soyAdmin = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(soyAdmin ? "Panel de Reportes SIGRA" : "Mis Estadísticas"),
        backgroundColor: Color(0xFF1A237E),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            soyAdmin
                ? "Resumen de Gestión La Molienda"
                : "Tu Actividad en el Condominio",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E),
            ),
          ),
          SizedBox(height: 20),

          // --- SECCIÓN DE TARJETAS SEGÚN ROL ---
          if (soyAdmin) ...[
            _buildStatCard(
              "Morosidad Global",
              "12%",
              "3 unidades pendientes",
              Colors.red,
            ),
            _buildStatCard(
              "Fondo de Reserva",
              "\$2,450.00",
              "+5% este mes",
              Color(0xFFFFA000),
            ),
            _buildStatCard(
              "Resolución Chatbot",
              "92%",
              "Consultas sin operador",
              Colors.green,
            ),
          ] else ...[
            _buildStatCard(
              "Tu Consumo de Agua",
              "Moderado",
              "2% menos que el mes pasado",
              Colors.blue,
            ),
            _buildStatCard(
              "Puntualidad de Pago",
              "Excelente",
              "12 meses sin retrasos",
              Colors.green,
            ),
          ],

          SizedBox(height: 30),

          // --- SECCIÓN DE GRÁFICOS ---
          Text(
            "Temas más consultados al Chatbot",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          _buildChatbotChart(),

          // --- SECCIÓN DE LOGS (SOLO ADMIN) ---
          if (soyAdmin) ...[
            SizedBox(height: 30),
            Text(
              "Últimos reportes vía Chatbot",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildChatLogItem(
                    "Apto 4B",
                    "Consulta sobre deuda",
                    "Resuelto por IA",
                  ),
                  Divider(height: 1),
                  _buildChatLogItem(
                    "Apto 2A",
                    "Fuga de agua en pasillo",
                    "Escalado a Junta",
                  ),
                  Divider(height: 1),
                  _buildChatLogItem(
                    "Apto 1C",
                    "Solicitud de reglamento",
                    "Resuelto por IA",
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: 30),

          // --- MENSAJES DE VALOR ---
          if (soyAdmin)
            _buildInfoTile(
              Icons.lightbulb_outline,
              "Sugerencia: El volumen de dudas sobre 'Pagos' indica que el botón de ayuda debe ser más visible.",
            )
          else
            _buildInfoTile(
              Icons.verified_user,
              "Gracias por tu solvencia. Esto permite el mantenimiento de las áreas comunes.",
            ),
        ],
      ),
    );
  }

  // --- WIDGETS INTERNOS ---

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    Color accentColor,
  ) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A237E),
                  ),
                ),
                Icon(Icons.trending_up, color: accentColor),
              ],
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: accentColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatbotChart() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          _barRow("Pagos/Cuentas", 0.85, Color(0xFF1A237E)),
          _barRow("Servicios (Agua/Luz)", 0.60, Color(0xFF3949AB)),
          _barRow("Reporte de Averías", 0.45, Color(0xFFFFA000)),
        ],
      ),
    );
  }

  Widget _barRow(String label, double percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              Text(
                "${(percent * 100).toInt()}%",
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 6),
          LinearProgressIndicator(
            value: percent,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
        ],
      ),
    );
  }

  Widget _buildChatLogItem(String apto, String tema, String estado) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Color(0xFF1A237E),
        child: Icon(Icons.person, color: Colors.white, size: 20),
      ),
      title: Text(
        "$apto - $tema",
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      trailing: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: estado == "Resuelto por IA"
              ? Colors.green.withOpacity(0.1)
              : Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          estado,
          style: TextStyle(
            fontSize: 11,
            color: estado == "Resuelto por IA" ? Colors.green : Colors.orange,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFF1A237E).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFFFFA000)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
