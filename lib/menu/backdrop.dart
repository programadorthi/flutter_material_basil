import 'package:flutter/material.dart';

const double _revealVelocity = 2.0;

class Backdrop extends StatefulWidget {
  final Widget backLayer;
  final Widget frontLayer;

  const Backdrop({
    @required this.backLayer,
    @required this.frontLayer,
  }) : assert(backLayer != null),
       assert(frontLayer != null);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _frontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    _controller.fling(
        velocity: _frontLayerVisible ? -_revealVelocity : _revealVelocity,
    );
  }

  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - 40.0;

    final Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(
          0.0, layerTop, 0.0, layerTop - layerSize.height),
      end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller);

    return Stack(
      key: _backdropKey,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _toggleBackdropLayerVisibility();
          },
          child: widget.backLayer,
        ),
        PositionedTransition(
          rect: layerAnimation,
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              //print(">> Delta: ${details.delta}");
              //print(">> Primary: ${details.primaryDelta}");
              print(">> Global: ${details.globalPosition}");
            },
            onTap: () {
              _toggleBackdropLayerVisibility();
            },
            child: widget.frontLayer,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: _buildStack),
    );
  }
}
