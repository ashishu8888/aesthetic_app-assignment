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
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 240, 240),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  "Personalize< create. delete. your. movie bucket. >",
                  style: GoogleFonts.poppins(
                      color: const Color(0x00acb7ae).withOpacity(1),
                      fontSize: 25),
                ),
              ),
            ),
            Center(
              child: isLogin == false
                  ? Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: Card(
                        // color: Color(0xfceed1).withOpacity(0.6),
                        elevation: 10,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.transparent,
                                backgroundImage: ExactAssetImage(
                                    'lib/assets/login.png',
                                    scale: 3),
                              ),
                              Text(
                                "Hey, there",
                                style: GoogleFonts.poppins(
                                  color: const Color(0x2d545e).withOpacity(0.9),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                "Create an account",
                                style: GoogleFonts.poppins(
                                    color: Color(0x12343b).withOpacity(0.9),
                                    fontSize: 20),
                              ),
                              const SizedBox(
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
                                  decoration: InputDecoration(
                                    fillColor: Color(0x68d388).withOpacity(0.2),
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
                                  text: "Register",
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Text('or sign to an existing account.'),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          isLogin = true;
                                        });
                                      },
                                      child: Text(
                                        'Log in',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0x2d545e)
                                              .withOpacity(0.9),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.transparent,
                              backgroundImage: ExactAssetImage(
                                  'lib/assets/login.png',
                                  scale: 3),
                            ),
                            Text(
                              "Welcome back",
                              style: GoogleFonts.poppins(
                                color: const Color(0x2d545e).withOpacity(0.9),
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Log in.",
                              style: GoogleFonts.poppins(
                                  color: Color(0x12343b).withOpacity(0.9),
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: phoneCtr,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  fillColor: Color(0x68d388).withOpacity(0.2),
                                  icon: Icon(Icons.phone_android),
                                  border: OutlineInputBorder(),
                                  hintText: 'phone number',
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: MyButton(onpressed: () {}, text: "Log in"),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 90),
                              child: Row(
                                children: [
                                  Text('or sign up.'),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isLogin = false;
                                      });
                                    },
                                    child: Text(
                                      'Sign up',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0x2d545e)
                                            .withOpacity(0.9),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
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
