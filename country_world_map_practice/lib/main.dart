import 'package:country_world_map_practice/data_labels/appearance_customization_screen.dart';
import 'package:country_world_map_practice/data_labels/overflow_mode_screen.dart';
import 'package:country_world_map_practice/data_labels/show_data_labels_screen.dart';
import 'package:country_world_map_practice/data_labels/text_customization_screen.dart';
import 'package:country_world_map_practice/getting_started/asset_bundle_screen.dart';
import 'package:country_world_map_practice/getting_started/network_screen.dart';
import 'package:country_world_map_practice/getting_started/shape_layer_map_screen.dart';
import 'package:country_world_map_practice/getting_started/tile_layer_screen.dart';
import 'package:country_world_map_practice/shape/applying_color_screen.dart';
import 'package:country_world_map_practice/shape/equal_color_screen.dart';
import 'package:country_world_map_practice/shape/hover_color_screen.dart';
import 'package:country_world_map_practice/shape/loading_builder_screen.dart';
import 'package:country_world_map_practice/shape_selection/shape_selection_changed_screen.dart';
import 'package:country_world_map_practice/shape_selection/shape_selection_sf_theme_screen.dart';
import 'package:country_world_map_practice/tooltips/tooltip_modal_screen.dart';
import 'package:country_world_map_practice/tooltips/tooltip_shape_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: TooltipModalScreen(), // Set GeoJSON data for shape layer from asset bundle
    );
  }
}



