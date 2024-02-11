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


// 모든 국가에 대륙이 떠서 대륙 1개당 대륙 뜨게끔 수정만 하면 될듯

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapPage(),
    );
  }
}


class Country {
  Country(this.name, this.continent, this.color);

  final String name;
  final String continent;
  final Color color;
}

Future<List<Country>> loadCountries() async {
  final jsonString = await rootBundle.loadString('assets/world_map.json');
  final jsonResponse = json.decode(jsonString);
  final features = jsonResponse['features'] as List;

  final countries = features.map((feature) {
    final name = feature['properties']['name'];
    final continent = feature['properties']['continent'];
    return Country(name, continent, Colors.grey);
  }).toList();

  return countries;
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapShapeSource _dataSource;
  late MapZoomPanBehavior _zoomPanBehavior;
  late List<Country> countries = [];
  bool _isLoading = true; // 데이터 로딩 상태를 추적하는 변수
  double _currentZoomLevel = 3;
  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = MapZoomPanBehavior(
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
      zoomLevel: _currentZoomLevel,
      minZoomLevel: 1,
      maxZoomLevel: 12,
    );

    loadCountries().then((loadedCountries) {
      setState(() {
        countries = loadedCountries;
        _dataSource = MapShapeSource.asset(
          "assets/world_map.json",
          shapeDataField: "name",
          dataCount: countries.length,
          primaryValueMapper: (int index) => countries[index].name,
          dataLabelMapper: (int index) => _currentZoomLevel <= 5 ? countries[index].continent : countries[index].name,
          shapeColorValueMapper: (int index) => countries[index].color,
        );
        _isLoading = false; // 데이터 로딩 완료
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Conflict Map'),
      ),
      body: _isLoading // _isLoading 상태에 따라 UI를 분기 처리
          ? Center(child: CircularProgressIndicator())
          : SfMaps(
        layers: [
          MapShapeLayer(
            source: _dataSource,
            showDataLabels: true,
            dataLabelSettings: MapDataLabelSettings(
              overflowMode: MapLabelOverflow.ellipsis,
              textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            zoomPanBehavior: _zoomPanBehavior,
            onWillZoom: (MapZoomDetails details) {
              print("Zoom Level before zoom: ${details.previousZoomLevel}");
              return true;
            },
            onWillPan: (MapPanDetails details) {
              print("Current Zoom Level: $_currentZoomLevel");
              return true;
            },
            selectionSettings: MapSelectionSettings(color: Colors.orange, strokeColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
