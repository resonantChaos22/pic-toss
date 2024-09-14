import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ActionButton extends StatefulWidget {
  final VoidCallback onPress;
  final VoidCallback onHold;
  final Widget icon;

  ActionButton({
    required this.onPress,
    required this.onHold,
    required this.icon,
  });

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void shakeIcon() {
    // Start the animation
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // Animation using a Transform widget
    final Animation<double> offsetAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -4.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 4.0), weight: 100),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -4.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 4.0), weight: 100),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -4.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 4.0), weight: 100),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: 0.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -4.0), weight: 50),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 4.0), weight: 100),
      TweenSequenceItem(tween: Tween(begin: 4.0, end: 0.0), weight: 50),
    ]).animate(_controller);

    return GestureDetector(
      onLongPress: () async {
        HapticFeedback.vibrate();
        shakeIcon(); // Trigger the shaking animation
        await Future.delayed(const Duration(milliseconds: 500));
        widget.onHold(); // Trigger the onHold callback after the delay
      },
      child: AnimatedBuilder(
        animation: offsetAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset:
                Offset(offsetAnimation.value, 0), // Apply the shake animation
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: CupertinoButton(
                onPressed: widget.onPress,
                color: CupertinoColors.systemGrey4,
                borderRadius: BorderRadius.circular(50),
                minSize: 80,
                padding: const EdgeInsets.all(16),
                child: widget.icon,
              ),
            ),
          );
        },
      ),
    );
  }
}
