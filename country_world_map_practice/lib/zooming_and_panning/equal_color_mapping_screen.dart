import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// Range Color Mapping도 가능함. 문서 참고하기

class EqualColorMappingScreen extends StatefulWidget {
  EqualColorMappingScreen({Key? key}) : super(key: key);

  @override
  _EqualColorMappingScreenState createState() => _EqualColorMappingScreenState();
}

class _EqualColorMappingScreenState extends State<EqualColorMappingScreen> {
  late List<Model> data;
  late MapShapeSource sublayerDataSource;
  late MapShapeSource shapeDataSource;

  @override
  void initState() {
    data = <Model>[
      Model('Algeria', "Low"),
      Model('Nigeria', "High"),
      Model('Libya', "High"),
    ];

    shapeDataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: 'continent',
    );

    sublayerDataSource = MapShapeSource.asset(
      "assets/africa.json",
      shapeDataField: "name",
      dataCount: data.length,
      primaryValueMapper: (int index) {
        return data[index].state;
      },
      shapeColorValueMapper: (int index) {
        return data[index].storage;
      },
      shapeColorMappers: [
        MapColorMapper(value: "Low", color: Colors.red),
        MapColorMapper(value: "High", color: Colors.green)
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SfMaps(
          layers: <MapShapeLayer>[
            MapShapeLayer(
              source: shapeDataSource,
              sublayers: [
                MapShapeSublayer(
                  source: sublayerDataSource,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Model {
  const Model(this.state, this.storage);

  final String state;
  final String storage;
}