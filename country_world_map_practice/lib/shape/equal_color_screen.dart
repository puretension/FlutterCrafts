import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// ⭐️1-2-3단계 위기 단계에 따른 색상 지정시 필요 ✅
class EqualColorScreen extends StatefulWidget {
  EqualColorScreen({Key? key}) : super(key: key);

  @override
  _EqualColorScreenState createState() => _EqualColorScreenState();
}

class _EqualColorScreenState extends State<EqualColorScreen> {
  late List<Model> data;
  late MapShapeSource dataSource;

  @override
  void initState() {
    data = <Model>[
      Model('India', "Low"),
      Model('United States of America', "High"),
      Model('Pakistan', "Low"),
      Model('Indonesia', "Low"),
      Model('Ukraine', "High"),
      Model('Yemen', "Mid"),
      Model('Afghanistan', "Mid"),
      Model('Russia', "Mid"),
    ];

    dataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "name",
      dataCount: data.length,
      primaryValueMapper: (int index) {
        return data[index].country;
      },
      shapeColorValueMapper: (int index) {
        return data[index].storage;
      },
      shapeColorMappers: [
        MapColorMapper(value: "Low", color: Colors.red),
        MapColorMapper(value: "Mid", color: Colors.blue),
        MapColorMapper(value: "High", color: Colors.green),
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
            MapShapeLayer(source: dataSource),
          ],
        ),
      ),
    );
  }
}
  class Model {
  const Model(this.country, this.storage);

  final String country;
  final String storage;
  }