import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextLiquidWidget extends HookWidget {
  TextStyle? textStyle;
  Duration? loadDuration;
  Duration? waveDuration;
  double? height;
  double? width;
  final String text;
  Color? backgroundColor;
  Color? waveColor;
  final _textKey = GlobalKey();
  final Function? completeAction;

  TextLiquidWidget({
    Key? key,
    required this.text,
    this.textStyle,
    this.loadDuration,
    this.waveDuration,
    this.height,
    this.width,
    this.backgroundColor,
    this.waveColor,
    this.completeAction,
  }) : super(key: key);

  AnimationController? _waveController, _loadController;
  Animation? _loadValue;

  @override
  Widget build(BuildContext context) {
    _init();
    return Stack(
      children: [
        SizedBox(
          height: height,
          width: width ?? MediaQuery.of(context).size.width,
          child: AnimatedBuilder(
            animation: _waveController!,
            builder: (context, child) {
              return CustomPaint(
                painter: WavePainter(
                  key: _textKey,
                  waveAnimation: _waveController!,
                  percentValue: _loadValue!.value,
                  height: height!,
                  waveColor: waveColor!,
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: height,
          width: width ?? MediaQuery.of(context).size.width,
          child: ShaderMask(
            blendMode: BlendMode.srcOut,
            shaderCallback: (bounds) =>
                LinearGradient(colors: [backgroundColor!], stops: [0.0])
                    .createShader(bounds),
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Text(
                  text,
                  key: _textKey,
                  style: textStyle,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _init() {
    debugPrint("init ");
    if (height == null) {
      height = 250;
    }

    if (width == null) {
      width = 400;
    }

    if (loadDuration == null) {
      loadDuration = const Duration(milliseconds: 2000);
    }

    if (waveDuration == null) {
      waveDuration = const Duration(milliseconds: 6000);
    }

    if (backgroundColor == null) {
      backgroundColor = Colors.black;
    }

    if (waveColor == null) {
      waveColor = Colors.white;
    }
    if (textStyle == null) {
      textStyle = const TextStyle(fontSize: 140, fontWeight: FontWeight.bold);
    }

    _loadController = useAnimationController(duration: waveDuration);
    _waveController = useAnimationController(duration: waveDuration);
    _loadValue =
        Tween<double>(begin: 0.0, end: 100.0).animate(_loadController!);
    _waveController?.repeat();
    if(completeAction != null){
      _loadController?.forward().whenComplete((){
        completeAction!();
      });
    }

  }
}

class WavePainter extends CustomPainter {
  final GlobalKey key;
  final Animation<double> waveAnimation;
  final double percentValue;
  final double height;
  final Color waveColor;

  WavePainter({
    required this.key,
    required this.waveAnimation,
    required this.percentValue,
    required this.height,
    required this.waveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    RenderBox? textBox = key.currentContext!.findRenderObject() as RenderBox?;
    if (textBox == null) {
      return;
    }
    double width = size.width;
    double height = size.height;

    Paint wavePaint = Paint()..color = waveColor;

    double textHeight = textBox.size.height;
    double percent = percentValue / 100;
    double baseHeight =
        (height / 2) + (textHeight / 2) - (percent * textHeight);

    Path path = Path();
    path.moveTo(0.0, baseHeight);
    for (double i = 0.0; i < width; i++) {
      path.lineTo(
          i,
          baseHeight +
              sin((i / width * 2 * pi) + (waveAnimation.value * 2 * pi)) * 8);
    }
    path.lineTo(width, height);
    path.lineTo(0.0, height);
    path.close();
    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
