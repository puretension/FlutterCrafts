import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// 라벨 커스텀하고 싶을때 ✅

// Set GeoJSON data for shape layer from asset bundle
class AppearanceCustomizationScreen extends StatefulWidget {
  AppearanceCustomizationScreen({Key? key}) : super(key: key);

  @override
  _AppearanceCustomizationScreenState createState() => _AppearanceCustomizationScreenState();
}

class _AppearanceCustomizationScreenState extends State<AppearanceCustomizationScreen> {
  late List<Model> data;
  late MapShapeSource dataSource;

  @override
  void initState() {
    data = <Model>[
      Model('New South Wales', 'New South Wales'),
      Model('Queensland', 'Queensland'),
      Model('Northern Territory', 'Northern sTerritory'),
      Model('Victoria', 'Victoria'),
      Model('South Australia', 'South Australia'),
      Model('Western Australia', 'Western Australia'),
      Model('Tasmania', 'Tasmania'),
    ];

    dataSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField: 'STATE_NAME',
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].state,
      dataLabelMapper: (int index) => data[index].dataLabel,
    );
    super.initState();
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
                dataLabelSettings: MapDataLabelSettings(
                  textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'Times'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Model {
  Model(this.state, this.dataLabel);

  String state;
  String dataLabel;
}