import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:quran_app/constants/Constants.dart';
import 'package:quran_app/controllers/QuranPageVController.dart';
import 'package:quran_app/main.dart';
import 'package:quran_app/view/custom_widgets/texts.dart';
import 'package:quran_app/view/custom_widgets/utils.dart';
import 'package:quran_app/view/widgets/widgets.dart';

class QuranPageViewer extends StatelessWidget {
  QuranPageViewer({super.key});
  QuranPageVController controller = Get.put(QuranPageVController());

  ArabicNumbers arabicNumber = ArabicNumbers();
  GlobalKey<ScaffoldState> kl = GlobalKey<ScaffoldState>();
  PageController con = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          floatingActionButton: Obx(() =>
              (controller.ThereIsDownloads.isTrue || controller.offline.isFalse)
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Get.theme.primaryColor.withOpacity(0.6),
                        ),
                        child: Obx(
                          () => ListTile(
                            title: GestureDetector(
                              onTap: () => Get.toNamed('/uiplayer'),
                              child: Text(
                                controller
                                    .surahs[controller.selectedAyah.value].name,
                                textAlign: TextAlign.end,
                                style: Get.theme.textTheme.subtitle2!
                                    .copyWith(color: Get.theme.backgroundColor),
                              ),
                            ),
                            leading: !controller.isPlaying.isTrue
                                ? IconButton(
                                    icon: Icon(
                                      Icons.play_arrow_rounded,
                                      color: Get.theme.backgroundColor,
                                    ),
                                    onPressed: () async {
                                      controller.isPlaying.value = true;
                                      controller.isPaused.value = true;

                                      await controller.GetPlayer.play(
                                          UrlSource(controller.link.value));
                                    })
                                : IconButton(
                                    icon: Icon(
                                      Icons.pause_rounded,
                                      color: Get.theme.backgroundColor,
                                    ),
                                    onPressed: () async {
                                      controller.isPlaying.value = false;

                                      await controller.GetPlayer.pause();
                                    }),
                            trailing: CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/reciters/${controller.Reciters[controller.selectedIndex.value].image}')),
                          ),
                        ),
                      ))
                  : Container()),
          key: kl,
          endDrawer: Drawer(
            backgroundColor: Color.fromRGBO(32, 33, 36, 1),
            child: Obx(
              () => ListView.builder(
                itemCount: controller.surahs.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    con.jumpToPage(index);

                    controller.selectedAyah.value = index;
                    if (shares?.getStringList(controller
                            .Reciters[controller.selectedIndex.value]
                            .name)![controller.selectedAyah.value] ==
                        'no') {
                      controller.disablePlayerBczNotDownloaded.value = true;
                    } else {
                      controller.disablePlayerBczNotDownloaded.value = false;
                    }

                    Navigator.pop(context);
                  },
                  title: subtitle('سورة ${controller.surahs[index].name} ',
                      Colors.white, TextAlign.end),
                  subtitle: subtitle(
                      '${controller.surahs[index].ayyahs.length} verses',
                      Colors.white70,
                      TextAlign.end),
                  trailing: Text(arabicNumber.convert(index + 1),
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'Uthmanic',
                        color: Colors.white,
                        fontSize: 36,
                      )),
                ),
              ),
            ),
          ),
          body: Obx(
            () => PageView.builder(
              controller: con,
              scrollDirection: Axis.horizontal,
              onPageChanged: (value) => _Onpagechanged(value),
              itemCount: controller.surahs.length,
              itemBuilder: (context, index1) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        customTopBar(index1, context),
                        Divider(),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.surahs[index1].ayyahs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 0),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                        onLongPress: () {
                                          FlutterClipboard.copy(
                                              '{${controller.surahs[index1].ayyahs[index]['text']} (${arabicNumber.convert(index + 1)}) } -سورة ${controller.surahs[index1].name}');
                                          Get.showSnackbar(GetSnackBar(
                                              isDismissible: true,
                                              duration: Duration(seconds: 2),
                                              titleText: title_2('تم نسخ الأية',
                                                  TextAlign.end, Colors.white),
                                              messageText: subtitle(
                                                  'يمكنك مشاركة الأية الأن عن طريق الحافظة',
                                                  Colors.white54,
                                                  TextAlign.end)));
                                        },
                                        child: Text(
                                            '${controller.surahs[index1].ayyahs[index]['text']} ${arabicNumber.convert(index + 1)} ',
                                            textDirection: TextDirection.rtl,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  fontFamily: 'Uthmanic',
                                                  fontSize:
                                                      controller.fontSize.value,
                                                )),
                                      ),
                                    ),
                                    Obx(() => controller.isEnglish.isTrue
                                        ? Text(
                                            '${controller.surahs[index1].ayyahs[index]['transliteration']} ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2,
                                          )
                                        : Container()),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }

  _Onpagechanged(int value) {
    controller.selectedAyah.value = value;
    controller.link.value = controller.Reciters[controller.selectedIndex.value]
        .links[controller.selectedAyah.value];
    print(shares?.getStringList(controller
        .Reciters[controller.selectedIndex.value]
        .name)![controller.selectedAyah.value]);
    if (shares?.getStringList(controller
            .Reciters[controller.selectedIndex.value]
            .name)![controller.selectedAyah.value] ==
        'no') {
      controller.disablePlayerBczNotDownloaded.value = true;
    } else {
      controller.disablePlayerBczNotDownloaded.value = false;
    }
    controller.GetPlayer.stop();
    controller.isPlaying.value = false;
  }

  customTopBar(index1, context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.black38, width: 0.5)),
        elevation: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Theme.of(context).textTheme.headline4?.color,
                size: 20,
              ),
              onPressed: () {
                if (!kl.currentState!.isEndDrawerOpen) {
                  kl.currentState!.openEndDrawer();
                }
              },
            ),
            Text(
              controller.surahs[index1].name,
              style: Theme.of(context).textTheme.headline4,
            ),
            IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color: Theme.of(context).textTheme.headline4?.color,
                size: 20,
              ),
              onPressed: () {
                Get.bottomSheet(
                  Settingss(),
                  isScrollControlled: true,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
