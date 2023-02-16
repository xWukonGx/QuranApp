import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/constants/Constants.dart';
import 'package:quran_app/controllers/DownloadsSurrahsController.dart';
import 'package:quran_app/controllers/QuranPageVController.dart';
import 'package:quran_app/main.dart';
import 'package:quran_app/view/custom_widgets/form.dart';
import 'package:quran_app/view/widgets/widgets.dart';

import '../../model/Reciter.dart';

DownloadsSurrahsController _controller = Get.put(DownloadsSurrahsController());

class DownloadsSurrahs extends StatelessWidget {
  DownloadsSurrahs({super.key});

  @override
  Widget build(BuildContext context) {
    Reciter reciter = controller.Reciters[_controller.selectedReciter.value];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 22,
              child: ListView.builder(
                itemCount: reciter.links.length,
                itemBuilder: (context, index) => Obx(
                  () => _controller.ReciterDownloadedSurrahs[index] == 'no'
                      ? CheckboxListTile(
                          onChanged: (value) {
                            value!
                                ? _controller.selectedSurrahsByindex.add(index)
                                : _controller.selectedSurrahsByindex
                                    .remove(index);
                          },
                          value: _controller.selectedSurrahsByindex
                              .contains(index),
                          title: Text(
                            controller.surahs[index].name,
                            style: Get.textTheme.subtitle2,
                            textAlign: TextAlign.end,
                          ),
                        )
                      : ListTile(
                          trailing: Icon(Icons.file_download_done),
                          title: Text(controller.surahs[index].name,
                              style: Get.textTheme.subtitle2!
                                  .copyWith(color: Get.theme.primaryColor),
                              textAlign: TextAlign.end)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: FractionallySizedBox(
                widthFactor: 0.4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                            elevation: 2,
                            scrollable: true,
                            backgroundColor: Colors.white,
                            title: Text(
                              'جاري التحميل ',
                              textAlign: TextAlign.end,
                              style: Get.textTheme.subtitle1!.copyWith(
                                  fontFamily: 'Cairo', color: Colors.black),
                            ),
                            content: Obx(
                              () => Center(
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${_controller.DownloadedFiles.value}/${_controller.selectedSurrahsByindex.length}',
                                        textAlign: TextAlign.start,
                                        style: Get.textTheme.subtitle2!
                                            .copyWith(color: Colors.black45),
                                      ),
                                      LinearProgressIndicator(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.4),
                                        value: _controller.DownloadingProgress
                                            .toDouble(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      );
                      await _controller.downloadSelectedSurrahs();
                      _controller.DownloadingProgress.value = 0.0;
                      _controller.selectedSurrahsByindex.clear();
                      _controller.DownloadedFiles.value = 0;
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'تحميل',
                        textAlign: TextAlign.center,
                        style: Get.textTheme.subtitle2!
                            .copyWith(color: Colors.white, fontSize: 11.5),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
