import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: AnimatedLoader(),
//         ),
//       ),
//     );
//   }
// }
//
// class AnimatedLoader extends StatefulWidget {
//   @override
//   _AnimatedLoaderState createState() => _AnimatedLoaderState();
// }
//
// class _AnimatedLoaderState extends State<AnimatedLoader> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return RotationTransition(
//       turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
//       child: SvgPicture.asset(
//         // 여기에 변형된 SVG 데이터를 넣습니다. stroke 색상을 #5356FF로 변경했다고 가정합니다.
//         'assets/icons/test.svg',
//         width: 160,
//         height: 160,
//       ),
//     );
//   }
// }

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           // 여기에서 AnimatedStrokeLoader 위젯을 호출합니다.
//           child: AnimatedStrokeLoader(),
//         ),
//       ),
//     );
//   }
// }
//
// class AnimatedStrokeLoader extends StatefulWidget {
//   @override
//   _AnimatedStrokeLoaderState createState() => _AnimatedStrokeLoaderState();
// }
//
// class _AnimatedStrokeLoaderState extends State<AnimatedStrokeLoader> with SingleTickerProviderStateMixin {
//   AnimationController? _animationController;
//   Animation<double>? _animation;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(vsync: this, duration: Duration(seconds: 2))
//       ..repeat();
//     _animation = Tween(begin: 0.0, end: 360.0).animate(_animationController!)
//       ..addListener(() {
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     _animationController!.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: StrokeLoaderPainter(_animation!.value),
//       size: Size(200, 200),
//     );
//   }
// }
//
// class StrokeLoaderPainter extends CustomPainter {
//   final double progress;
//
//   StrokeLoaderPainter(this.progress);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = Color(0xFF5356FF) // 로딩 색상
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 5.0;
//
//     var path = Path();
//     // SVG의 stroke 부분과 유사한 경로를 정의합니다. 예시로, 원을 그립니다.
//     path.addArc(Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 70), ui.radians(-90), ui.radians(progress));
//
//     // Dash 효과를 생성합니다.
//     var dashPath = dashPath(path, dashArray: CircularIntervalList<double>([15.0, 10.0]));
//
//     canvas.drawPath(dashPath, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
//
//   Path dashPath(Path source, {required CircularIntervalList<double> dashArray}) {
//     var path = Path();
//     var distance = 0.0;
//
//     var sourceMetrics = source.computeMetrics();
//     for (var metric in sourceMetrics) {
//       while (distance < metric.length) {
//         final segment = dashArray.next();
//         if (distance + segment < metric.length) {
//           final extractPath = metric.extractPath(distance, distance + segment);
//           path.addPath(extractPath, Offset.zero);
//         }
//         distance += segment;
//       }
//       distance = 0.0; // Reset for next path
//     }
//
//     return path;
//   }
// }



//---------------------------------------------------------------------------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: AnimatedStrokeLoader(),
//         ),
//       ),
//     );
//   }
// }
//
// class AnimatedStrokeLoader extends StatefulWidget {
//   @override
//   _AnimatedStrokeLoaderState createState() => _AnimatedStrokeLoaderState();
// }
//
// class _AnimatedStrokeLoaderState extends State<AnimatedStrokeLoader> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         SvgPicture.asset(
//           // Here you put your static SVG data (without the animated strokes).
//           'assets/icons/test.svg',
//           width: 160,
//           height: 160,
//         ),
//         RotationTransition(
//           turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
//           child: SvgPicture.asset(
//             // Here you put your SVG data for the strokes only, which you want to animate.
//             'assets/icons/test.svg',
//             width: 160,
//             height: 160,
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: MyScrollableSVGList(),
        ),
      ),
    );
  }
}

class MyScrollableSVGList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int completedItemsCount = 5; // 완료된 항목의 개수
    int upcomingItemsCount = 5; // 미완성 항목의 개수

    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < completedItemsCount; i++) ...[
            SvgPicture.asset(
              'assets/icons/complete.svg',
              width: 160,
              height: 160,
            ),
            // 완료된 항목 사이에 파란색 연결선 추가
            SvgPicture.asset('assets/icons/connect_1.svg'),
          ],
          AnimatedLoader(),
          // '진행 중' 아이템 아래 파란색 연결선 추가
          SvgPicture.asset('assets/icons/connect_1.svg'),
          for (var i = 0; i < upcomingItemsCount; i++) ...[
            // 미완성 항목 사이에 회색 연결선 추가
            if (i > 0) SvgPicture.asset('assets/icons/connect_2.svg'),
            SvgPicture.asset(
              'assets/icons/test.svg',
              width: 160,
              height: 160,
            ),
          ],
        ],
      ),
    );
  }
}


class AnimatedLoader extends StatefulWidget {
  @override
  _AnimatedLoaderState createState() => _AnimatedLoaderState();
}

class _AnimatedLoaderState extends State<AnimatedLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/test.svg',
          width: 160,
          height: 160,
        ),
        CustomPaint(
          size: Size(160, 160),
          painter: AnimatedCirclePainter(_controller),
        ),
      ],
    );
  }
}

class AnimatedCirclePainter extends CustomPainter {
  final Animation<double> animation;

  AnimatedCirclePainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Color(0xFFC7C7C7) // default stroke 색상
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0; // 진행중인 것의 강조를 원한다면(아니라면 0.0 디폴트)
    canvas.drawCircle(size.center(Offset.zero), 78, backgroundPaint);

    Paint animatedPaint = Paint()
      ..color = Color(0xFF5356FF) // animating stroke 색상
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0; //상위의 strokeWidth와 동일하게 설정

    double sweepAngle = 2 * math.pi / 3; // 내부 컬러 게이지 정도(현재: 전체 원의 1/3 정도에 해당하는 각도)
    double startAngle = -math.pi / 2 + (animation.value * 2 * math.pi); // 시작 각도 (-90도에서 시작)

    canvas.drawArc(
      Rect.fromCenter(center: size.center(Offset.zero), width: 156, height: 156), //fit the circle
      startAngle,
      sweepAngle,
      false,
      animatedPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DividerLine extends StatelessWidget {
  final Color color;

  DividerLine({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2.0,
      color: color,
    );
  }
}

class ConnectorLine extends StatelessWidget {
  final Color color;
  const ConnectorLine({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 20, // '다리'의 길이를 조절합니다.
      alignment: Alignment.center,
      child: Container(
        height: 2, // 선의 두께
        width: 50, // 선의 길이
        color: color,
      ),
    );
  }
}