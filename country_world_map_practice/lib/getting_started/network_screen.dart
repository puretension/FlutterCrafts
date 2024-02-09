import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// network에서 GeoJSON 데이터를 가져와서 shape layer에 설정 ✅
class NetworkScreen extends StatefulWidget {
  NetworkScreen({Key? key}) : super(key: key);

  @override
  _NetworkScreenState createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  late MapShapeSource _dataSource;

  @override
  void initState() {
    _dataSource = MapShapeSource.network(
        'http://www.json-generator.com/api/json/get/bVqXoJvfjC?indent=2',
      shapeDataField: 'network',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SfMaps(
          layers: [
            MapShapeLayer(source: _dataSource),
          ],
        ),
      ),
    );
  }
}
