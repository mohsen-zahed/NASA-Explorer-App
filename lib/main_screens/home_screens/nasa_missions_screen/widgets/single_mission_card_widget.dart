import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/models/nasa_missions_model.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class SingleMissionCardWidget extends StatefulWidget {
  const SingleMissionCardWidget({
    super.key,
    required this.fetchedMissionsList,
    required this.index,
  });

  final List<NasaMissionModel> fetchedMissionsList;
  final int index;

  @override
  State<SingleMissionCardWidget> createState() =>
      _SingleMissionCardWidgetState();
}

class _SingleMissionCardWidgetState extends State<SingleMissionCardWidget> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: getMaxWidthMediaQuery(context),
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.fromLTRB(20, 0, 20,
          widget.index == widget.fetchedMissionsList.length - 1 ? 30 : 10),
      decoration: BoxDecoration(
        color: kGreyColor800,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: SizedBox(
                width: double.infinity,
                height: widget.fetchedMissionsList[widget.index]
                        .getMissionImageUrl()
                        .isEmpty
                    ? getMaxHieghtMediaQuery(context, 0.17)
                    : null,
                child: widget.fetchedMissionsList[widget.index]
                        .getMissionImageUrl()
                        .isEmpty
                    ? Center(child: showLottieLoader())
                    : CachedNetworkImage(
                        imageUrl: widget.fetchedMissionsList[widget.index]
                            .getMissionImageUrl(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const ShimmerEffect(),
                      ),
              ),
            ),
          ),
          ExpansionTile(
            childrenPadding: const EdgeInsets.all(10),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            tilePadding: const EdgeInsets.symmetric(horizontal: 10),
            shape: InputBorder.none,
            collapsedIconColor: kWhiteColor,
            iconColor: kWhiteColor,
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Text(
                    widget.fetchedMissionsList[widget.index].getMissionName(),
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kWhiteColor,
                          fontSize: 18,
                          letterSpacing: 2,
                        ),
                  ),
                ),
                isExpanded
                    ? const SizedBox()
                    : ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width,
                        ),
                        child: Text(
                          widget.fetchedMissionsList[widget.index]
                              .getMissionSubtitle(),
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: kWhiteColor,
                                  ),
                        ),
                      ),
              ],
            ),
            initiallyExpanded: isExpanded,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: getMaxWidthMediaQuery(context, 0.8)),
                child: Text(
                  '"${widget.fetchedMissionsList[widget.index].getMissionSubtitle()}"',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: kWhiteColor),
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 10),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Text(
                  widget.fetchedMissionsList[widget.index]
                      .getMissionExplanation(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: kWhiteColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
