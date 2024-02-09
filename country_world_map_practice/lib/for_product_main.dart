// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_maps/maps.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MapPage(),
//     );
//   }
// }
//
// class _MapPageState extends State<MapPage> {
//   late MapShapeSource _dataSource;
//   late MapZoomPanBehavior _zoomPanBehavior;
//   int _selectedIndex = -1; // 초기에는 아무것도 선택되지 않았음을 나타냅니다.
//
//   @override
//   void initState() {
//     super.initState();
//     _zoomPanBehavior = MapZoomPanBehavior(enableDoubleTapZooming: true, enablePanning: true, enablePinching: true, zoomLevel: 3);
//
//     _dataSource = MapShapeSource.asset(
//       "assets/world_map.json", // Make sure you have the correct path to the asset
//       shapeDataField: "name",
//       dataCount: countries.length,
//       primaryValueMapper: (int index) => countries[index].name,
//       dataLabelMapper: (int index) => countries[index].name,
//       shapeColorValueMapper: (int index) => countries[index].color,
//     );
//   }
//
//   void _showModalWindow() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         // Here we will build the content of the dialog
//         return AlertDialog(
//           title: Text("안녕하세요!"),
//           content: Text("중국을 선택하셨습니다!"),
//           actions: <Widget>[
//             FloatingActionButton(
//               child: Text("닫기"),
//               onPressed: () {
//                 Navigator.of(context).pop(); // 다이얼로그 닫기
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('World Map'),
//       ),
//       body: SfMaps(
//         layers: [
//           MapShapeLayer(
//             source: _dataSource,
//             showDataLabels: true,
//             dataLabelSettings: MapDataLabelSettings(
//               overflowMode: MapLabelOverflow.ellipsis,
//               textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//             ),
//             zoomPanBehavior: _zoomPanBehavior,
//             selectionSettings: MapSelectionSettings(color: Colors.orange, strokeColor: Colors.red),
//             onSelectionChanged: (int index) {
//               if (countries[index].name == 'China') {
//                 _showModalWindow();
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
// class MapPage extends StatefulWidget {
//   @override
//   _MapPageState createState() => _MapPageState();
// }
//
//
// // Example country model
// class Country {
//   Country(this.name, this.color);
//
//   final String name;
//   final Color color;
// }
//
// // Example countries data
// final List<Country> countries = [
//   Country('India', Colors.red),
//   Country('United States of America', Colors.blue),
//   Country('China', Colors.green),
//   // Add more countries as needed
// ];
