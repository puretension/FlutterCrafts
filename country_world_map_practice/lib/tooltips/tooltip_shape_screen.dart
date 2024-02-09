import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


// 화면 전체 맵, 국가 선택되었을때 색상 변경, zoom in-zoom out ✅
class TooltipShapeScreen extends StatefulWidget {
  TooltipShapeScreen({Key? key}) : super(key: key);

  @override
  _TooltipShapeScreenState createState() => _TooltipShapeScreenState();
}

class _TooltipShapeScreenState extends State<TooltipShapeScreen> {
  late List<Model> _data;
  late MapShapeSource _shapeSource;

  @override
  void initState() {
    super.initState();

    _data = <Model>[
      Model('Asia', 50, '44,579,000 sq. km.'),
      Model('Africa', 54, '30,370,000 sq. km.'),
      Model('Europe', 51, '10,180,000 sq. km.'),
      Model('North America', 23, '24,709,000 sq. km.'),
      Model('South America', 12, '17,840,000 sq. km.'),
      Model('Australia', 14, '8,600,000 sq. km.'),
    ];

    _shapeSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "continent",
      dataCount: _data.length,
      primaryValueMapper: (int index) => _data[index].continent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SfMaps(
          layers: [
            MapShapeLayer(
              source: _shapeSource,
              shapeTooltipBuilder: (BuildContext context, int index) {
                return Container(
                  width: 180, // ⭐️
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        //// ⭐️
                        children: [
                          Center(
                            child: Text(
                              _data[index].continent,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText2!
                                      .fontSize),
                            ),
                          ),
                          const Icon(
                            Icons.map,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                        height: 10,
                        thickness: 1.2,
                      ),
                      Text(
                        'Area : ' + _data[index].area,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                            Theme
                                .of(context)
                                .textTheme
                                .bodyText2!
                                .fontSize),
                      ),
                    ],
                  ),
                );
              },
              tooltipSettings: const MapTooltipSettings(
                  color: Colors.black,
                  strokeColor: Color.fromRGBO(252, 187, 15, 1),
                  strokeWidth: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}


class Model {
  const Model(this.continent, this.countriesCount, this.area);

  final String continent;
  final double countriesCount;
  final String area;
}