import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:quran_app/model/Reciter.dart';
import 'package:quran_app/model/Surrah.dart';

import '../main.dart';

class QuranPageVController extends GetxController {
  List surahs = <SurrahS>[].obs;
  final player = AudioPlayer();

  var isPlaying = false.obs;
  var isPaused = false.obs;
  var disablePlayerBczNotDownloaded = false.obs;
  var disablePlayerBczBottom = false.obs;
  var position = 0.obs;
  var offline = true.obs;
  var ThereIsDownloads = false.obs;
  var duration = 0.obs;
  var mode_reciting = 1.0.obs;
  var Reciters = <Reciter>[].obs;
  var selectedIndex = 0.obs;

  List<String>? offline_reciters = shares?.getStringList('offline_reciters');
  var selectedAyah = 0.obs;
  var link =
      'https://download.tvquran.com/download/TvQuran.com__Yasser/001.mp3'.obs;
  var fontSize = 22.0.obs;
  var isEnglish = false.obs;
  Map Surrah = {};
  List Verses = [];

  List reciters = [
    {
      'reciter': 'ياسر الدوسري',
      'image': 'yasser.jpg',
      'link': 'https://download.tvquran.com/download/TvQuran.com__Yasser/'
    },
    {
      'reciter': 'سعود الشريم',
      'image': 'saud.jpg',
      'link': 'https://download.tvquran.com/download/TvQuran.com__Al-Shuraim/'
    },
    {
      'reciter': 'عبد الرحمان السديس',
      'image': 'abdrahman-soudis.jpg',
      'link': 'https://download.tvquran.com/download/TvQuran.com__Alsdes/'
    },
    {
      'reciter': 'ماهر المعيقلي',
      'image': 'maher.jpg',
      'link': 'https://download.tvquran.com/download/TvQuran.com__Maher/'
    },
    {
      'reciter': 'خالد الجليل',
      'image': 'khaled.jpg',
      'link': 'https://download.tvquran.com/download/recitations/21/252/'
    },
    {
      'reciter': 'عبد الرحمان مسعد',
      'image': 'abdrahman-masaad.jpg',
      'link': 'https://download.tvquran.com/download/recitations/372/303/'
    },
    {
      'reciter': 'ياسين الجزائري',
      'image': 'yassin.jpg',
      'link': 'https://download.tvquran.com/download/TvQuran.com__Yaseen/'
    },
    {
      'reciter': 'عبد الله المطرود',
      'image': 'am.jpg',
      'link': 'https://download.tvquran.com/download/TvQuran.com__Al-Mattrod/'
    },
    {
      'reciter': 'عبد الباسط عبد الصمد',
      'image': 'abdlbasset.jpg',
      'link':
          'https://download.tvquran.com/download/TvQuran.com__Abdulbasit_Warsh/'
    },
    {
      'reciter': 'عبد الرحمان العوسي',
      'image': 'abdrahman-laaousi.jpg',
      'link': 'https://download.tvquran.com/download/recitations/196/144/'
    },
    {
      'reciter': 'أحمد العاجمي',
      'image': 'ahmad-ajmy.jpg',
      'link': 'https://download.tvquran.com/download/TvQuran.com__Al-Ajmy/'
    },
  ];
  List ayahs = [];
  late var sub;
  List Ayyahs_links = [];

  sleep(minutes) async {
    Get.back();
    await Future.delayed(Duration(minutes: minutes));
    player.setReleaseMode(ReleaseMode.stop);
    player.stop();
    isPlaying.value = false;
  }

  editSelectedReciter(index) {
    selectedIndex.value = index;
    link.value = Reciters[index].links[selectedAyah.value];
    GetPlayer.stop();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    player.dispose();
  }

  @override
  void onReady() async {
    // TODO: implement onInit
    super.onReady();

    // check if there is downloads .

    if (shares?.getBool('Tdownloads') != null) {
      ThereIsDownloads.value = true;
    }

    /// Put the online links
    await chargeOnlineReciters();
    //////////////

//////////////// SEET SOME PLAYER CONFIGS AND LISTENERS ////////////////
    player.setReleaseMode(ReleaseMode.loop);

    player.onPositionChanged.listen((event) {
      position.value = event.inSeconds;
    });
    player.onDurationChanged.listen((event) {
      duration.value = event.inSeconds;
    });

    // check Offline reciters if exist if not create ;
    if (shares?.getStringList('offline_reciters') == null) {
      shares?.setStringList('offline_reciters', []);
    }

//////////// change beetween online and offline mode
    /// Listener
    sub = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result == ConnectivityResult.none) {
        offline.value = true;

        print(offline.value);
        Reciters.value = <Reciter>[];
        Ayyahs_links = [];

        for (int k = 0; k < reciters.length; k++) {
          if (offline_reciters!.contains(reciters[k]['reciter'])) {
            List? klop = shares?.getStringList(reciters[k]['reciter']);
            int counter = 0;
            for (int j = 0; j < 114; j++) {
              Ayyahs_links.add(
                  shares?.getStringList(reciters[k]['reciter'])?[j]);
            }

            Reciters.add(Reciter(
                name: reciters[k]['reciter'],
                image: reciters[k]['image'],
                links: Ayyahs_links));

            Ayyahs_links = [];
          }
        }
      } else {
        await chargeOnlineReciters();
        offline.value = false;
      }
    });
  }

  get getAyhas => surahs;
  get getReciters => Reciters;
  get GetPlayer => player;

  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();

    /// function of reading json
    /// //// set Surrahs Texts
    ///
    ///
    readJsonFile(String filePath) async {
      return rootBundle.loadString(filePath).then((value) => jsonDecode(value));
    }

//////////////
    for (int k = 1; k <= 114; k++) {
      Surrah = (await readJsonFile('assets/Json/$k.json'));
      ayahs.clear();

      surahs.add(SurrahS(name: Surrah['name'], ayyahs: Surrah['verses']));
    }
    var connected = await Connectivity().checkConnectivity();

    if (connected != ConnectivityResult.wifi &&
        connected != ConnectivityResult.mobile) {
      /// not connected to internet ;
      ///
      ///
      Reciters.clear();
      print('here');
      for (int k = 0; k < reciters.length; k++) {
        if (offline_reciters!.contains(reciters[k]['reciter'])) {
          List? klop = shares?.getStringList(reciters[k]['reciter']);
          int counter = 0;
          for (int j = 0; j < 114; j++) {
            Ayyahs_links.add(shares?.getStringList(reciters[k]['reciter'])?[j]);
          }
          Reciters.add(Reciter(
              name: reciters[k]['reciter'],
              image: reciters[k]['image'],
              links: Ayyahs_links));

          Ayyahs_links = [];
        }
      }
    } else {
      await chargeOnlineReciters();
      offline.value = false;

      /////////////////////
    }
  }

  setFontSize(fontsize) {
    fontSize.value = fontsize;
  }

  chargeOnlineReciters() async {
    late String linkd;
    Reciters.value = [];
    for (int k = 0; k < reciters.length; k++) {
      for (int i = 1; i <= 114; i++) {
        if (i < 10) {
          linkd = reciters[k]['link'] + '00$i.mp3';
        }
        if (i < 100 && i > 9) {
          linkd = reciters[k]['link'] + '0$i.mp3';
        }
        if (i > 99) {
          linkd = reciters[k]['link'] + '$i.mp3';
        }
        Ayyahs_links.add(linkd);
      }
      Reciters.add(Reciter(
          name: reciters[k]['reciter'],
          image: reciters[k]['image'],
          links: Ayyahs_links));

      Ayyahs_links = [];
    }
  }

  setSurrahLink(index) {
    link.value = Reciters[selectedIndex.value].links[index];
  }
}
