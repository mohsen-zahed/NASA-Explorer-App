import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/functions/functions.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/astronaut_figures_screen/astronauts_figures_screen.dart';
import 'package:nasa_explorer_app_project/main_screens/home_screens/widgets/title_with_view_all_button.dart';
import 'package:nasa_explorer_app_project/models/astronaut_model.dart';
import 'package:nasa_explorer_app_project/widgets/shimmer_effect.dart';

class HorizontalAstronautFiguresSlider extends StatefulWidget {
  const HorizontalAstronautFiguresSlider({
    super.key,
    required this.astList,
    required this.onListViewTap,
  });
  final List<AstronautModel> astList;
  final VoidCallback onListViewTap;

  @override
  State<HorizontalAstronautFiguresSlider> createState() =>
      _HorizontalAstronautFiguresSliderState();
}

class _HorizontalAstronautFiguresSliderState
    extends State<HorizontalAstronautFiguresSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TitleWithViewAllButton(
            title: 'Astronaut Figures',
            onViewAllTap: () {
              Navigator.pushNamed(
                context,
                AstronautFiguresScreen.id,
                arguments: {
                  'astrList': widget.astList,
                },
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: widget.onListViewTap,
          child: SizedBox(
            width: double.infinity,
            height: widget.astList.isEmpty
                ? getMaxHieghtMediaQuery(context, 0.12)
                : getMaxHieghtMediaQuery(context, 0.15),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...List.generate(
                  widget.astList.isEmpty ? 5 : widget.astList.length,
                  (index) => widget.astList.isEmpty
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 15 : 0,
                            right: index == 5 ? 0 : 10,
                          ),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: const ShimmerEffect(
                                  width: 90,
                                  height: 90,
                                ),
                              ),
                              SizedBox(
                                height: getMaxHieghtMediaQuery(context, 0.01),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 15 : 0,
                            right: index == widget.astList.length - 1 ? 0 : 15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 90,
                                height: 90,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: kWhiteColor70),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.astList[index]
                                        .getAstronautImage(),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 85,
                                ),
                                child: Text(
                                  widget.astList[index].getAstronautName(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
