import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


// MapZoomPanBehavior(), zoom in zoom out ✅
// initial lat, lng setting ✅
class TooltipShapeLayerScreen extends StatefulWidget {
  TooltipShapeLayerScreen({Key? key}) : super(key: key);

  @override
  _TooltipShapeLayerScreenState createState() => _TooltipShapeLayerScreenState();
}

class _TooltipShapeLayerScreenState extends State<TooltipShapeLayerScreen> {
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
      DataModel('Algeria', Colors.green, 36232),
      DataModel('Libya', Colors.teal, 34121),
      DataModel('Egypt', Colors.blue, 43453),
      DataModel('Mali', Colors.purple, 28123),
      DataModel('Niger', Colors.indigo, 40111),
      DataModel('Nigeria', Colors.purpleAccent, 30232),
      DataModel('Chad', Colors.lightGreen, 48132),
      DataModel('Sudan', Colors.redAccent, 52654),
      DataModel('Mauritania', Colors.orange, 42231),
      DataModel('South Sudan', Colors.lime, 40421),
      DataModel('Ethiopia', Colors.greenAccent, 27198)
    ];

    _sublayerSource = MapShapeSource.asset(
      'assets/africa.json',
      shapeDataField: 'name',
      dataCount: _sublayerData.length,
      primaryValueMapper: (int index) => _sublayerData[index].key,
      shapeColorValueMapper: (int index) => _sublayerData[index].color,
    );
    _zoomPanBehavior = MapZoomPanBehavior(
      zoomLevel: 3,
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
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Container(
                    color: _sublayerData[index].color,
                    height: 50,
                    width: 200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text('State: ',
                                style: TextStyle(color: Colors.white)),
                            Text(_sublayerData[index].key,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Population : ',
                                style: TextStyle(color: Colors.white)),
                            Text(_sublayerData[index].size.toStringAsFixed(0),
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataModel {
  DataModel(this.key, this.color, this.size);

  final String key;
  final Color color;
  final double size;
}