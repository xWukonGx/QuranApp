import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:quran_app/main.dart';
import 'package:quran_app/view/widgets/widgets.dart';

class DownloadsSurrahsController extends GetxController {
  var DownloadingProgress = 0.0.obs;
  var DownloadedFiles = 0.obs;
  var isDownloading = false.obs;
  var selectedReciter = 0.obs;
  var ReciterDownloadedSurrahs = <String>[].obs;

  var OfflineReciters = shares?.getStringList('offline_reciters').obs;
  var selectedSurrahsByindex = <int>[].obs;

  downloadSelectedSurrahs() async {
    String finalPath = '';
    String recitername = controller.Reciters[selectedReciter.value].name;
    List<String> FinalList = [];
    FinalList.clear();

    for (int k = 0; k < 114; k++) {
      if (ReciterDownloadedSurrahs[k] == 'no') {
        finalPath = 'no';
      } else {
        finalPath = ReciterDownloadedSurrahs[k];
      }
      FinalList.add(finalPath);
    }
    print(selectedSurrahsByindex.length);
    for (int lk = 0; lk < selectedSurrahsByindex.length; lk++) {
      var fetchedFile = await DefaultCacheManager().getSingleFile(controller
          .Reciters[selectedReciter.value].links[selectedSurrahsByindex[lk]]);
      double summit_moyen = 1 / selectedSurrahsByindex.length;
      DownloadingProgress.value = DownloadingProgress.value + summit_moyen;
      DownloadedFiles++;
      finalPath = fetchedFile.path;
      FinalList[selectedSurrahsByindex[lk]] = finalPath;
    }

    ReciterDownloadedSurrahs.value = FinalList;
    shares?.setBool('Tdownloads', true);
    controller.ThereIsDownloads.value = true;

    /// Done Making Final List of 114 Surrahs (Downloaded And Not Downloaded )

    ///// Updatng Reciter List Of suurahs
    await shares?.remove(recitername); // remove old reciter Surrahs List
    await shares?.setStringList(
        recitername, FinalList); // add the new Surrahs List
    ////
    ///

    //// add Reciter to list of offline reciters
    if (OfflineReciters!.value!.contains(recitername) == false) {
      OfflineReciters!.value!.add(recitername);
      await shares?.remove('offline_reciters');
      await shares?.setStringList('offline_reciters', OfflineReciters!.value!);
    }

    Get.back();
  }

  initializeReciter() async {
    String recitername = controller.Reciters[selectedReciter.value].name;
    List<String> Links = [];

    if (shares?.getStringList(recitername) == null) {
      for (int i = 0; i < 114; i++) {
        Links.add('no');
      }
      await shares?.setStringList(recitername, Links);
      List<String>? SurrahsList = shares?.getStringList(recitername)!;

      ReciterDownloadedSurrahs.value = SurrahsList!;
      print(ReciterDownloadedSurrahs.value);
    } else {
      List<String>? SurrahsList = shares?.getStringList(recitername)!;
      ReciterDownloadedSurrahs.value = SurrahsList!;
    }

    Links.clear();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    var Read_permission_status = await Permission.storage.status;
    if (!Read_permission_status.isGranted) {
      Map<Permission, PermissionStatus> status =
          await [Permission.storage].request();
    }
    if (Read_permission_status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();

    selectedSurrahsByindex.clear();
  }
}
