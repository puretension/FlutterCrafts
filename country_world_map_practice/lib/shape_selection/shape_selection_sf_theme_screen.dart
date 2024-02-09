import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// 선택되었을때 색상 변경, zoom in-zoom out ✅
class ShapeSelectionSFThemeScreen extends StatefulWidget {
  ShapeSelectionSFThemeScreen({Key? key}) : super(key: key);

  @override
  _ShapeSelectionSFThemeScreenState createState() => _ShapeSelectionSFThemeScreenState();
}

class _ShapeSelectionSFThemeScreenState extends State<ShapeSelectionSFThemeScreen> {
  late List<Model> data;
  late MapShapeSource dataSource;
  int selectedIndex = 5;

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
          height: 350,
          child: Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: SfMapsTheme(
                data: SfMapsThemeData(
                  selectionColor: Colors.orange,
                  selectionStrokeWidth: 3,
                  selectionStrokeColor: Colors.red[900],
                ),
                child: SfMaps(
                  layers: [
                    MapShapeLayer(
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
              )
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