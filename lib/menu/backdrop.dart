import 'package:flutter/material.dart';

const double _kMinFlingVelocity = 700.0;
const double _kMinFlingVelocityDelta = 400.0;
const double _kFlingVelocityScale = 1.0 / 300.0;

enum _FlingGestureKind { none, forward, reverse }

class Backdrop extends StatefulWidget {
  final Widget backLayer;
  final Widget frontLayer;

  const Backdrop({
    @required this.backLayer,
    @required this.frontLayer,
  })  : assert(backLayer != null),
        assert(frontLayer != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  AnimationController _moveController;
  Animation<RelativeRect> _backAnimation;
  Animation<RelativeRect> _frontAnimation;

  double _dragExtent = 0.0;
  bool _dragUnderway = false;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _moveController.dispose();
    super.dispose();
  }

  bool get _isActive {
    return _dragUnderway || _moveController.isAnimating;
  }

  double get _overallDragAxisExtent {
    return context.size.height;
  }

  _FlingGestureKind _describeFlingGesture(Velocity velocity) {
    if (_dragExtent == 0.0) {
      return _FlingGestureKind.none;
    }

    final double vx = velocity.pixelsPerSecond.dx;
    final double vy = velocity.pixelsPerSecond.dy;

    if (vy.abs() - vx.abs() < _kMinFlingVelocityDelta ||
        vy.abs() < _kMinFlingVelocity) {
      return _FlingGestureKind.none;
    }

    if (vy > 0.0) {
      return _FlingGestureKind.forward;
    }
    return _FlingGestureKind.reverse;
  }

  void _handleDragStart(DragStartDetails details) {
    _dragUnderway = true;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isActive || _moveController.isAnimating) {
      return;
    }

    final double delta = details.primaryDelta;

    _dragExtent += delta;

    if (_moveController.isAnimating) {
      _moveController.value = _dragExtent.abs() / _overallDragAxisExtent;
    }
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!_isActive || _moveController.isAnimating) {
      return;
    }
    _dragUnderway = false;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy;
    switch (_describeFlingGesture(details.velocity)) {
      case _FlingGestureKind.forward:
        print(">>>> Forward");
        _dragExtent = flingVelocity.sign;
        _moveController.fling(
          velocity: flingVelocity.abs() * _kFlingVelocityScale,
        );
        break;
      case _FlingGestureKind.reverse:
        print(">>>> Reverse");
        _dragExtent = flingVelocity.sign;
        _moveController.fling(
          velocity: -flingVelocity.abs() * _kFlingVelocityScale,
        );
        break;
      case _FlingGestureKind.none:
        break;
    }
  }

  // TODO Only for tests purpose. It will be removed.
  void _test() {
    if (_moveController.isCompleted) {
      _moveController.reverse();
    } else {
      _moveController.forward();
    }
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double layerTitleHeight = 40.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;

    _backAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, -layerSize.height - layerTop, 0.0, 0.0),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_moveController);

    _frontAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
      end: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0,  -layerSize.height),
    ).animate(_moveController);

    return Stack(
      children: <Widget>[
        PositionedTransition(
          rect: _backAnimation,
          child: widget.backLayer,
        ),
        PositionedTransition(
          rect: _frontAnimation,
          child: widget.frontLayer,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _test,
      onVerticalDragEnd: _handleDragEnd,
      onVerticalDragStart: _handleDragStart,
      onVerticalDragUpdate: _handleDragUpdate,
      child: LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}
