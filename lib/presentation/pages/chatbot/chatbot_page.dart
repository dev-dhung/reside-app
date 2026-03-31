import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/l10n/app_localizations.dart';

// ---------------------------------------------------------------------------
// Animated dots widget for typing indicator
// ---------------------------------------------------------------------------
class _AnimatedDots extends StatefulWidget {
  const _AnimatedDots();

  @override
  State<_AnimatedDots> createState() => _AnimatedDotsState();
}

class _AnimatedDotsState extends State<_AnimatedDots>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Widget _dot(int index) {
    return _AnimBuilder(
      animation: _ctrl,
      builder: (_, _) {
        final delay = index * 0.2;
        final t = (_ctrl.value - delay).clamp(0.0, 1.0);
        final y = -4.0 * math.sin(t * math.pi);
        return Transform.translate(
          offset: Offset(0, y),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.55),
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(0),
        const SizedBox(width: 5),
        _dot(1),
        const SizedBox(width: 5),
        _dot(2),
      ],
    );
  }
}

// Workaround: AnimatedBuilder is just AnimatedWidget via builder
class _AnimBuilder extends AnimatedWidget {
  final Widget Function(BuildContext, Widget?) builder;
  const _AnimBuilder({
    required Animation<double> animation,
    required this.builder,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) => builder(context, null);
}

// ---------------------------------------------------------------------------
// Slide-in wrapper for messages
// ---------------------------------------------------------------------------
class _SlideInMessage extends StatefulWidget {
  final Widget child;
  final bool fromLeft;

  const _SlideInMessage({required this.child, required this.fromLeft});

  @override
  State<_SlideInMessage> createState() => _SlideInMessageState();
}

class _SlideInMessageState extends State<_SlideInMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slide = Tween<Offset>(
      begin: Offset(widget.fromLeft ? -0.15 : 0.15, 0.05),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: FadeTransition(opacity: _fade, child: widget.child),
    );
  }
}

// ---------------------------------------------------------------------------
// Chatbot Page
// ---------------------------------------------------------------------------
class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, String>> _mensajes = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  String _estadoActual = 'inicio';
  bool _initialized = false;
  bool _isInputFocused = false;

  L10n get l10n => L10n.of(context);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (mounted) setState(() => _isInputFocused = _focusNode.hasFocus);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      _mensajes.add({
        'autor': 'bot',
        'texto': l10n.chatbotGreeting,
        'hora':
            '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // -------------------------------------------------------------------------
  // AI response logic - PRESERVED EXACTLY
  // -------------------------------------------------------------------------
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
    if (_estadoActual == 'esperando_metodos_pago') {
      if (m.contains('si') ||
          m.contains('claro') ||
          m.contains('cuales') ||
          m.contains('ver')) {
        _estadoActual = 'inicio';
        return l10n.chatbotPaymentMethods;
      } else {
        _estadoActual = 'inicio';
        return l10n.chatbotGenericFollowup;
      }
    }

    // 2. CONTEXTO: RESERVAS
    if (_estadoActual == 'esperando_guia_reserva') {
      if (m.contains('si') ||
          m.contains('por favor') ||
          m.contains('guiame') ||
          m.contains('como')) {
        _estadoActual = 'esperando_confirmacion_deposito';
        return l10n.chatbotReservationGuide;
      } else {
        _estadoActual = 'inicio';
        return l10n.chatbotReservationReminder;
      }
    }

    if (_estadoActual == 'esperando_confirmacion_deposito') {
      if (m.contains('si') || m.contains('ok') || m.contains('ver')) {
        _estadoActual = 'inicio';
        return l10n.chatbotAreaRules;
      } else {
        _estadoActual = 'inicio';
        return l10n.chatbotEventWish;
      }
    }

    // --- DETECCION DE INTENCIONES (DISPARADORES) ---

    if (RegExp(r'(debo|pago|monto|deuda|dinero|cuenta|saldo)').hasMatch(m)) {
      _estadoActual = 'esperando_metodos_pago';
      return l10n.chatbotPaymentStatus;
    }

    if (RegExp(
      r'(agua|luz|electricidad|bomba|ascensor|falla|averia|danado)',
    ).hasMatch(m)) {
      return l10n.chatbotTechnicalStatus;
    }

    if (RegExp(
      r'(reserva|parrillera|piscina|salon|fiesta|areas)',
    ).hasMatch(m)) {
      _estadoActual = 'esperando_guia_reserva';
      return l10n.chatbotReservationAvailable;
    }

    if (RegExp(
      r'(norma|regla|ruido|multa|convivencia|perro|mascota)',
    ).hasMatch(m)) {
      return l10n.chatbotRulesQuery;
    }

    // Respuestas Generales
    if (m.contains('hola') || m.contains('buen')) {
      return l10n.chatbotIntro;
    }
    if (m.contains('gracias') || m.contains('ok') || m.contains('entendido')) {
      return l10n.chatbotCourtesy;
    }
    if (m.contains('ayuda') || m.contains('que haces')) {
      return l10n.chatbotCapabilities;
    }

    return l10n.chatbotError;
  }

  // -------------------------------------------------------------------------
  // Send message
  // -------------------------------------------------------------------------
  String _horaActual() =>
      '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';

  void _showBotRatingDialog(BuildContext context) {
    int rating = 0;
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: AppColors.gradientPrimary,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.smart_toy_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '¿Cómo fue tu experiencia?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Tu opinión nos ayuda a mejorar',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    return GestureDetector(
                      onTap: () => setDialogState(() => rating = i + 1),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          i < rating
                              ? Icons.star_rounded
                              : Icons.star_outline_rounded,
                          size: 36,
                          color: i < rating
                              ? AppColors.accent
                              : AppColors.textTertiary,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: rating > 0
                        ? () {
                            Navigator.pop(ctx);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    const Text('¡Gracias por tu calificación!'),
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          }
                        : null,
                    child: const Text('Enviar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _enviarMensaje(String texto) {
    if (texto.isEmpty) return;
    final hora =
        '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';

    setState(() {
      _mensajes.add({'autor': 'user', 'texto': texto, 'hora': hora});
      _mensajes.add({'autor': 'bot', 'texto': '...', 'escribiendo': 'true'});
    });
    _controller.clear();
    _focusNode.unfocus();
    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _mensajes.removeWhere((m) => m['escribiendo'] == 'true');
        _mensajes.add({
          'autor': 'bot',
          'texto': _obtenerRespuestaIA(texto),
          'hora': hora,
        });
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // -------------------------------------------------------------------------
  // Helper: is the conversation still in welcome state?
  // -------------------------------------------------------------------------
  bool get _isWelcomeState => _mensajes.length <= 1;

  bool get _lastMessageIsBot {
    if (_mensajes.isEmpty) return false;
    final last = _mensajes.last;
    return last['autor'] == 'bot' && last['escribiendo'] != 'true';
  }


  // -------------------------------------------------------------------------
  // BUILD
  // -------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewPadding.bottom;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          // ---- CUSTOM APP BAR ----
          _buildAppBar(context),

          // ---- CHAT AREA ----
          Expanded(
            child: _isWelcomeState
                ? _buildWelcomeView()
                : _buildChatList(),
          ),

          // ---- QUICK REPLIES ----
          if (_lastMessageIsBot && !_isInputFocused && !_isWelcomeState)
            _buildQuickReplies(),

          // ---- INPUT BAR ----
          _buildInputBar(bottomPadding),
        ],
      ),
    );
  }

  // =========================================================================
  // APP BAR
  // =========================================================================
  Widget _buildAppBar(BuildContext context) {
    final topPadding = MediaQuery.of(context).viewPadding.top;
    return Container(
      padding: EdgeInsets.only(
        top: topPadding + 8,
        left: 4,
        right: 12,
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.scaffoldBackground,
        border: Border(
          bottom: BorderSide(
            color: AppColors.divider.withValues(alpha: 0.6),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Back
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
            color: AppColors.textPrimary,
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 4),
          // Avatar
          _buildBotAvatarSmall(40),
          const SizedBox(width: 12),
          // Title + status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reside Bot',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontMedium,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'En l\u00ednea',
                      style: TextStyle(
                        fontSize: AppDimensions.fontSmall,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Options menu
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert_rounded,
              size: 22,
              color: AppColors.textSecondary,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            offset: const Offset(0, 48),
            onSelected: (value) {
              switch (value) {
                case 'clear':
                  setState(() {
                    _mensajes.clear();
                    _mensajes.add({
                      'autor': 'bot',
                      'texto': l10n.chatbotGreeting,
                      'hora': _horaActual(),
                    });
                    _estadoActual = 'inicio';
                  });
                  break;
                case 'export':
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Historial exportado exitosamente'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                  break;
                case 'rate':
                  _showBotRatingDialog(context);
                  break;
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.refresh_rounded,
                        size: 20, color: AppColors.primary),
                    SizedBox(width: 12),
                    Text('Reiniciar conversación'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'export',
                child: Row(
                  children: [
                    Icon(Icons.download_rounded,
                        size: 20, color: AppColors.primary),
                    SizedBox(width: 12),
                    Text('Exportar historial'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'rate',
                child: Row(
                  children: [
                    Icon(Icons.star_outline_rounded,
                        size: 20, color: AppColors.accent),
                    SizedBox(width: 12),
                    Text('Calificar asistente'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // BOT AVATAR (reusable)
  // =========================================================================
  Widget _buildBotAvatarSmall(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.gradientPrimary,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(size * 0.32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.22),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.smart_toy_rounded,
        size: size * 0.5,
        color: Colors.white,
      ),
    );
  }

  // =========================================================================
  // WELCOME VIEW
  // =========================================================================
  Widget _buildWelcomeView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
        vertical: AppDimensions.paddingMedium,
      ),
      child: Column(
        children: [
          // Large avatar
          _buildBotAvatarSmall(52),
          const SizedBox(height: 14),
          // Greeting
          if (_mensajes.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 24,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Text(
                _mensajes.first['texto'] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: AppDimensions.fontBody,
                  color: AppColors.textPrimary,
                  height: 1.5,
                ),
              ),
            ),
          const SizedBox(height: 16),
          // Suggested topic cards
          _buildTopicCards(),
        ],
      ),
    );
  }

  Widget _buildTopicCards() {
    final topics = [
      _TopicItem(
        emoji: '\uD83D\uDCB0',
        title: 'Consultar saldo',
        subtitle: 'Verifica tu estado de cuenta',
        query: l10n.quickReplyDebt,
      ),
      _TopicItem(
        emoji: '\uD83D\uDD27',
        title: 'Reportar aver\u00eda',
        subtitle: 'Informa fallas t\u00e9cnicas',
        query: l10n.quickReplyWaterIssue,
      ),
      _TopicItem(
        emoji: '\uD83D\uDCC5',
        title: 'Reservar \u00e1rea',
        subtitle: 'Piscina, parrillera y m\u00e1s',
        query: l10n.quickReplyReserveArea,
      ),
      _TopicItem(
        emoji: '\uD83D\uDCCB',
        title: 'Ver normativa',
        subtitle: 'Reglas de convivencia',
        query: l10n.quickReplyNoiseRules,
      ),
    ];

    return Column(
      children: [
        for (int i = 0; i < topics.length; i += 2) ...[
          if (i > 0) const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _buildTopicCard(topics[i])),
              const SizedBox(width: 10),
              Expanded(
                child: i + 1 < topics.length
                    ? _buildTopicCard(topics[i + 1])
                    : const SizedBox(),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildTopicCard(_TopicItem topic) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      child: InkWell(
        onTap: () => _enviarMensaje(topic.query),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.08),
            ),
          ),
          child: Row(
            children: [
              Text(topic.emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      topic.subtitle,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textTertiary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================================
  // CHAT LIST
  // =========================================================================
  Widget _buildChatList() {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: AppDimensions.paddingMedium,
      ),
      itemCount: _mensajes.length,
      itemBuilder: (context, index) {
        final msg = _mensajes[index];
        final isBot = msg['autor'] == 'bot';
        final isTyping = msg['escribiendo'] == 'true';

        // Determine if we should show the bot avatar (first in a group)
        bool showBotAvatar = false;
        if (isBot) {
          if (index == 0 || _mensajes[index - 1]['autor'] != 'bot') {
            showBotAvatar = true;
          }
        }

        // Determine if this is the last in a group (to show timestamp)
        bool showTime = false;
        if (index == _mensajes.length - 1 ||
            _mensajes[index + 1]['autor'] != msg['autor']) {
          showTime = true;
        }

        final child = isBot
            ? _buildBotMessage(msg, isTyping, showBotAvatar, showTime)
            : _buildUserMessage(msg, showTime);

        return KeyedSubtree(
          key: ValueKey('msg_$index'),
          child: _SlideInMessage(
            fromLeft: isBot,
            child: child,
          ),
        );
      },
    );
  }

  // ---- BOT MESSAGE ----
  Widget _buildBotMessage(
    Map<String, String> msg,
    bool isTyping,
    bool showAvatar,
    bool showTime,
  ) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: showTime ? 12 : 3,
        right: MediaQuery.of(context).size.width * 0.22,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Avatar or spacer
          SizedBox(
            width: 34,
            child: showAvatar
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: _buildBotAvatarSmall(28),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          // Bubble
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: isTyping
                      ? const Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          child: _AnimatedDots(),
                        )
                      : Text(
                          msg['texto'] ?? '',
                          style: const TextStyle(
                            fontSize: AppDimensions.fontBody,
                            color: AppColors.textPrimary,
                            height: 1.45,
                          ),
                        ),
                ),
                if (showTime && !isTyping) ...[
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      msg['hora'] ?? '',
                      style: const TextStyle(
                        fontSize: AppDimensions.fontXS,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---- USER MESSAGE ----
  Widget _buildUserMessage(Map<String, String> msg, bool showTime) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: showTime ? 12 : 3,
        left: MediaQuery.of(context).size.width * 0.22,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.gradientPrimary,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(4),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              msg['texto'] ?? '',
              style: const TextStyle(
                fontSize: AppDimensions.fontBody,
                color: Colors.white,
                height: 1.45,
              ),
            ),
          ),
          if (showTime) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                msg['hora'] ?? '',
                style: const TextStyle(
                  fontSize: AppDimensions.fontXS,
                  color: AppColors.textTertiary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // =========================================================================
  // QUICK REPLIES
  // =========================================================================
  Widget _buildQuickReplies() {
    final options = [
      l10n.quickReplyDebt,
      l10n.quickReplyWaterIssue,
      l10n.quickReplyReserveArea,
      l10n.quickReplyNoiseRules,
    ];

    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 6),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: options.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final option = options[index];
            return Material(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
              child: InkWell(
                onTap: () => _enviarMensaje(option),
                borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.radiusPill),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    option,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================================
  // INPUT BAR
  // =========================================================================
  Widget _buildInputBar(double bottomPadding) {
    return Container(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 10,
        bottom: 10 + bottomPadding,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) {
                final text = _controller.text.trim();
                if (text.isNotEmpty) _enviarMensaje(text);
              },
              style: const TextStyle(
                fontSize: AppDimensions.fontBody,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: l10n.chatInputHint,
                hintStyle: const TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: AppDimensions.fontBody,
                ),
                filled: true,
                fillColor: AppColors.inputBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusPill),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              final text = _controller.text.trim();
              if (text.isNotEmpty) _enviarMensaje(text);
            },
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppColors.gradientPrimary,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Data class for topic cards
// ---------------------------------------------------------------------------
class _TopicItem {
  final String emoji;
  final String title;
  final String subtitle;
  final String query;

  const _TopicItem({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.query,
  });
}
