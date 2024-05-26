import 'package:flutter/material.dart';

enum ResponseButtonState { idle, failed, success }

class ResponseButton extends StatefulWidget {
  final String content;
  final VoidCallback onPressed;
  final ResponseButtonState state;

  const ResponseButton({
    required this.content,
    required this.onPressed,
    required this.state,
    Key? key,
  }) : super(key: key);

  @override
  _ResponseButtonState createState() => _ResponseButtonState();
}

class _ResponseButtonState extends State<ResponseButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (widget.state == ResponseButtonState.failed) {
      _triggerAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ResponseButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state != widget.state &&
        widget.state == ResponseButtonState.failed) {
      _triggerAnimation();
    }
  }

  void _triggerAnimation() {
    _controller.reset();
    _controller.repeat(reverse: true);
    Future.delayed(Duration(milliseconds: 1200), () {
      _controller.stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Colors.transparent;
    Color textColor = Colors.black;

    switch (widget.state) {
      case ResponseButtonState.idle:
        buttonColor = Colors.transparent;
        textColor = Colors.black;
        break;
      case ResponseButtonState.failed:
        buttonColor = Colors.red;
        textColor = Colors.white;
        break;
      case ResponseButtonState.success:
        buttonColor = Colors.green;
        textColor = Colors.white;
        break;
    }

    return SizedBox(
      width: 77.0,
      height: 77.0,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.zero,
                backgroundColor: buttonColor,
              ),
              child: Center(
                child: Text(
                  widget.content,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
