import 'package:flutter/material.dart';
import 'package:nasa_explorer_app_project/constants/colors.dart';
import 'package:nasa_explorer_app_project/constants/list.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/milky-way.jpg'),
            fit: BoxFit.cover,
            opacity: .05,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const WeatherForecastWidget(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 155,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ...List.generate(
                          postList.length,
                          (index) => NewsPostWidget(index: index),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 65)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsPostWidget extends StatefulWidget {
  const NewsPostWidget({
    super.key,
    required this.index,
  });
  final int index;

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
              itemCount: postList[widget.index].getImages().length,
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
                        postList[widget.index].getImages()[index],
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
                postList[widget.index].getImages().length,
                (index) => postList[widget.index].getImages().length == 1
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
              postList[widget.index].getText(),
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
                            postList[widget.index].getProfileImage()),
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
                          postList[widget.index].getUserName(),
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
                                '${postList[widget.index].getPostedDateYear().toString()}-',
                            children: [
                              TextSpan(
                                text:
                                    '${postList[widget.index].getPostedDateMonth().toString()}-',
                                children: [
                                  TextSpan(
                                    text: postList[widget.index]
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
              const Icon(
                Icons.favorite_outline_outlined,
                color: kWhiteColor,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class WeatherForecastWidget extends StatelessWidget {
  const WeatherForecastWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: kWhiteColor30),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Herat',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: kWhiteColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Text(
                'Mostly Cloudly',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: kWhiteColor,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '15^C',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 25,
                      color: kWhiteColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(width: 8),
              Image.asset(
                'assets/images/weather_icons/cloudy.png',
                scale: 25,
              )
            ],
          ),
        ],
      ),
    );
  }
}
