import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/constants/Constants.dart';
import 'package:quran_app/main.dart';
import 'package:quran_app/view/custom_widgets/form.dart';
import 'package:quran_app/view/custom_widgets/texts.dart';
import 'package:quran_app/view/custom_widgets/utils.dart';
import 'package:quran_app/view/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  var hizb_number = 1.obs;
  var hizbde = 1.obs;
  var rubba_number = 1.obs;
  var task1 = false.obs;
  var task2 = false.obs;
  var task3 = false.obs;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController hizbdehifd = TextEditingController();
  TextEditingController hizbdemurajaa = TextEditingController();
  TextEditingController rubbadeHifd = TextEditingController();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    if (shares?.getBool('first_run') == null &&
        shares?.getBool('first_run') != false) {
      Get.showSnackbar(GetSnackBar(
        isDismissible: false,
        titleText: title('يرجى تحديد مكان بدء الحفظ وبدء المراجعة',
            TextAlign.center, backgroundColor),
        borderWidth: 1,
        borderColor: Colors.black,
        backgroundColor: Colors.white,
        messageText: Column(children: [
          Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  p_1(),
                  subtitle('بدء المراجعة من', backgroundColor, TextAlign.end),
                  TextFormField(
                      controller: hizbdemurajaa,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.parse(value) >= 60 ||
                            int.parse(value) == 0) {
                          return 'يجب أن يكون رقم الحزب بين 1 و 60';
                        }
                      },
                      textAlign: TextAlign.end,
                      style: TextStyle(fontFamily: 'Cairo'),
                      decoration: Input(
                          backgroundColor, 'الحزب رقم', 'بدء المراجعة من ..')),
                  p_1(),
                  subtitle('بدء الحفظ من', backgroundColor, TextAlign.end),
                  TextFormField(
                      controller: hizbdehifd,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.end,
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.parse(value) >= 60 ||
                            int.parse(value) == 0) {
                          return 'يجب أن يكون رقم الحزب بين 1 و 60';
                        }
                      },
                      style: TextStyle(fontFamily: 'Cairo'),
                      decoration: Input(
                          backgroundColor, 'الحزب رقم', 'بدء المراجعة من ..')),
                  p_1(),
                  TextFormField(
                      controller: rubbadeHifd,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty ||
                            int.parse(value) > 4 ||
                            int.parse(value) == 0) {
                          return 'يجب أن يكون رقم الربع بين 1 و 4';
                        }
                      },
                      textAlign: TextAlign.end,
                      style: TextStyle(fontFamily: 'Cairo'),
                      decoration: Input(
                          backgroundColor, 'الربع رقم', 'بدء المراجعة من ..')),
                  p_1(),
                  SimpleButton(backgroundColor, 'تأكيد', () {
                    if (_key.currentState!.validate()) {
                      shares?.setBool('first_run', false);
                      shares?.setInt(
                          'hizb_number', int.tryParse(hizbdemurajaa.text)!);
                      shares?.setInt('hizbde', int.tryParse(hizbdehifd.text)!);

                      shares?.setInt(
                          'rubba_number', int.parse(rubbadeHifd.text));
                      hizb_number.value = int.tryParse(hizbdemurajaa.text)!;
                      hizbde.value = int.tryParse(hizbdehifd.text)!;
                      rubba_number.value = int.tryParse(rubbadeHifd.text)!;

                      Get.closeCurrentSnackbar();
                    }
                  })
                ],
              ))
        ]),
      ));
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    if (shares?.getBool('first_run') == null &&
        shares?.getBool('first_run') != false) {
      shares?.setBool('task1', false);
      shares?.setBool('task2', false);
      shares?.setBool('task3', false);

      shares?.setString('start_date', DateTime.now().toString());
    } else {
      hizb_number.value = shares!.getInt('hizb_number')!;
      hizbde.value = shares!.getInt('hizbde')!;

      rubba_number.value = shares!.getInt('rubba_number')!;
      task1.value = shares!.getBool('task1')!;
      task2.value = shares!.getBool('task2')!;
      task3.value = shares!.getBool('task3')!;

      if (checkIfWeekEnded()) {
        shares?.setString('start_date', DateTime.now().toString());
        print(rubba_number.value);
        if (rubba_number.value == 4) {
          print('entred to checking rubaa numbrt');
          shares?.setInt('hizbde', hizbde.value + 1);
          shares?.setInt('rubba_number', 1);
        } else {
          shares?.setInt('rubba_number', rubba_number.value + 1);
        }

        shares!.setBool('task1', false);
        shares!.setBool('task2', false);
        shares!.setBool('task3', false);

        shares!.setInt('hizb_number', hizb_number.value + 1);
      }
    }
  }

  DoneTask(id) {
    shares?.setBool('task$id', true);
    if (id == 1)
      task1.value = true;
    else if (id == 2)
      task2.value = true;
    else
      task3.value = true;
    update();
  }

  checkIfWeekEnded() {
    if (DateTime.now().isAfter(DateTime.parse(shares!.getString('start_date')!)
        .add(Duration(days: 7)))) {
      return true;
    } else
      return false;
  }
}
