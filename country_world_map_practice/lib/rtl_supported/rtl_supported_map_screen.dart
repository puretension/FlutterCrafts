import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// Range Color Mapping도 가능함. 문서 참고하기

class RtlSupportedMapScreen extends StatefulWidget {
  RtlSupportedMapScreen({Key? key}) : super(key: key);

  @override
  _RtlSupportedMapScreenState createState() => _RtlSupportedMapScreenState();
}

class _RtlSupportedMapScreenState extends State<RtlSupportedMapScreen> {
  late List<PopulationModel> _data;
  late MapShapeSource _mapSource;

  @override
  void initState() {
    super.initState();
    _data = <PopulationModel>[
      PopulationModel('Asia', 150, Color.fromRGBO(60, 120, 255, 0.8)),
      PopulationModel('Africa', 45, Color.fromRGBO(51, 102, 255, 0.8)),
      PopulationModel('Europe', 34, Color.fromRGBO(0, 57, 230, 0.8)),
      PopulationModel('South America', 25, Color.fromRGBO(0, 51, 204, 0.8)),
      PopulationModel('North America', 28, Color.fromRGBO(0, 38, 153, 0.8)),
      PopulationModel('Australia', 5, Color.fromRGBO(0, 45, 179, 0.8)),
    ];

    _mapSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "continent",
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].continent,
      shapeColorValueMapper: (int index) => _data[index].color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 15, top: 30),
          height: 350,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: SfMaps(
              layers: [
                MapShapeLayer(
                  source: _mapSource,
                  legend: MapLegend(MapElement.shape),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  class PopulationModel {
  const PopulationModel(
  this.continent, this.populationDensityPerSqKm, this.color);

  final String continent;
  final double populationDensityPerSqKm;
  final Color color;
  }