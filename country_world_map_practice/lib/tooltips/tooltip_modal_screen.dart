import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_maps/maps.dart';


// 화면 전체 맵, 국가 선택되었을때 색상 변경, zoom in-zoom out ✅
class TooltipModalScreen extends StatefulWidget {
  TooltipModalScreen({Key? key}) : super(key: key);

  @override
  _TooltipModalScreenState createState() => _TooltipModalScreenState();
}

class _TooltipModalScreenState extends State<TooltipModalScreen> {
  late List<WorldWonderModel> _data;
  late MapShapeSource _shapeSource;

  @override
  void initState() {
    super.initState();

    _data = <WorldWonderModel>[
      WorldWonderModel(
          place: 'Chichen Itza',
          country: 'Mexico',
          latitude: 20.6843,
          longitude: -88.5678),
      WorldWonderModel(
          place: 'Machu Picchu',
          country: 'Peru',
          latitude: -13.1631,
          longitude: -72.5450),
      WorldWonderModel(
          place: 'Christ the Redeemer',
          country: 'Brazil',
          latitude: -22.9519,
          longitude: -43.2105),
      WorldWonderModel(
          place: 'Colosseum',
          country: 'Rome',
          latitude: 41.8902,
          longitude: 12.4922),
      WorldWonderModel(
          place: 'Petra',
          country: 'Jordan',
          latitude: 30.3285,
          longitude: 35.4444),
      WorldWonderModel(
          place: 'Taj Mahal',
          country: 'India',
          latitude: 27.1751,
          longitude: 78.0421),
      WorldWonderModel(
          place: 'Great Wall of China',
          country: 'China',
          latitude: 40.4319,
          longitude: 116.5704)
    ];

    _shapeSource = MapShapeSource.asset(
      "assets/world_map.json",
      shapeDataField: "country",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SfMaps(
          layers: [
            MapShapeLayer(
              source: _shapeSource,
              initialMarkersCount: _data.length,
              markerBuilder: (BuildContext context, int index) {
                return MapMarker(
                  latitude: _data[index].latitude,
                  longitude: _data[index].longitude,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                  ),
                );
              },
              markerTooltipBuilder: (BuildContext context, int index) {
                return Container(
                  width: 150,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Text(
                              _data[index].country,
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
                            Icons.tour,
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
                        _data[index].place,
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
                  color: Colors.red,
                  strokeColor: Colors.black,
                  strokeWidth: 1.5,
              hideDelay: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class WorldWonderModel {
  const WorldWonderModel(
  {required this.place,
  required this.country,
  required this.latitude,
  required this.longitude});

  final String place;
  final String country;
  final double latitude;
  final double longitude;
}