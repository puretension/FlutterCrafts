import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// Range Color Mapping도 가능함. 문서 참고하기

class LabelCustomizationScreen extends StatefulWidget {
  LabelCustomizationScreen({Key? key}) : super(key: key);

  @override
  _LabelCustomizationScreenState createState() =>
      _LabelCustomizationScreenState();
}

class _LabelCustomizationScreenState extends State<LabelCustomizationScreen> {
  late MapShapeSource _shapeSource;
  late MapShapeSource _sublayerSource;
  late List<DataModel> _sublayerData;
  late MapZoomPanBehavior _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
    _shapeSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "continent",
    );

    _sublayerData = <DataModel>[
      DataModel('Algeria', Colors.green, 'Algeria'),
      DataModel('Libya', Colors.teal, 'Libya'),
      DataModel('Egypt', Colors.blue, 'Egypt'),
      DataModel('Mali', Colors.purple, 'Mali'),
      DataModel('Niger', Colors.indigo, 'Niger'),
      DataModel('Nigeria', Colors.purpleAccent, 'Nigeria'),
      DataModel('Chad', Colors.lightGreen, 'Chad'),
      DataModel('Sudan', Colors.redAccent, 'Sudan'),
      DataModel('Mauritania', Colors.orange, 'Mauritania'),
      DataModel('South Sudan', Colors.lime, 'South Sudan'),
      DataModel('Ethiopia', Colors.greenAccent, 'Ethiopia')
    ];

    _sublayerSource = MapShapeSource.asset(
      'assets/africa.json',
      shapeDataField: 'name',
      dataCount: _sublayerData.length,
      primaryValueMapper: (int index) => _sublayerData[index].key,
      dataLabelMapper: (int index) => _sublayerData[index].stateCode,
    );
    _zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 4,
      focalLatLng: MapLatLng(38.9637, 35.2433),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfMaps(
        layers: [
          MapShapeLayer(
            source: _shapeSource,
            zoomPanBehavior: _zoomPanBehavior,
            sublayers: [
              MapShapeSublayer(
                source: _sublayerSource,
                showDataLabels: true,
                dataLabelSettings: const MapDataLabelSettings(
                  overflowMode: MapLabelOverflow.ellipsis,
                  textStyle: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'Times',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataModel {
  DataModel(this.key, this.color, this.stateCode);

  final String key;
  final Color color;
  final String stateCode;
}
