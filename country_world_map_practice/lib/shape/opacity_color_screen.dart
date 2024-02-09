import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// color 연하게 ✅
class OpacityColorScreen extends StatefulWidget {
  OpacityColorScreen({Key? key}) : super(key: key);

  @override
  _OpacityColorScreenState createState() => _OpacityColorScreenState();
}

class _OpacityColorScreenState extends State<OpacityColorScreen> {
  late List<Model> data;
  late MapShapeSource dataSource;

  @override
  void initState() {
    data = <Model>[
      Model('India', 280),
      Model('United States of America', 190),
      Model('Kazakhstan', 37),
    ];

    dataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "name",
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].country,
      shapeColorValueMapper: (int index) => data[index].count,
      shapeColorMappers: [
        MapColorMapper(
          from: 0,
          to: 100,
          color: Colors.red,
          minOpacity: 0.2,
          maxOpacity: 0.4,
        ),
        MapColorMapper(
          from: 101,
          to: 300,
          color: Colors.green,
          minOpacity: 0.4,
          maxOpacity: 0.6,
        ),
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
          layers: [
            MapShapeLayer(source: dataSource),
          ],
        ),
      ),
    );
  }
}

class Model {
  const Model(this.country, this.count);

  final String country;
  final double count;
}