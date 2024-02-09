import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

// asset bundle에 저장된 GeoJSON 데이터를 사용하여 shape layer에 설정 ✅
class AssetBundleScreen extends StatefulWidget {
  AssetBundleScreen({Key? key}) : super(key: key);

  @override
  _AssetBundleScreenState createState() => _AssetBundleScreenState();
}

class _AssetBundleScreenState extends State<AssetBundleScreen> {
  late MapShapeSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = MapShapeSource.asset(
      'assets/australia.json',
      shapeDataField: 'STATE_NAME',
    );
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
