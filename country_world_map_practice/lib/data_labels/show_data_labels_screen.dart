import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// 대륙/국가별 이름 같은 Text(data label) 표시하고 싶을때 ✅

// Set GeoJSON data for shape layer from asset bundle
class ShowDataLabelScreen extends StatefulWidget {
  ShowDataLabelScreen({Key? key}) : super(key: key);

  @override
  _ShowDataLabelScreenState createState() => _ShowDataLabelScreenState();
}

class _ShowDataLabelScreenState extends State<ShowDataLabelScreen> {
  late MapShapeSource dataSource;

  @override
  void initState() {
    dataSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "continent",
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
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
