import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// 대륙/국가별 이름 같은 Text(data label) 표시하고 싶을때 ✅
class ShapeLayerMapScreen extends StatefulWidget {
  ShapeLayerMapScreen({Key? key}) : super(key: key);

  @override
  _ShapeLayerMapScreenState createState() => _ShapeLayerMapScreenState();
}

class _ShapeLayerMapScreenState extends State<ShapeLayerMapScreen> {
  late List<Model> data;
  late MapShapeSource dataSource;

  @override
  void initState() {
    data = <Model>[
      Model('New South Wales', Color.fromRGBO(255, 215, 0, 1.0),
          '       New\nSouth Wales'),
      Model('Queensland', Color.fromRGBO(72, 209, 204, 1.0), 'Queensland'),
      Model('Northern Territory', Colors.red.withOpacity(0.85),
          'Northern\nTerritory'),
      Model('Victoria', Color.fromRGBO(171, 56, 224, 0.75), 'Victoria'),
      Model('South Australia', Color.fromRGBO(126, 247, 74, 0.75),
          'South Australia'),
      Model('Western Australia', Color.fromRGBO(79, 60, 201, 0.7),
          'Western Australia'),
      Model('Tasmania', Color.fromRGBO(99, 164, 230, 1), 'Tasmania'),
      Model('Australian Capital Territory', Colors.teal, 'ACT')
    ];

    dataSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField: 'STATE_NAME',
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].state,
      dataLabelMapper: (int index) => data[index].stateCode,
      shapeColorValueMapper: (int index) => data[index].color,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.55,
          child: SfMaps(
            layers: <MapShapeLayer>[
              MapShapeLayer(
                source: dataSource,
                showDataLabels: true,
                legend: MapLegend(MapElement.shape),
                shapeTooltipBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(7),
                    child: Text(data[index].stateCode,
                        style: themeData.textTheme.caption!
                            .copyWith(color: themeData.colorScheme.surface)),
                  );
                },
                tooltipSettings: MapTooltipSettings(
                    color: Colors.grey[700],
                    strokeColor: Colors.white,
                    strokeWidth: 2),
                strokeColor: Colors.white,
                strokeWidth: 0.5,
                dataLabelSettings: MapDataLabelSettings(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: themeData.textTheme.caption!.fontSize)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Model {
  Model(this.state, this.color, this.stateCode);

  String state;
  Color color;
  String stateCode;
}