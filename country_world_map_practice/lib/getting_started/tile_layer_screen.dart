import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// TileLayer를 사용하여 지도를 표시하고 싶을때 ✅
class TileLayerScreen extends StatefulWidget {
  TileLayerScreen({Key? key}) : super(key: key);

  @override
  _TileLayerScreenState createState() => _TileLayerScreenState();
}

class _TileLayerScreenState extends State<TileLayerScreen> {

  @override
  Widget build(BuildContext context) {
    return SfMaps(
      layers: [
        MapTileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          initialZoomLevel: 1,
        ),
      ],
    );
  }
}
