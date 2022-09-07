import 'dart:convert';
import 'package:aesthetic_app/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static Future<bool> saveMovieToDB({
    required key,
    required String movieName,
    required String dirName,
    required String images,
  }) async {
    SharedPreferences pr = await SharedPreferences.getInstance();

    // Map<String, dynamic> movie = {
    //   "movieName": movieName,
    //   "dirName": dirName,
    //   "images": images,
    // };
    List<String> s = [];
    s.add(movieName);
    s.add(dirName);
    s.add(images);
    return await pr.setStringList(key, s);
  }

  static Future<List<String>> getMovies({required key}) async {
    SharedPreferences pr = await SharedPreferences.getInstance();
    final mov = pr.getStringList(key);

    return mov!;
  }

  static Future ClearAllData() async {
    SharedPreferences pr = await SharedPreferences.getInstance();
    await pr.clear();
  }

  static Future delete(String key) async {
    SharedPreferences pr = await SharedPreferences.getInstance();
    pr.remove(key);
  }
}
