import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controllers/QuranPageVController.dart';
import 'package:quran_app/controllers/UiPlayerController.dart';
import 'package:quran_app/view/widgets/widgets.dart';

class UiPlayer extends StatelessWidget {
  UiPlayer({super.key});
  UiPlayerController controller = Get.put(UiPlayerController());
  QuranPageVController pageController = Get.put(QuranPageVController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Image.asset(
            'assets/images/other/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                // boxShadow: [
                //   BoxShadow(
                //       color: Colors.black45,
                //       offset: Offset.fromDirection(1, 1)),
                //   BoxShadow(
                //       color: Colors.black45,
                //       offset: Offset.fromDirection(-1, -1))
                // ],
                color: Colors.white.withOpacity(0.3),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_new),
                        onPressed: () => Get.back(),
                        color: Colors.black,
                      ),
                      Text(
                        'القرأن الكريم',
                        style: Get.textTheme.headline6!
                            .copyWith(color: Colors.black),
                      ),
                      IconButton(
                        icon: Icon(Icons.timer_rounded),
                        onPressed: () => Get.bottomSheet(
                            isDismissible: true,
                            enableDrag: true,
                            SleepModeUi()),
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Container(
                    decoration: ShapeDecoration(
                      shape: CircleBorder(
                          side: BorderSide(color: Colors.black, width: 2)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.mosque,
                            size: 100,
                          ),
                          Text(
                            'اقرأ',
                            style: Get.textTheme.headline5!.copyWith(
                                fontFamily: 'tido',
                                color: Get.theme.primaryColor),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Get.theme.backgroundColor,
                      // borderRadius: BorderRadius.only(
                      //     bottomLeft: Radius.circular(20),
                      //     bottomRight: Radius.circular(20))),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Obx(
                            () => Text(
                              pageController
                                  .surahs[pageController.selectedAyah.value]
                                  .name,
                              style: Get.textTheme.headline6,
                            ),
                          ),
                          Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.convertToSplits(
                                      pageController.position.value)),
                                  Slider(
                                      min: 0,
                                      max: pageController.duration.value
                                              .toDouble() ??
                                          1.0,
                                      value: pageController.position.value
                                              .toDouble() ??
                                          0.5,
                                      onChanged: (value) {
                                        pageController.position.value =
                                            value.toInt();
                                        pageController.player.seek(Duration(
                                            seconds:
                                                pageController.position.value));
                                      }),
                                  Text(controller.convertToSplits(
                                      pageController.duration.value)),
                                ],
                              )),
                          ListTile(
                            leading: IconButton(
                              onPressed: () {
                                if (pageController.selectedAyah.value == 0) {
                                  pageController.selectedAyah.value = 113;
                                } else {
                                  pageController.selectedAyah.value =
                                      pageController.selectedAyah.value - 1;
                                }

                                pageController.player.stop();
                                pageController.player.play(UrlSource(
                                    pageController
                                            .Reciters[pageController
                                                .selectedIndex.value]
                                            .links[
                                        pageController.selectedAyah.value]));
                                pageController.isPlaying.value = true;
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 25,
                                color: Get.theme.primaryColor,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                if (pageController.selectedAyah.value == 113) {
                                  pageController.selectedAyah.value = 0;
                                } else {
                                  pageController.selectedAyah.value =
                                      pageController.selectedAyah.value + 1;
                                }
                                pageController.player.stop();
                                pageController.player.play(UrlSource(
                                    pageController
                                            .Reciters[pageController
                                                .selectedIndex.value]
                                            .links[
                                        pageController.selectedAyah.value]));
                                pageController.isPlaying.value = true;
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 25,
                                color: Get.theme.primaryColor,
                              ),
                            ),
                            title: Obx(
                              () => pageController.isPlaying.isFalse
                                  ? InkWell(
                                      onTap: () {
                                        if (pageController.isPaused.isFalse) {
                                          pageController.player.play(UrlSource(
                                              pageController
                                                      .Reciters[pageController
                                                          .selectedIndex.value]
                                                      .links[
                                                  pageController
                                                      .selectedAyah.value]));
                                        } else {
                                          pageController.player.resume();
                                        }
                                        pageController.isPlaying.value = true;
                                      },
                                      child: CircleAvatar(
                                          backgroundColor: Get
                                              .theme.primaryColor
                                              .withOpacity(0.8),
                                          radius: 34,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.play_arrow_rounded,
                                              color: Get.theme.backgroundColor,
                                              size: 30,
                                            ),
                                          )),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        pageController.isPlaying.value = false;
                                        pageController.player.pause();
                                      },
                                      child: CircleAvatar(
                                          backgroundColor:
                                              Get.theme.primaryColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.pause_rounded,
                                              color: Get.theme.backgroundColor,
                                            ),
                                          )),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
