import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'Surah.dart';

void main(List<String> args) async {
  List ayahs = [];
  List surahs = [];
  readJsonFile(String filePath) async {
    var input = await File(filePath).readAsString();
    var map = jsonDecode(input);
    return map;

//
  }

  List Quarter =
      (await readJsonFile('meta.json'))['data']['hizbQuarters']['references'];

  for (int k = Quarter[238]['surah']; k <= Quarter[239]['surah']; k++) {
    print('for');
    Map Surrah = (await readJsonFile('$k.json'));
    List Verses = Surrah['verses'];
    for (int i = Quarter[238]['ayah']; i <= Verses.length - 1; i++) {
      ayahs.add(Verses[i]['text']);
    }
    surahs.add(Surah(name: Surrah['name'], ayahs: ayahs));
  }
  for (int i = 0; i < surahs.length; i++) {
    print(surahs[i].name);
    print(surahs[i].ayahs);
  }
}
