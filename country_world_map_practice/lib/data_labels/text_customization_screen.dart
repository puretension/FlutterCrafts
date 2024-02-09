import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

//  ⭐Text(data label) 커스텀 하고 싶을때 ✅
class TextCustomizationScreen extends StatefulWidget {
  TextCustomizationScreen({Key? key}) : super(key: key);

  @override
  _TextCustomizationScreenState createState() => _TextCustomizationScreenState();
}

class _TextCustomizationScreenState extends State<TextCustomizationScreen> {
  late List<Model> data;
  late MapShapeSource dataSource;

  @override
  void initState() {
    super.initState();
    data = const <Model>[
      Model('Asia', 'Asia'),
      Model('Europe', 'EU'),
      Model('North America', 'NA'),
      Model('South America', 'SA'),
      Model('Australia', 'Australia'),
      Model('Africa', 'Africa')
    ];

    dataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "continent",
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].continent,
      dataLabelMapper: (int index) => data[index].code,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: SfMaps(
            layers: [
              MapShapeLayer(
                source: dataSource,
                showDataLabels: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Model {
  const Model(this.continent, this.code);

  final String continent;
  final String code;
}