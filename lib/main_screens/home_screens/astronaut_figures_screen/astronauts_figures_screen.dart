import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/astronaut_model.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class AstronautFiguresScreen extends StatefulWidget {
  const AstronautFiguresScreen({super.key});
  static const String id = '/astronauts_screen';

  @override
  State<AstronautFiguresScreen> createState() => _AstronautFiguresScreenState();
}

class _AstronautFiguresScreenState extends State<AstronautFiguresScreen> {
  var map;
  @override
  Widget build(BuildContext context) {
    map = ModalRoute.of(context)!.settings.arguments;
    List<AstronautModel> astrList = map['astrList'];
    return Scaffold(
      appBar: customAppWidget(text: 'Astronauts Figures'),
      body: SizedBox(
        height: getMaxHieghtMediaQuery(context),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 70,
              backgroundImage: CachedNetworkImageProvider(
                astrList[0].getAstronautImage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
