import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/functions/show_snackbar.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/nasa_missions_screen/widgets/single_mission_card_widget.dart';
import 'package:nasa_explorer_app_project/models/nasa_missions_model.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class NasaMissionsScreen extends StatefulWidget {
  const NasaMissionsScreen({super.key});
  static const String id = '/nasa_missions_screen';

  @override
  State<NasaMissionsScreen> createState() => _NasaMissionsScreenState();
}

class _NasaMissionsScreenState extends State<NasaMissionsScreen> {
  @override
  void initState() {
    super.initState();
    fetchMissionsDataFF();
  }

  List<NasaMissionModel> fetchedMissionsList = [];

  Future<void> fetchMissionsDataFF() async {
    try {
      fetchedMissionsList.clear();
      await FirebaseFirestore.instance
          .collection('NasaMissionsData')
          .orderBy('id', descending: false)
          .get()
          .then(
        (value) {
          for (var element in value.docs) {
            fetchedMissionsList.add(NasaMissionModel.create(
              id: element.data()['id'],
              missionName: element.data()['missionName'],
              missionSubtitle: element.data()['missionSubtitle'],
              missionImageUrl: element.data()['imageUrl'],
              missionExplanation: element.data()['missionIntro'],
              postedBy: element.data()['postedBy'],
              postedDate: element.data()['postedDate'],
            ));
          }
        },
      );
      if (mounted) {
        setState(() {
          fetchedMissionsList = fetchedMissionsList;
        });
      }
    } on FirebaseException catch (e) {
      if (mounted) {
        showSnackBar(context: context, text: e.message.toString(), duration: 4);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppWidget(text: 'NASA\'s Explorations'),
      body: RefreshIndicator(
        onRefresh: () async {
          await fetchMissionsDataFF();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: fetchedMissionsList.isEmpty
              ? Column(
                  children: [
                    ...List.generate(
                      3,
                      (index) => Padding(
                        padding: EdgeInsets.fromLTRB(
                            20, 0, 20, index == 3 ? 30 : 10),
                        child: ShimmerEffect(
                          width: double.infinity,
                          height: getMaxHieghtMediaQuery(context, 0.27),
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    ...List.generate(
                      fetchedMissionsList.length,
                      (index) => SingleMissionCardWidget(
                        index: index,
                        fetchedMissionsList: fetchedMissionsList,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
