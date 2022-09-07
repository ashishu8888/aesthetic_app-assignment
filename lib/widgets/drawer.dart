import 'package:aesthetic_app/authentication/firebase_auth_methods.dart';
import 'package:aesthetic_app/local_database.dart/shared_preferences.dart';
import 'package:aesthetic_app/screens/add_movie_form.dart';
import 'package:aesthetic_app/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  User? user;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    user = context.read<FirebaseAuthMethods>().user;
    print(user!.email);
  }

  void ClearData() async {
    await LocalDB.ClearAllData();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const HomeScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: Color(0x00acb7ae).withOpacity(0.7),
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  backgroundImage: ExactAssetImage(
                    'lib/assets/login.png',
                  ),
                ),
                Text(
                  "Hello",
                  style: GoogleFonts.poppins(fontSize: 25),
                ),
                Text(
                  user!.email!,
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.home),
                const SizedBox(
                  width: 50,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HomeScreen();
                    }));
                  },
                  child: Text(
                    'Home',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Color(0x00acb7ae).withOpacity(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.movie_creation_outlined),
                const SizedBox(
                  width: 50,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AddMovieScreen();
                    }));
                  },
                  child: Text(
                    'Add a new Movie',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Color(0x00acb7ae).withOpacity(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.delete_forever),
                const SizedBox(
                  width: 50,
                ),
                TextButton(
                  onPressed: ClearData,
                  child: Text(
                    'Clear all movies',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Color(0x00acb7ae).withOpacity(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.logout_outlined),
                const SizedBox(
                  width: 50,
                ),
                TextButton(
                  onPressed: () {
                    context.read<FirebaseAuthMethods>().signOut(context);
                  },
                  child: Text(
                    'Log out',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: Color(0x00acb7ae).withOpacity(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
