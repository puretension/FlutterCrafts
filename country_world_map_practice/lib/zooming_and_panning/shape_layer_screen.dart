import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


// MapZoomPanBehavior(), zoom in zoom out ✅
// initial lat, lng setting ✅
class ShapeLayerScreen extends StatefulWidget {
  ShapeLayerScreen({Key? key}) : super(key: key);

  @override
  _ShapeLayerScreenState createState() => _ShapeLayerScreenState();
}

class _ShapeLayerScreenState extends State<ShapeLayerScreen> {
  late MapZoomPanBehavior _zoomPanBehavior;
  late MapShapeSource _dataSource;
  late MapShapeSource _sublayerSource;

  @override
  void initState() {
    super.initState();
    _dataSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'continent',
    );
    // 1. zooming and panning
    // _zoomPanBehavior = MapZoomPanBehavior();

    // 2. zooming and panning, default zoom level, double tap zooming ✅
    _zoomPanBehavior = MapZoomPanBehavior(
      focalLatLng: MapLatLng(47.1751, 78.0421), // initial lat, lng setting ✅
      zoomLevel: 1, // initial zoom level setting ✅
      enableDoubleTapZooming: true, // double tap zooming ✅
      minZoomLevel: 3,
      maxZoomLevel: 10,
    );
    //3. sublayer
    _sublayerSource = MapShapeSource.asset(
      'assets/africa.json',
      shapeDataField: 'name',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Map'),
      ),
      body: Column(
        children: [
          Container(
            height: 400,
            child: SfMaps(
              layers: [
                MapShapeLayer(
                  source: _dataSource,
                  zoomPanBehavior: _zoomPanBehavior,
                  sublayers: [
                    MapShapeSublayer(
                      source: _sublayerSource,
                      color: Colors.red,
                      strokeWidth: 2,
                      strokeColor: Colors.yellow[800],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            child: Text('Change zoomLevel'),
            // onPressed -> automatic zoom-in, zoom out ✅
            onPressed: () {
              _zoomPanBehavior.zoomLevel = 9;
            },
          ),
        ],
      ),
    );
  }
}