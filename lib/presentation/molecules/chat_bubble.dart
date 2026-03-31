import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';
import 'package:prototype/l10n/app_localizations.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isBot;
  final String time;
  final bool isTyping;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isBot,
    required this.time,
    this.isTyping = false,
  });

  @override
  Widget build(BuildContext context) {
    final alignment =
        isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final bgColor = isBot ? AppColors.cardBackground : AppColors.primary;
    final textColor =
        isBot ? AppColors.textPrimary : AppColors.textOnPrimary;

    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(AppDimensions.radiusLarge),
      topRight: const Radius.circular(AppDimensions.radiusLarge),
      bottomLeft:
          Radius.circular(isBot ? 4 : AppDimensions.radiusLarge),
      bottomRight:
          Radius.circular(isBot ? AppDimensions.radiusLarge : 4),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingXS,
        horizontal: AppDimensions.paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: borderRadius,
              boxShadow: isBot
                  ? const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: isTyping
                ? Text(
                    L10n.of(context).typingIndicator,
                    style: TextStyle(
                      fontSize: AppDimensions.fontBody,
                      fontStyle: FontStyle.italic,
                      color: textColor,
                    ),
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: AppDimensions.fontBody,
                      color: textColor,
                      height: 1.4,
                    ),
                  ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              time,
              style: const TextStyle(
                fontSize: AppDimensions.fontXS,
                color: AppColors.textTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
