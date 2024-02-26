import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/models/astronaut_model.dart';
import 'package:nasa_explorer_app_project/widgets/custom_circular_progress_indicator.dart';

class AstronautFiguresScreen extends StatefulWidget {
  const AstronautFiguresScreen({super.key});
  static const String id = '/astronauts_screen';

  @override
  State<AstronautFiguresScreen> createState() => _AstronautFiguresScreenState();
}

class _AstronautFiguresScreenState extends State<AstronautFiguresScreen> {
  List<AstronautModel> astrList = [];
  Future<void> fetchAstronautData() async {
    try {
      astrList.clear();
      await FirebaseFirestore.instance
          .collection('NasaAstronautsData')
          .orderBy('id', descending: false)
          .get()
          .then((value) {
        for (var element in value.docs) {
          astrList.add(
            AstronautModel.create(
              id: element.data()['id'],
              anstronautName: element.data()['astronautName'],
              dateOfBirth: element.data()['astronautDateOfBirth'],
              placeOfBirth: element.data()['astronautPlaceOfBirth'],
              astronautBiography: element.data()['astronautBiography'],
              astronautMissions: element.data()['astronautMissions'],
              astronautImage: element.data()['imageUrl'],
            ),
          );
        }
        if (mounted) {
          setState(() {
            astrList = astrList;
          });
        }
      });
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchAstronautData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppWidget(text: 'Astronuats Figures'),
      body: SingleChildScrollView(
        child: SizedBox(
          height: getMaxHieghtMediaQuery(context),
          child: astrList.isEmpty
              ? const Center(
                  child: CustomCircularProgressIndicator(
                      indicatorColor: kWhiteColor),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                    children: [
                      ...List.generate(
                        astrList.length,
                        (index) => AstronautProfWidget(
                          astrList: astrList,
                          index: index,
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class AstronautProfWidget extends StatelessWidget {
  const AstronautProfWidget({
    super.key,
    required this.astrList,
    required this.index,
  });

  final List<AstronautModel> astrList;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: getMaxWidthMediaQuery(context, 0.43),
          height: getMaxHieghtMediaQuery(context, 0.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                astrList[index].getAstronautImage(),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: getMaxWidthMediaQuery(context, 0.4),
          ),
          child: Text(
            astrList[index].getAstronautName(),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kWhiteColor, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: getMaxWidthMediaQuery(context, 0.5),
              ),
              child: Text(
                astrList[index].getDateOfBirth(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: kWhiteColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Text(
              ' | ',
              style: TextStyle(color: kWhiteColor, fontWeight: FontWeight.w300),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: getMaxWidthMediaQuery(context, 0.25),
              ),
              child: Text(
                astrList[index].getPlaceOfBirth(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: kWhiteColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                    ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ],
    );
  }
}
