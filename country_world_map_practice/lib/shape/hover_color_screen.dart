// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_core/theme.dart';
// import 'package:syncfusion_flutter_maps/maps.dart';
//
// // hover 기능이나 모바일에서는 지원 X
// class HoverColorScreen extends StatefulWidget {
//   HoverColorScreen({Key? key}) : super(key: key);
//
//   @override
//   _HoverColorScreenState createState() => _HoverColorScreenState();
// }
//
// class _HoverColorScreenState extends State<HoverColorScreen> {
//   late MapShapeSource dataSource;
//
//   @override
//   void initState() {
//     dataSource = MapShapeSource.asset(
//       'assets/world_map.json',
//       shapeDataField: 'continent',
//     );
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(15),
//         child: SfMapsTheme(
//           data: SfMapsThemeData(
//             shapeHoverColor: Colors.red[800],
//             shapeHoverStrokeColor: Colors.black,
//             shapeHoverStrokeWidth: 2,
//           ),
//           child: SfMaps(
//             layers: <MapLayer>[
//               MapShapeLayer(
//                 source: dataSource,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }