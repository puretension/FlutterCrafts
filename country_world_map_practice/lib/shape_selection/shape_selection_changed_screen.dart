import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


// 화면 전체 맵, 국가 선택되었을때 색상 변경, zoom in-zoom out ✅
class ShapeSelectionChagnedScreen extends StatefulWidget {
  ShapeSelectionChagnedScreen({Key? key}) : super(key: key);

  @override
  _ShapeSelectionChagnedScreenState createState() => _ShapeSelectionChagnedScreenState();
}

class _ShapeSelectionChagnedScreenState extends State<ShapeSelectionChagnedScreen> {
  late List<Model> data;
  late MapShapeSource dataSource;
  int selectedIndex = 1;

  final maxHeight = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;

  @override
  void initState() {
    super.initState();
    data = const <Model>[
      Model('Asia', 'Asia', Color.fromRGBO(60, 120, 255, 0.8)),
      Model('Africa', 'Africa', Color.fromRGBO(51, 102, 255, 0.8)),
      Model('Europe', 'Europe', Color.fromRGBO(0, 57, 230, 0.8)),
      Model('South America', 'SA', Color.fromRGBO(0, 51, 204, 0.8)),
      Model('Australia', 'Australia', Color.fromRGBO(0, 45, 179, 0.8)),
      Model('North America', 'NA', Color.fromRGBO(0, 38, 153, 0.8))
    ];

    dataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "continent",
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].continent,
      shapeColorValueMapper: (int index) => data[index].color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: maxHeight * 0.9,
          child: SfMaps(
            layers: [
              MapShapeLayer(
                zoomPanBehavior: MapZoomPanBehavior(
                  focalLatLng: MapLatLng(0, 0),
                  zoomLevel: 2.0,
                ),
                source: dataSource,
                selectedIndex: selectedIndex,
                onSelectionChanged: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Model {
  const Model(this.continent, this.code, this.color);

  final String continent;
  final String code;
  final Color color;
}