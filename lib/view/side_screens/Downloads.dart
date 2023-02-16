import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:quran_app/constants/Constants.dart';
import 'package:quran_app/controllers/DownloadsSurrahsController.dart';
import 'package:quran_app/controllers/QuranPageVController.dart';
import 'package:quran_app/main.dart';
import 'package:quran_app/view/side_screens/DownloadSurahs.dart';
import 'package:quran_app/view/widgets/widgets.dart';

DownloadsSurrahsController D_controller = Get.put(DownloadsSurrahsController());

class DownloadsScreen extends StatelessWidget {
  DownloadsScreen({super.key});
  QuranPageVController controller = Get.put(QuranPageVController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor.withOpacity(0.96),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemBuilder: (context, index) => reciterWidget(index),
          itemCount: controller.Reciters.length,
        ),
      ),
    );
  }
}

reciterWidget(index) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Get.theme.cardColor,
        title: Text(
          controller.Reciters[index].name,
          style: Get.theme.textTheme.subtitle2,
        ),
        leading: CircleAvatar(
          backgroundImage: AssetImage(
              'assets/images/reciters/${controller.Reciters[index].image}'),
        ),
        trailing: IconButton(
            onPressed: () async {
              // controller.Reciters[index].links.length

              print('Clicked ${D_controller.selectedReciter.value}');
              D_controller.selectedReciter.value = index;
              await D_controller.initializeReciter();
              Get.toNamed('/surahs');
            },
            icon: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.navigate_next_rounded,
                color: Get.theme.primaryColor,
                size: 18,
              ),
            ))),
  );
}
