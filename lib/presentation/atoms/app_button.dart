import 'package:flutter/material.dart';
import 'package:prototype/core/constants/app_colors.dart';
import 'package:prototype/core/constants/app_dimensions.dart';

class AppButton extends StatefulWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.icon,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final effectiveBg = widget.backgroundColor ?? AppColors.primary;
    final pressedBg = Color.lerp(effectiveBg, Colors.black, 0.1)!;
    final effectiveTextColor = widget.textColor ??
        (widget.isOutlined ? effectiveBg : AppColors.textOnPrimary);
    final effectiveWidth = widget.width ?? double.infinity;
    final effectiveHeight = widget.height ?? AppDimensions.buttonHeight;

    final content = widget.icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(widget.icon, size: AppDimensions.iconSmall),
              const SizedBox(width: 8),
              Text(widget.label),
            ],
          )
        : Text(widget.label);

    final textStyle = TextStyle(
      fontSize: AppDimensions.fontMedium,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.5,
      color: effectiveTextColor,
    );

    return GestureDetector(
      onTapDown: widget.onPressed != null
          ? (_) => setState(() => _pressed = true)
          : null,
      onTapUp: widget.onPressed != null
          ? (_) => setState(() => _pressed = false)
          : null,
      onTapCancel: widget.onPressed != null
          ? () => setState(() => _pressed = false)
          : null,
      onTap: widget.onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        width: effectiveWidth,
        height: effectiveHeight,
        decoration: BoxDecoration(
          color: widget.isOutlined
              ? Colors.transparent
              : (_pressed ? pressedBg : effectiveBg),
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          border: widget.isOutlined
              ? Border.all(color: effectiveBg, width: 1.5)
              : null,
        ),
        alignment: Alignment.center,
        child: DefaultTextStyle(
          style: textStyle,
          child: IconTheme(
            data: IconThemeData(color: effectiveTextColor),
            child: content,
          ),
        ),
      ),
    );
  }
}
