import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/constants/Constants.dart';
import 'package:quran_app/controllers/HomeController.dart';
import 'package:quran_app/main.dart';
import 'package:quran_app/view/custom_widgets/texts.dart';
import 'package:quran_app/view/custom_widgets/utils.dart';
import 'package:quran_app/view/widgets/widgets.dart';

import '../side_screens/QuranPageViewer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () => Get.offNamed('/home'),
            ),
          ),
          Column(
            children: [
              Image.asset(
                'assets/images/vectors/mainlogo.png',
                width: 130,
                height: 130,
              ),
              title_2('مرحبا بك يا', TextAlign.center, textWhite),
              p_1(),
              title_2('حافظ القرأن', TextAlign.center, Colors.white),
              Obx(() => subtitle('${controller.hizbde} حزب', Colors.white70,
                  TextAlign.center)),
              p_1(),
              p_1(),
              p_1(),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'هذا الأسبوع',
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  p_1(),
                  SizedBox(height: 200, child: week_tasks()),
                  Text(
                    'هذا اليوم',
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  p_1(),
                  Obx(() => ls()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
