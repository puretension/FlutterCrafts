import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// 사용자에게 loading indicator를 보여주고 싶을때 ✅
// stroke color, stroke width, color를 통해 대륙/국가 색깔, 경계선 색 설정 ✅
class ApplyingColorScreen extends StatefulWidget {
  ApplyingColorScreen({Key? key}) : super(key: key);

  @override
  _ApplyingColorScreenState createState() => _ApplyingColorScreenState();
}

class _ApplyingColorScreenState extends State<ApplyingColorScreen> {
  late List<Model> data;
  late MapShapeSource dataSource;

  @override
  void clear() {
    print('Clearing cache!');
    setState(() {
      data.clear();
    });
  }

  @override
  void initState() {
    data = const <Model>[
      Model('Asia', Colors.red),
      Model('Africa', Color.fromRGBO(51, 102, 255, 0.8)),
      Model('Europe', Color.fromRGBO(0, 57, 230, 0.8)),
      Model('South America', Color.fromRGBO(0, 51, 204, 0.8)),
      Model('Australia', Color.fromRGBO(0, 45, 179, 0.8)),
      Model('North America', Color.fromRGBO(0, 38, 153, 0.8)),
    ];

    dataSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'continent',
      dataCount: data.length,
      primaryValueMapper: (int index) => data[index].country,
      shapeColorValueMapper: (int index) => data[index].color,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 350,
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: SfMaps(
              layers: <MapLayer>[
                MapShapeLayer(
                  source: dataSource,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Model {
  const Model(this.country, this.color);

  final String country;
  final Color color;
}
