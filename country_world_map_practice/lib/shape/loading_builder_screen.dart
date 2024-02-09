import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// 사용자에게 loading indicator를 보여주고 싶을때 ✅
// stroke color, stroke width, color를 통해 대륙/국가 색깔, 경계선 색 설정 ✅
class LoadingBuilderScreen extends StatefulWidget {
  LoadingBuilderScreen({Key? key}) : super(key: key);

  @override
  _LoadingBuilderScreenState createState() => _LoadingBuilderScreenState();
}

class _LoadingBuilderScreenState extends State<LoadingBuilderScreen> {
  late MapShapeSource dataSource;

  @override
  void initState() {
    dataSource = MapShapeSource.asset(
      'assets/world_map.json',
      shapeDataField: 'continent',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SfMaps(
          layers: <MapLayer>[
            MapShapeLayer(
              source: dataSource,
              color: Colors.blue[300],
              strokeColor: Colors.red,
              strokeWidth: 1,
              loadingBuilder: (BuildContext context) {
                return Container(
                  height: 25,
                  width: 25,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}