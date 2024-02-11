import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


// 화면 전체 맵, 국가 선택되었을때 색상 변경, zoom in-zoom out ✅
class AnimationVectorLayerScreen extends StatefulWidget {
  AnimationVectorLayerScreen({Key? key}) : super(key: key);

  @override
  _AnimationVectorLayerScreenState createState() => _AnimationVectorLayerScreenState();
}

class _AnimationVectorLayerScreenState extends State<AnimationVectorLayerScreen> with SingleTickerProviderStateMixin {
  late MapShapeSource dataSource;
  late List<DataModel> data;
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    data = <DataModel>[
      DataModel(MapLatLng(28.7041, 77.1025), MapLatLng(56.1304, -106.3468)),
      DataModel(MapLatLng(28.7041, 77.1025), MapLatLng(-9.1900, -75.0152)),
      DataModel(MapLatLng(28.7041, 77.1025), MapLatLng(61.5240, 105.3188)),
      DataModel(MapLatLng(28.7041, 77.1025), MapLatLng(-25.2744, 133.7751)),
    ];

    dataSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'continent',
    );

    animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    animationController.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Map',),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SfMaps(layers: [
          MapShapeLayer(
            source: dataSource,
            sublayers: [
              MapLineLayer(
                lines: List<MapLine>.generate(data.length, (int index) {
                  return MapLine(
                    from: data[index].from,
                    to: data[index].to,
                  );
                }).toSet(),
                color: Colors.red,
                animation: animation as Animation<double>?,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

class DataModel {
  DataModel(this.from, this.to);

  final MapLatLng from;
  final MapLatLng to;
}