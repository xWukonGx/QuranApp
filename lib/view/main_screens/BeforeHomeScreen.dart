import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/constants/Constants.dart';
import 'package:quran_app/controllers/BHSController.dart';
import 'package:quran_app/view/custom_widgets/form.dart';
import 'package:quran_app/view/custom_widgets/texts.dart';
import 'package:quran_app/view/custom_widgets/utils.dart';

class BeforeHS extends StatelessWidget {
  BeforeHS({super.key});
  ControllerHS controller = Get.put(ControllerHS());
  @override
  Widget build(BuildContext context) {
    TextStyle? textButton = Theme.of(context).textTheme.button;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                IconButton(
                  icon: Obx(
                    () => Icon(controller.val.value
                        ? Icons.dark_mode_rounded
                        : Icons.light_mode_rounded),
                  ),
                  onPressed: () {
                    controller.val.value = !controller.val.value;

                    controller.val.value
                        ? Get.changeThemeMode(ThemeMode.dark)
                        : Get.changeThemeMode(ThemeMode.light);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Image.asset('assets/images/vectors/20944800-ai.png'),
                  Text(
                    'حافظ',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  p_1(),
                  p_1(),
                  Column(
                    children: [
                      Container(
                        width: 250,
                        child: MaterialButton(
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.black,
                          onPressed: () => Get.toNamed('/quran'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_lesson_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'قراءة وسماع',
                                style: textButton,
                              ),
                            ],
                          ),
                        ),
                      ),
                      p_1(),
                      Container(
                        width: 250,
                        child: MaterialButton(
                          shape: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20)),
                          color: Colors.lightBlue,
                          onPressed: () => Get.offAllNamed('/progress'),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.bookmark_added_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'سجل الحفظ',
                                style: textButton,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  p_1(),
                  p_1(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
