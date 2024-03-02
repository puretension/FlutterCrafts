// import 'package:country_world_map_practice/data_labels/appearance_customization_screen.dart';
// import 'package:country_world_map_practice/data_labels/overflow_mode_screen.dart';
// import 'package:country_world_map_practice/data_labels/show_data_labels_screen.dart';
// import 'package:country_world_map_practice/data_labels/text_customization_screen.dart';
// import 'package:country_world_map_practice/getting_started/asset_bundle_screen.dart';
// import 'package:country_world_map_practice/getting_started/network_screen.dart';
// import 'package:country_world_map_practice/getting_started/shape_layer_map_screen.dart';
// import 'package:country_world_map_practice/getting_started/tile_layer_screen.dart';
// import 'package:country_world_map_practice/rtl_supported/rtl_supported_map_screen.dart';
// import 'package:country_world_map_practice/shape/applying_color_screen.dart';
// import 'package:country_world_map_practice/shape/equal_color_screen.dart';
// import 'package:country_world_map_practice/shape/hover_color_screen.dart';
// import 'package:country_world_map_practice/shape/loading_builder_screen.dart';
// import 'package:country_world_map_practice/shape_selection/shape_selection_changed_screen.dart';
// import 'package:country_world_map_practice/shape_selection/shape_selection_sf_theme_screen.dart';
// import 'package:country_world_map_practice/tooltips/tooltip_modal_screen.dart';
// import 'package:country_world_map_practice/tooltips/tooltip_shape_screen.dart';
// import 'package:country_world_map_practice/vector_layer/animation_vector_layer_screen.dart';
// import 'package:country_world_map_practice/zooming_and_panning/equal_color_mapping_screen.dart';
// import 'package:country_world_map_practice/zooming_and_panning/label_customization_screen.dart';
// import 'package:country_world_map_practice/zooming_and_panning/shape_layer_screen.dart';
// import 'package:country_world_map_practice/zooming_and_panning/tooltip_shape_layer_screen.dart';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: RtlSupportedMapScreen(), // Set GeoJSON data for shape layer from asset bundle
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_maps/maps.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapShapeSource _dataSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  bool _isLoading = true;
  double _currentZoomLevel = 6;

  // 변경: 리스크 레벨별 상태 관리
  bool _showLowRisk = false;
  bool _showMidRisk = false;
  bool _showHighRisk = false;

  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: MapLatLng(27.1751, 78.0421),
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
      zoomLevel: _currentZoomLevel,
      minZoomLevel: 1,
      maxZoomLevel: 14,
    );
    print(_showLowRisk);
    _showLowRisk = true;
    print(_showLowRisk);
    _showMidRisk = true;
    _showHighRisk = true;
    _updateDataSource();
  }

  Future<void> _updateDataSource() async {
    print('now is time');
    final jsonString = await rootBundle.loadString('assets/world_map.json');
    final jsonResponse = json.decode(jsonString);
    final features = jsonResponse['features'] as List;

    setState(() {
      _dataSource = MapShapeSource.asset(
        'assets/world_map.json',
        shapeDataField: 'name',
        dataCount: features.length,
        primaryValueMapper: (int index) =>
            features[index]['properties']['name'],
        shapeColorValueMapper: (int index) =>
            _getRiskLevelColor(features[index]['properties']['name']),
        dataLabelMapper: (int index) =>
            jsonResponse['features'][index]['properties']['name'],
      );
      _isLoading = false;
    });
  }

  Color _getRiskLevelColor(String countryName) {
    const lowRiskCountries = [
      'Bangladesh',
      'Burkina Faso',
      'Colombia',
      'Haiti',
      'Iraq',
      'Kenya',
      'Mali',
      'Mozambique',
      'Pakistan',
      'Palestine',
      'Sri Lanka',
      'Uganda',
      'Venezuela'
    ];
    const midRiskCountries = [
      'Lebanon',
      'Myanmar',
      'Niger',
      'Nigeria',
      'Poland',
      'Sudan',
      'Syria'
    ];
    const highRiskCountries = [
      'Afghanistan',
      'Democratic Republic of the Congo',
      'Ethiopia',
      'Somalia',
      'South Sudan',
      'Ukraine',
      'Yemen',
      'Israel'
    ];

    if (lowRiskCountries.contains(countryName) && _showLowRisk) {
      return Colors.yellow;
    } else if (midRiskCountries.contains(countryName) && _showMidRisk) {
      return Colors.orange;
    } else if (highRiskCountries.contains(countryName) && _showHighRisk) {
      return Colors.red;
    } else {
      return GREY_COLOR;
    }
  }

  MapDataLabelSettings _getDataLabelSettings() {
    if (_currentZoomLevel >= 10) {
      // 줌 레벨이 10 이상일 때
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.visible,
        textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times',
          fontSize: 18,
        ),
      );
    } else if (_currentZoomLevel >= 7) {
      // 줌 레벨이 6 이상이지만 8 미만일 때
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.ellipsis,
        textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times',
          fontSize: 15,
        ),
      );
    } else {
      // 그 외의 경우 (줌 레벨이 6 미만일 때)
      return const MapDataLabelSettings(
        overflowMode: MapLabelOverflow.hide,
        textStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'Times',
          fontSize: 12,
        ),
      );
    }
  }

  void _showCustomModal(BuildContext context, String countryName) {
    showDialog(
      context: context,
      barrierDismissible: true, // 사용자가 모달 바깥을 탭하면 모달이 닫히도록 설정
      barrierColor: Colors.black.withOpacity(0.5), // 배경을 흐릿하게 처리
      builder: (BuildContext context) {
        return Dialog(
          child: _buildCustomCard(), // 여기서 _buildCustomCard()는 모달의 내용을 구성
        );
      },
    );
  }


  final maxHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text('World Conflict Map'),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: maxHeight * 0.8,
              child: Stack(
                children: [
                  SfMaps(
                    layers: [
                      MapShapeLayer(
                        // MapShapeLayer 위젯의 onSelectionChanged 콜백에서 호출
                        onSelectionChanged: (int index) {
                          setState(() {
                            final String countryName = _dataSource.dataLabelMapper!(index);
                            if (importantCountries.contains(countryName)) {
                              // 선택한 국가가 importantCountries에 포함되어 있으면, 모달을 띄움
                              _showCustomModal(context, countryName);
                            }
                          });
                        },
                        source: _dataSource,
                        zoomPanBehavior: _zoomPanBehavior,
                        showDataLabels: true,
                        dataLabelSettings: _getDataLabelSettings(),
                        onWillZoom: (MapZoomDetails details) {
                          setState(() {
                            if (details.newZoomLevel != null) {
                              print(
                                  "Zoom Level before zoom!!!!!!: ${details.previousZoomLevel}");
                              print(
                                  "Zoom Level after zoom!!!!!!: ${details.newZoomLevel}");
                              _currentZoomLevel = details.newZoomLevel!;
                              _updateDataSource();
                            }
                          });
                          return true;
                        },
                        selectionSettings: MapSelectionSettings(
                          color: Colors.indigo,
                          strokeColor: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 10,
                    child: Row(
                      children: [
                        _riskLevelButton(
                            'Caution', _showLowRisk, Colors.yellow),
                        _riskLevelButton('Alert', _showMidRisk, Colors.orange),
                        _riskLevelButton(
                            'Emergency', _showHighRisk, Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _riskLevelButton(String riskLevel, bool isSelected, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          print('now is time@@@@');
          setState(() {
            if (riskLevel == 'Caution') {
              _showLowRisk = !_showLowRisk;
            } else if (riskLevel == 'Alert') {
              _showMidRisk = !_showMidRisk;
            } else if (riskLevel == 'Emergency') {
              _showHighRisk = !_showHighRisk;
            }
            _updateDataSource();
          });
        },
        child: Text(riskLevel),
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.indigo : Colors.black,
          primary: isSelected ? color : GREY_COLOR,
        ),
      ),
    );
  }
}

// 중요 국가 목록
const importantCountries = {
  'Bangladesh',
  'Burkina Faso',
  'Colombia',
  'Haiti',
  'Iraq',
  'Kenya',
  'Mali',
  'Mozambique',
  'Pakistan',
  'Palestine',
  'Sri Lanka',
  'Uganda',
  'Venezuela',
  'Lebanon',
  'Myanmar',
  'Niger',
  'Nigeria',
  'Poland',
  'Sudan',
  'Syria',
  'Afghanistan',
  'Democratic Republic of the Congo',
  'Ethiopia',
  'Somalia',
  'South Sudan',
  'Ukraine',
  'Yemen',
  'Israel'
};

const GREY_COLOR = Color(0xFFD0D0DA);

Widget _buildCustomCard() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    height:280,
    child: Column(
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(4.0)), // 이미지 상단 모서리만 둥글게 처리
              child: Image.asset(
                'assets/sample.png', // 이미지 경로
                width: 300,
                height: 150,
                fit: BoxFit.cover, // 이미지가 컨테이너에 꽉 차게
              ),
            ),
            Positioned(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'EMERGENCY',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: Text(
                'Help the people',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18, // 텍스트 배경 투명도 조절
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Casualties: 50,000',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  // 버튼 클릭 이벤트 처리
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[300], // 버튼 색상
                ),
                child: Text(
                  'Sending Waves',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// shapeTooltipBuilder: (BuildContext context, int index) {
//   if (importantCountries
//       .contains(_dataSource.dataLabelMapper!(index)))
//     return _buildCustomCard();
//   return Container(
//     width: 250,
//     padding: const EdgeInsets.all(10),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Stack(
//           children: [
//             Center(
//               // print('Selected country: ${_dataSource.dataLabelMapper!(index)}');
//               child: Text(
//                 _dataSource.dataLabelMapper!(index),
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: Theme.of(context)
//                         .textTheme
//                         .bodyText2!
//                         .fontSize),
//               ),
//             ),
//             const Icon(
//               Icons.tour,
//               color: Colors.white,
//               size: 16,
//             ),
//           ],
//         ),
//         const Divider(
//           color: Colors.white,
//           height: 10,
//           thickness: 1.2,
//         ),
//       ],
//     ),
//   );
// },