import 'dart:convert';
import 'dart:io';


import 'package:path_provider/path_provider.dart';

class DataLoader {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/buildings.txt');
  }

  Future<String> readBuildings() async {

    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();
      print("file read called!!! & "+ contents);
      return contents;
    } catch (e) {
      // If encountering an error, return 0

      return "[]";
    }
  }

  Future<File> writeBuildings(List fav) async {

    final file = await _localFile;
    String jsonString = json.encode(fav);
    print("file write called!!! " + jsonString);
    // Write the file
    return file.writeAsString(jsonString);
  }
}
