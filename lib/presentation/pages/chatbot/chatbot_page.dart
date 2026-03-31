import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/l10n/app_localizations.dart';
import 'package:prototype/presentation/molecules/chat_bubble.dart';
import 'package:prototype/presentation/organisms/chat_input_bar.dart';
import 'package:prototype/presentation/organisms/quick_replies.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<Map<String, String>> _mensajes = [];

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _estadoActual = 'inicio';
  bool _initialized = false;

  L10n get l10n => L10n.of(context);

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
    super.dispose();
  }

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

  void _enviarMensaje(String texto) {
    if (texto.isEmpty) return;
    final hora =
        '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}';

    setState(() {
      _mensajes.add({'autor': 'user', 'texto': texto, 'hora': hora});
      _mensajes
          .add({'autor': 'bot', 'texto': '...', 'escribiendo': 'true'});
    });
    _controller.clear();
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

  Widget _buildBotAvatar() {
    return Container(
      width: AppDimensions.avatarSmall,
      height: AppDimensions.avatarSmall,
      decoration: const BoxDecoration(
        color: AppColors.primarySurface,
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.smart_toy_rounded,
        size: AppDimensions.iconSmall,
        color: AppColors.primary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.primarySurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.smart_toy_rounded,
                size: AppDimensions.iconXS,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
            Text(
              l10n.chatbotTitle,
              style: const TextStyle(
                fontSize: AppDimensions.fontLarge,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingSmall,
                vertical: AppDimensions.paddingMedium,
              ),
              itemCount: _mensajes.length,
              itemBuilder: (context, index) {
                final msg = _mensajes[index];
                final isBot = msg['autor'] == 'bot';
                final isTyping = msg['escribiendo'] == 'true';

                if (isBot) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDimensions.paddingXS,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: AppDimensions.paddingMedium,
                          ),
                          child: _buildBotAvatar(),
                        ),
                        Expanded(
                          child: ChatBubble(
                            text: msg['texto'] ?? '',
                            isBot: true,
                            time: msg['hora'] ?? '',
                            isTyping: isTyping,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ChatBubble(
                  text: msg['texto'] ?? '',
                  isBot: false,
                  time: msg['hora'] ?? '',
                  isTyping: false,
                );
              },
            ),
          ),
          QuickReplies(
            options: [
              l10n.quickReplyDebt,
              l10n.quickReplyWaterIssue,
              l10n.quickReplyReserveArea,
              l10n.quickReplyNoiseRules,
            ],
            onSelected: _enviarMensaje,
          ),
          const SizedBox(height: AppDimensions.paddingXS),
          ChatInputBar(
            controller: _controller,
            onSend: _enviarMensaje,
          ),
        ],
      ),
    );
  }
}
