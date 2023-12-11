import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/variables.dart';
import 'package:nasa_explorer_app_project/models/news_model.dart';

class NewsPostWidget extends StatefulWidget {
  const NewsPostWidget({
    super.key,
    required this.index,
    required this.itemList,
  });
  final int index;
  final List<NewsModel> itemList;

  @override
  State<NewsPostWidget> createState() => _NewsPostWidgetState();
}

class _NewsPostWidgetState extends State<NewsPostWidget> {
  bool isExpanded = false;
  int currentPostImage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 15,
      ),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: kCardBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //! image place holder widget
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: PageView.builder(
              itemCount: 1,
              onPageChanged: (value) {
                setState(() {
                  currentPostImage = value;
                });
              },
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl: widget.itemList[widget.index].getUrl(),
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Lottie.asset('assets/images/loading_image.json'),
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          //! three dot indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                0,
                (index) => widget.itemList[widget.index].getUrl().length == 1
                    ? const SizedBox()
                    : AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 5,
                        height: 5,
                        margin: const EdgeInsets.only(right: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: index == currentPostImage
                              ? kWhiteColor
                              : kGreyColor,
                        ),
                      ),
              )
            ],
          ),
          //! expandable widget for texts
          ExpansionTile(
            childrenPadding: const EdgeInsets.all(0),
            tilePadding: const EdgeInsets.symmetric(horizontal: 5),
            shape: InputBorder.none,
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            title: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Text(
                widget.itemList[widget.index].getTitle(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: kWhiteColor,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
              ),
            ),
            initiallyExpanded: isExpanded,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                ),
                child: Text(
                  widget.itemList[widget.index].getexplanation(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: kWhiteColor),
                ),
              ),
            ],
          ),
          //! parent row: one for profile,name,date another for bookmark icon
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //! the first row child
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                        border: Border.all(
                          color: kWhiteColor70,
                          width: 1.5,
                        ),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: demoProfileImageHolder,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Image.network(demoImagePlaceHolder),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.3,
                            maxHeight: 50,
                          ),
                          child: Text(
                            widget.itemList[widget.index].getCopyRight(),
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  letterSpacing: -1,
                                  fontSize: 15,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Text(
                          widget.itemList[widget.index].getDate(),
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    letterSpacing: -0.5,
                                    fontSize: 12,
                                    color: kWhiteColor,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
                //! the second child
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    Icons.bookmark_border_rounded,
                    color: kWhiteColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
