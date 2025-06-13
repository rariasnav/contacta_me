import 'package:flutter/material.dart';

class EmergencyButton extends StatefulWidget {
  final VoidCallback onPressed;

  const EmergencyButton({super.key, required this.onPressed});

  @override
  State<EmergencyButton> createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton> {
  bool _isPressed = false;

  Color get _baseColor => const Color(0xFFD90909);
  Color get _pressedColor => const Color(0xFFB80707);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFC2C2C2), // contorno gris
      ),
      padding: const EdgeInsets.all(10),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          splashColor: Color.fromRGBO(255, 255, 255, 0.3),
          onTap: widget.onPressed,
          onHighlightChanged: (pressed) {
            setState(() => _isPressed = pressed);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isPressed ? _pressedColor : _baseColor,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                  offset: const Offset(0, 2),
                  blurRadius: 0.5,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo
                Image.asset(
                  'assets/images/contacta_logo_blanco.png',
                  width: 120,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 4),
                // Texto Me!
                Image.asset(
                  'assets/images/me_logo.png',
                  width: 40,
                  fit: BoxFit.contain,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}