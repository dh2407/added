import 'package:flutter/material.dart';

class NvSubSubjectButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final Color textColor;

  const NvSubSubjectButton({
    required this.text,
    Key? key,
    required this.onTap,
    this.textColor = const Color(0xFF676CAC),
  }) : super(key: key);

  @override
  _NvSubSubjectButtonState createState() => _NvSubSubjectButtonState();
}

class _NvSubSubjectButtonState extends State<NvSubSubjectButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: _isPressed
              ? null
              : [
                  const BoxShadow(
                    color: Color(0x3F434BB4),
                    blurRadius: 8,
                    offset: Offset(1, 1),
                    spreadRadius: 0,
                  ),
                ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.textColor,
                fontSize: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
