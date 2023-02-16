import 'dart:io';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/controllers/BHSController.dart';
import 'package:quran_app/controllers/HomeController.dart';
import 'package:quran_app/controllers/QuranPageVController.dart';
import 'package:quran_app/controllers/UiPlayerController.dart';
import 'package:quran_app/main.dart';
import 'package:quran_app/view/custom_widgets/form.dart';
import 'package:quran_app/view/side_screens/QuranPageViewer.dart';

import '../../constants/Constants.dart';
import '../custom_widgets/texts.dart';
import '../custom_widgets/utils.dart';

HomeController controller1 = Get.put(HomeController());
QuranPageVController controller = Get.put(QuranPageVController());
UiPlayerController uicontroller = Get.put(UiPlayerController());
ControllerHS controller3 = Get.put(ControllerHS());
week_tasks() {
  return GetX<HomeController>(
      builder: (controller1) => GridView(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
              ),
              children: [
                task_card(1, 'مراجعة حزب', 'الحزب ${controller1.hizb_number}',
                    controller1.task1 == false),
                task_card(
                    2,
                    'حفظ ربع',
                    'الربع ${controller1.rubba_number} الحزب ${controller1.hizbde}',
                    controller1.task2 == false),
              ]));
}

dayProgram() {
  switch (DateTime.now().weekday) {
    case DateTime.friday:
      return 'حفظ صفحة ونصف';
    case DateTime.saturday:
      return 'حفظ صفحة';
    default:
      return 'مراجعة صفحتان';
  }
}

ls() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      color: controller1.task3.value == true ? backgroundColor : textWhite,
      child: ListTile(
        leading: IconButton(
            onPressed: () {
              controller1.DoneTask(3);
              Get.dialog(AlertDialog(
                title: title('مبارك لك', TextAlign.center, backgroundColor),
                content: subtitle(
                    ' (رَبِّ اشرَح لي صَدري* وَيَسِّر لي أَمري* وَاحلُل عُقدَةً مِن لِساني* يَفقَهوا قَولي)',
                    Colors.black54,
                    TextAlign.center),
              ));
            },
            icon: controller1.task3.value != true
                ? Icon(
                    Icons.done_outline_rounded,
                    color: backgroundColor,
                  )
                : Icon(
                    Icons.done_rounded,
                    color: textWhite,
                  )),
        title: title(dayProgram(), TextAlign.end,
            controller1.task3.value != true ? backgroundColor : Colors.white),
        subtitle: subtitle(
            DateTime.now().weekday == DateTime.friday ||
                    DateTime.now().weekday == DateTime.saturday
                ? 'الربع ${controller1.rubba_number} '
                : 'الحزب ${controller1.hizb_number}',
            controller1.task3.value != true ? Colors.black45 : Colors.white70,
            TextAlign.end),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: backgroundColor,
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.book,
              color: textWhite,
              size: 30,
            ),
          ),
        ),
      ),
    ),
  );
}

task_card(id, titlet, subtitlet, cond) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
    decoration: BoxDecoration(
        color: cond ? cardColor : backgroundColor,
        borderRadius: BorderRadius.circular(20)),
    child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                controller1.DoneTask(id);
              },
              icon: shares?.getBool('task$id') == false
                  ? Icon(
                      Icons.done_outline_rounded,
                      color: backgroundColor,
                    )
                  : Icon(
                      Icons.done_rounded,
                      color: textWhite.withOpacity(0.6),
                    )),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.book,
                color: backgroundColor,
              ),
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          title(
              titlet, TextAlign.center, cond ? backgroundColor : Colors.white),
          subtitle(
              subtitlet, cond ? Colors.black45 : Colors.white, TextAlign.center)
        ],
      ),
      SizedBox()
    ]),
  );
}

Settingss() {
  return BottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    elevation: 1,
    onClosing: () {},
    builder: (context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            p_1(),
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      p_1(),
                      Text(
                        'اعدادات السمع',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.end,
                      ),
                      Container(
                        height: 160,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(() => (controller
                                          .ThereIsDownloads.isTrue &&
                                      controller.offline.isTrue ||
                                  controller.offline.isFalse)
                              ? Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: controller.Reciters.length,
                                          itemBuilder: (context, index) =>
                                              reciterWidget(index)),
                                    ),
                                    controller.offline.isFalse
                                        ? InkWell(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.arrow_left_rounded,
                                                  color: Get.theme.primaryColor
                                                      .withOpacity(1),
                                                ),
                                                Text(
                                                  'الانتقال الى التحميلات',
                                                  style: Get.theme.textTheme
                                                      .subtitle2!
                                                      .copyWith(
                                                          fontFamily: 'Tajwal'),
                                                ),
                                              ],
                                            ),
                                            onTap: () =>
                                                Get.offNamed('/downloads'),
                                          )
                                        : Container(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    p_1(),
                                    Icon(
                                      Icons.info_outline_rounded,
                                      size: 34,
                                    ),
                                    Text(
                                      'لم يتم تحميل أي قراء',
                                      style: Get.textTheme.subtitle2,
                                    )
                                  ],
                                )),
                        ),
                      ),

                      Text(
                        'حجم الخط',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.end,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.translate_rounded),
                          Slider(
                              inactiveColor: Colors.black,
                              activeColor: backgroundColor,
                              min: 20,
                              value: controller.fontSize.value,
                              max: 32,
                              onChanged: (value) {
                                controller.setFontSize(value);
                              }),
                        ],
                      ),
                      Text(
                        'المظهر',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.end,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Get.changeThemeMode(ThemeMode.dark);
                              controller3.val.value = true;
                              Get.back();
                            }),
                            child: Obx(
                              () => Column(
                                children: [
                                  CircleAvatar(
                                    radius: controller3.val.value ? 23 : 20,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          backDColor.withOpacity(0.9),
                                    ),
                                  ),
                                  Text(
                                    'داكن',
                                    style: controller3.val.value
                                        ? Get.textTheme.subtitle2
                                            ?.copyWith(color: Colors.white)
                                        : Get.textTheme.subtitle2,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.changeThemeMode(ThemeMode.light);
                              controller3.val.value = false;
                              Get.back();
                            },
                            child: Obx(
                              () => Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: !controller3.val.value ? 23 : 20,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'مضيئ',
                                    style: !controller3.val.value
                                        ? Get.textTheme.subtitle2
                                            ?.copyWith(color: Colors.black)
                                        : Get.textTheme.subtitle2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      p_1(),
                      Text(
                        'سرعة القراءة',
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.end,
                      ),
                      p_1(),

                      /// اعدادات القراءة
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            speedWidget(
                                'وضع المراجعة', 1.40, Icons.volume_up_rounded),
                            speedWidget(
                                'وضع الاستماع', 1, Icons.volume_down_rounded),
                            speedWidget(
                                'وضع الحفظ', 0.75, Icons.volume_mute_rounded)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

/// UI PLAYER
///
///

SleepModeUi() {
  return BottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20))),
    onClosing: () {},
    builder: (context) => SafeArea(
      child: Container(
          padding: EdgeInsets.all(30),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.share_arrival_time_outlined,
                    size: 35,
                  ),
                  p_1(),
                  Text(
                    'وضع النوم',
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline6,
                  ),
                  Obx(() => Text(
                        'سيتوقف المشغل بعد ${uicontroller.timer_value.value} دقيقة',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.subtitle2,
                      )),
                ],
              ),
              Obx(() => Slider(
                  min: 1,
                  value: uicontroller.timer_value.value.toDouble(),
                  max: 60,
                  onChanged: (value) {
                    uicontroller.timer_value.value = value.toInt();
                  })),
              Container(
                width: 100,
                child: MaterialButton(
                  shape: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.black,
                  onPressed: () async {
                    await controller.sleep(uicontroller.timer_value.value);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 3),
                    child: Text(
                      'موافق',
                      style:
                          TextStyle(color: Colors.white, fontFamily: 'Cairo'),
                    ),
                  ),
                ),
              )
            ],
          )),
    ),
  );
}

/////

speedWidget(String text, double speed, IconData icon) {
  return GestureDetector(
    onTap: () {
      controller.mode_reciting.value = speed;
      controller.GetPlayer.setPlaybackRate(controller.mode_reciting.value);
    },
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Get.theme.primaryColor)),
          child: Obx(
            () => CircleAvatar(
              radius: controller.mode_reciting.value == speed ? 27 : 25,
              backgroundColor: Get.theme.primaryColor,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Get.theme.backgroundColor,
                child: Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    icon,
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(
          text,
          style: !(controller.mode_reciting.value == speed)
              ? Get.theme.textTheme.subtitle2
              : Get.theme.textTheme.subtitle2!
                  .copyWith(color: Get.theme.primaryColor),
        )
      ],
    ),
  );
}

endDrrawer(con) {
  ArabicNumbers arabicNumber = ArabicNumbers();
  return Drawer(
    backgroundColor: Color.fromRGBO(32, 33, 36, 1),
    child: ListView.builder(
      itemCount: controller.surahs.length,
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          con.jumpToPage(index);
          Navigator.pop(context);
        },
        title: subtitle('سورة ${controller.surahs[index].name} ', Colors.white,
            TextAlign.end),
        subtitle: subtitle('${controller.surahs[index].ayyahs.length} verses',
            Colors.white70, TextAlign.end),
        trailing: Text(arabicNumber.convert(index + 1),
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontFamily: 'Uthmanic',
              color: Colors.white,
              fontSize: 36,
            )),
      ),
    ),
  );
}

reciterWidget(index) {
  return SizedBox(
    width: 100,
    child: GestureDetector(
      onTap: () {
        controller.isPlaying.value = false;
        controller.editSelectedReciter(index);
      },
      child: Obx(
        () => Column(
          children: [
            CircleAvatar(
              radius: controller.selectedIndex.value == index ? 34 : 30,
              backgroundColor: Get.theme.primaryColor,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(
                    'assets/images/reciters/${controller.Reciters[index].image}'),
              ),
            ),
            Text(
              controller.Reciters[index].name,
              textAlign: TextAlign.center,
              style: controller.selectedIndex.value == index
                  ? Get.theme.textTheme.subtitle2
                      ?.copyWith(color: Get.theme.primaryColor)
                  : Get.theme.textTheme.subtitle2,
            ),
          ],
        ),
      ),
    ),
  );
}
