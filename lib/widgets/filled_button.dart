import 'package:flutter/material.dart';

class Ph4hFilledButton extends StatelessWidget {
  final bool isDisabled;
  final bool submitting;
  final String buttonLabel;
  final double fontSize;
  final bool hasPrefixIcon;
  final Widget? prefixIcon;
  final void Function()? onPressed;

  const Ph4hFilledButton({
    super.key,
    required this.submitting,
    required this.buttonLabel,
    required this.isDisabled,
    required this.onPressed,
    this.fontSize = 18,
    this.hasPrefixIcon = false,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final textContent = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (hasPrefixIcon && prefixIcon != null) ...[
          prefixIcon!,
          const SizedBox(width: 8),
        ],
        Text(buttonLabel, style: TextStyle(fontSize: fontSize)),
      ],
    );

    return FilledButton(
      onPressed: isDisabled ? null : onPressed,
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: submitting
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(opacity: 0.0, child: textContent),
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ],
                )
              : textContent,
        ),
      ),
    );
  }
}
