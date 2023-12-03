import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/models/news_post_model.dart';

class NewsPostWidget extends StatefulWidget {
  const NewsPostWidget({
    super.key,
    required this.index,
    required this.itemList,
  });
  final int index;
  final List<NewsPostModel> itemList;

  @override
  State<NewsPostWidget> createState() => _NewsPostWidgetState();
}

class _NewsPostWidgetState extends State<NewsPostWidget> {
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
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: PageView.builder(
              itemCount: widget.itemList[widget.index].getImages().length,
              onPageChanged: (value) {
                setState(() {
                  currentPostImage = value;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        widget.itemList[widget.index].getImages()[index],
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                widget.itemList[widget.index].getImages().length,
                (index) => widget.itemList[widget.index].getImages().length == 1
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
          const SizedBox(height: 10),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Text(
              widget.itemList[widget.index].getText(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: kWhiteColor),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
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
                      image: DecorationImage(
                        image: AssetImage(
                            widget.itemList[widget.index].getProfileImage()),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                        ),
                        child: Text(
                          widget.itemList[widget.index].getUserName(),
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    letterSpacing: -1,
                                    fontSize: 15,
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.6,
                        ),
                        child: Text.rich(
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    letterSpacing: -0.5,
                                    fontSize: 12,
                                    color: kWhiteColor,
                                  ),
                          TextSpan(
                            text:
                                '${widget.itemList[widget.index].getPostedDateYear().toString()}-',
                            children: [
                              TextSpan(
                                text:
                                    '${widget.itemList[widget.index].getPostedDateMonth().toString()}-',
                                children: [
                                  TextSpan(
                                    text: widget.itemList[widget.index]
                                        .getPostedDateDay()
                                        .toString(),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.bookmark_border_rounded,
                  color: kWhiteColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
