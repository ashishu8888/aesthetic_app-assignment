import 'package:aesthetic_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController nameCtr = TextEditingController();
  TextEditingController phoneCtr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 240, 240),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Personalize<",
                  style: GoogleFonts.poppins(
                      color: const Color(0x00acb7ae).withOpacity(1),
                      fontSize: 30),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "create.",
                  style: GoogleFonts.poppins(
                      color: const Color(0x00acb7ae).withOpacity(1),
                      fontSize: 30),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "delete.",
                  style: GoogleFonts.poppins(
                      color: const Color(0x00acb7ae).withOpacity(1),
                      fontSize: 30),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "your.",
                  style: GoogleFonts.poppins(
                      color: const Color(0x00acb7ae).withOpacity(1),
                      fontSize: 30),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "movie bucket.",
                  style: GoogleFonts.poppins(
                      color: const Color(0x00acb7ae).withOpacity(1),
                      fontSize: 30),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  ">",
                  style: GoogleFonts.poppins(
                      color: const Color(0x00acb7ae).withOpacity(1),
                      fontSize: 30),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Card(
                color: Color(0xfceed1).withOpacity(0.6),
                elevation: 10,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          ExactAssetImage('lib/assets/login.png', scale: 3),
                    ),
                    Text(
                      "Hey, there",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0x2d545e).withOpacity(0.9),
                      ),
                    ),
                    Text(
                      "Create an account",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0x12343b).withOpacity(0.9),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: nameCtr,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person_outlined),
                          border: OutlineInputBorder(),
                          hintText: 'name',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: phoneCtr,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.phone_android),
                          border: OutlineInputBorder(),
                          hintText: 'phone number',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 100,
                      child: MyButton(
                        onpressed: () {},
                        text: "Next",
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
