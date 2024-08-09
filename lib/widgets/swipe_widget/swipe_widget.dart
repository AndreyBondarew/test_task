import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwipeWidget extends StatefulWidget {
  final Widget child;
  final Widget secondChild;
  final Duration animationDuration;
  final double swipePercentage;
  final bool isAvailableDelete;
  final VoidCallback onDelete;

  const SwipeWidget({
    super.key,
    required this.child,
    required this.secondChild,
    this.animationDuration = const Duration(milliseconds: 300),
    this.swipePercentage = 0.25,
    required this.isAvailableDelete,
    required this.onDelete,
  });

  @override
  State createState() => _SwipeWidgetState();
}

class _SwipeWidgetState extends State<SwipeWidget> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late AnimationController _heightController;
  late Animation<double> _heightAnimation;
  StreamSubscription<int?>? _subscription;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0.0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _heightController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_heightController);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _animationController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (widget.isAvailableDelete) {
      double delta = details.primaryDelta ?? 0.0;
      _animationController.value -= delta / (MediaQuery.of(context).size.width);
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_animationController.value > 0.35) {
      _animationController.forward();
      _deleteAnimation();
    } else {
      _animationController.reverse();
    }
  }

  Future<void> _deleteAnimation() async {
    await _heightController.forward();
    widget.onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _heightAnimation,
      axisAlignment: 1.0,
      child: GestureDetector(
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        onHorizontalDragEnd: _onHorizontalDragEnd,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.all(.5),
                    child: widget.secondChild,
                  ),
                ),
              ),
              SlideTransition(
                position: _slideAnimation,
                child: SizedBox(
                  width: double.infinity,
                  child: widget.child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
