import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:quran_app/view/main_screens/BeforeHomeScreen.dart';
import 'package:quran_app/view/main_screens/HomeScreen.dart';
import 'package:quran_app/view/side_screens/DownloadSurahs.dart';
import 'package:quran_app/view/side_screens/Downloads.dart';
import 'package:quran_app/view/side_screens/QuranPageViewer.dart';
import 'package:quran_app/view/side_screens/UiPlayer.dart';
import 'constants/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? shares;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  shares = await SharedPreferences.getInstance();

  runApp(GetMaterialApp(
    theme: lightTheme,
    darkTheme: darkTheme,
    title: 'Hafeed',
    debugShowCheckedModeBanner: false,
    themeMode: ThemeMode.light,
    initialRoute: '/home',
    getPages: [
      GetPage(name: '/surahs', page: () => DownloadsSurrahs()),
      GetPage(name: '/uiplayer', page: () => UiPlayer()),
      GetPage(name: '/downloads', page: () => DownloadsScreen()),
      GetPage(name: '/progress', page: () => MyApp()),
      GetPage(name: '/quran', page: () => QuranPageViewer()),
      GetPage(
        name: '/home',
        page: () => BeforeHS(),
      )
    ],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: HomeScreen(),
      ),
    );
  }
}
