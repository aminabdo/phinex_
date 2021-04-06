import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:phinex/utils/consts.dart';

class LoadingOverlay extends StatefulWidget {
  final bool isLoading;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Widget child;

  LoadingOverlay({
    @required this.isLoading,
    @required this.child,
    this.opacity = 0.5,
    @required this.progressIndicator,
    this.color,
  });

  @override
  _LoadingOverlayState createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  bool _overlayVisible;

  _LoadingOverlayState();

  @override
  void initState() {
    super.initState();
    _overlayVisible = false;
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _animation.addStatusListener((status) {
      status == AnimationStatus.forward
          ? setState(() => {_overlayVisible = true})
          : null;
      status == AnimationStatus.dismissed
          ? setState(() => {_overlayVisible = false})
          : null;
    });
    if (widget.isLoading) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(LoadingOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.isLoading && widget.isLoading) {
      _controller.forward();
    }

    if (oldWidget.isLoading && !widget.isLoading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var widgets = <Widget>[];
    widgets.add(widget.child);

    if (_overlayVisible == true) {
      final modal = FadeTransition(
        opacity: _animation,
        child: Stack(
          children: <Widget>[
            Opacity(
              child: ModalBarrier(
                dismissible: false,
                color: widget.color ?? Theme.of(context).colorScheme.background,
              ),
              opacity: widget.opacity,
            ),
            Center(child: widget.progressIndicator),
          ],
        ),
      );
      widgets.add(modal);
    }

    return Stack(children: widgets);
  }
}

class Loader extends StatefulWidget {
  final double size;
  final Color circleColor;

  const Loader({Key key, this.size, this.circleColor}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  double size;
  Color color;

  @override
  void initState() {
    super.initState();
    color = widget.circleColor;
    size = widget.size ?? 90;
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, widget) {
        return Center(
          child: Transform.rotate(
            angle: _controller.status == AnimationStatus.forward
                ? (math.pi * 2) * _controller.value
                : -(math.pi * 2) * _controller.value,
            child: Container(
              height: size ?? 90.0,
              width: size ?? 90.0,
              child: CustomPaint(
                painter: LoaderCanvas(
                  radius: _animation.value,
                  color: color,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoaderCanvas extends CustomPainter {
  double radius;
  Color color;

  LoaderCanvas({this.radius, this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint _arc = Paint()
      ..color = deepBlueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Paint _circle = Paint()
      ..color = color ?? mainColor
      ..style = PaintingStyle.fill;

    Offset _center = Offset(size.width / 2, size.height / 2);

    canvas.drawCircle(_center, size.width / 2, _circle);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        math.pi / 4,
        math.pi / 2,
        false,
        _arc);
    canvas.drawArc(
        Rect.fromCenter(
            center: _center,
            width: size.width * radius,
            height: size.height * radius),
        -math.pi / 4,
        -math.pi / 2,
        false,
        _arc);
  }

  @override
  bool shouldRepaint(LoaderCanvas oldPaint) {
    return true;
  }
}
