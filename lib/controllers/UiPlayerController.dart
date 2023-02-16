import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quran_app/controllers/QuranPageVController.dart';

QuranPageVController pageController = Get.put(QuranPageVController());

class UiPlayerController extends GetxController {
  var timer_value = 1.obs;

  convertToSplits(int seconds) {
    if (seconds < 60) {
      if (seconds < 10) {
        return "0:0$seconds";
      } else {
        return "0:$seconds";
      }
    } else if (seconds >= 60 && seconds < 3600) {
      if ((seconds / 60).ceil() < 10 && ((seconds % 60) / 60).ceil() < 10) {
        return "0${(seconds / 60).ceil()}:0${((seconds % 60) / 60).ceil()}";
      }
      if ((seconds / 60).ceil() >= 10 && ((seconds % 60) / 60).ceil() >= 10) {
        return "${(seconds / 60).ceil()}:${((seconds % 60) / 60).ceil()}";
      }
      if ((seconds / 60).ceil() < 10 && ((seconds % 60) / 60).ceil() >= 10) {
        return "0${(seconds / 60).ceil()}:${((seconds % 60) / 60).ceil()}";
      }
      if ((seconds / 60).ceil() >= 10 && ((seconds % 60) / 60).ceil() < 10) {
        return "${(seconds / 60).ceil()}:0${((seconds % 60) / 60).ceil()}";
      }
    } else if (seconds >= 3600) {
      return "${(seconds / 3600).ceil()}:${((seconds % 3600) / 60).ceil()}:${(((seconds % 3600) / 60) / 60).ceil()}";
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }
}
