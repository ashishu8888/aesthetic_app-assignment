import 'package:aesthetic_app/authentication/firebase_auth_methods.dart';
import 'package:aesthetic_app/common/utils.dart';
import 'package:aesthetic_app/local_database.dart/shared_preferences.dart';
import 'package:aesthetic_app/models/movie_model.dart';
import 'package:aesthetic_app/screens/add_movie_form.dart';
import 'package:aesthetic_app/widgets/drawer.dart';
import 'package:aesthetic_app/widgets/movie_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "Home-screen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieModel> data = [];
  List<String> list = [];
  @override
  // Future<List<MovieModel>?> fetchMovie() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final keys = await prefs.getKeys();
  //   print(keys.length);
  //   for (int i = 0; i < keys.length; i++) {
  //     final movie = await LocalDB.getMovies(key: keys.elementAt(i));

  //     data.add(movie!);
  //   }

  //   setState(() {});
  //   return data;
  //   //print(data.length);
  // }
  @override
  initState() {
    super.initState();
    getAllData();
  }

  // Future<List<Widget>> getAllPrefs() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   return prefs.getKeys().map<Widget>((key) {
  //     final s = prefs.getStringList(key);
  //     return ListTile(
  //       leading: CircleAvatar(backgroundImage: NetworkImage(s![2])),
  //       title: Text(key),
  //       subtitle: Text(s[0]),
  //       trailing: IconButton(
  //         onPressed: () {
  //           LocalDB.delete(key);
  //           setState(() {});
  //         },
  //         icon: Icon(Icons.delete),
  //       ),
  //     );
  //   }).toList(growable: false);
  // }
  void getAllData() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    for (String key in keys) {
      final l = await prefs.getStringList(key);
      data.add(
          MovieModel(movieName: l![0], dirName: l[1], images: l[2], key: key));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text(
          "my movie bucket",
          style: GoogleFonts.poppins(fontSize: 20),
        ),
        backgroundColor: Color(0x00acb7ae).withOpacity(1),
      ),
      body: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            return CustomListTile(
              movie: data[index],
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                prefs.remove(data[index].key);
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const HomeScreen();
                }));
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddMovieScreen.routeNmae).then((value) {
            setState(() {});
          });
        },
        backgroundColor: Color(0x00acb7ae).withOpacity(1),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
