import 'dart:io';
import 'package:aesthetic_app/local_database.dart/shared_preferences.dart';
import 'package:aesthetic_app/common/utils.dart';
import 'package:aesthetic_app/screens/home_screen.dart';
import 'package:aesthetic_app/widgets/button.dart';
import 'package:aesthetic_app/widgets/text_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddMovieScreen extends StatefulWidget {
  static const routeNmae = "add-movie-screen";
  const AddMovieScreen({super.key});

  @override
  State<AddMovieScreen> createState() => _AddMovieScreenState();
}

class _AddMovieScreenState extends State<AddMovieScreen> {
  final _addProductFormKey = GlobalKey<FormState>();
  TextEditingController directorNameCtr = TextEditingController();
  TextEditingController movieNameCtr = TextEditingController();
  TextfieldTagsController ctr = TextfieldTagsController();
  TextEditingController serialCtr = TextEditingController();
  double? distanceToField;
  bool isLoad = false;
  void didChangeDependencies() {
    super.didChangeDependencies();
    distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    directorNameCtr.dispose();
    movieNameCtr.dispose();
    ctr.dispose();
    serialCtr.dispose();
  }

  void initState() {
    super.initState();
    ctr = TextfieldTagsController();
  }

  List<String> tags = [];
  List<File> images = [];
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  void SaveMovie() async {
    if (movieNameCtr.text.isEmpty ||
        directorNameCtr.text.isEmpty ||
        images.isEmpty) {
      ShowSnackBar(context: context, content: "Please fill in all fields!");
      setState(() {
        isLoad = false;
      });
      return;
    }
    List<String> imageUrls = [];
    try {
      final cloudinary = CloudinaryPublic('ddvkshhsl', 'wcs4kqai');

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: movieNameCtr.text),
        );
        imageUrls.add(res.secureUrl);
      }
    } catch (e) {
      ShowSnackBar(context: context, content: e.toString());
      return;
    }

    final res = await LocalDB.saveMovieToDB(
      key: serialCtr.text.toString(),
      movieName: movieNameCtr.text,
      dirName: directorNameCtr.text,
      // tags: tags,
      images: imageUrls[0],
    );
    if (res) {
      ShowSnackBar(context: context, content: "Movie was saved");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      ShowSnackBar(context: context, content: "Movie was'nt saved");
    }
    setState(() {
      isLoad = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a movie',
          style: GoogleFonts.poppins(
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0x00acb7ae).withOpacity(1),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map(
                          (i) {
                            return Builder(
                              builder: (BuildContext context) => Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            );
                          },
                        ).toList(),
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 200,
                        ),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.Rect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: const [
                              Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Select movie posters',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  controller: serialCtr,
                  hintText: 'serial no',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: directorNameCtr,
                  hintText: 'Director name',
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: movieNameCtr,
                  hintText: 'movie name',
                ),
                const SizedBox(height: 10),
                TextFieldTags(
                  textfieldTagsController: ctr,
                  initialTags: const [
                    'thriller',
                  ],
                  textSeparators: const [' ', ','],
                  letterCase: LetterCase.normal,
                  validator: (String tag) {
                    if (tag == 'boring') {
                      return 'No, please just no';
                    } else if (ctr.getTags!.contains(tag)) {
                      return 'you already entered that';
                    }
                    return null;
                  },
                  inputfieldBuilder:
                      (context, tec, fn, error, onChanged, onSubmitted) {
                    return ((context, sc, tags, onTagDelete) {
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextField(
                          controller: tec,
                          focusNode: fn,
                          decoration: InputDecoration(
                            isDense: true,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 74, 137, 92),
                                width: 3.0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 74, 137, 92),
                                width: 3.0,
                              ),
                            ),
                            helperText: 'Enter tags...',
                            helperStyle: const TextStyle(
                              color: Color.fromARGB(255, 74, 137, 92),
                            ),
                            hintText: ctr.hasTags ? '' : "description tags",
                            errorText: error,
                            prefixIconConstraints: BoxConstraints(
                                maxWidth: distanceToField! * 0.74),
                            prefixIcon: tags.isNotEmpty
                                ? SingleChildScrollView(
                                    controller: sc,
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                        children: tags.map((String tag) {
                                      return Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                          color:
                                              Color.fromARGB(255, 74, 137, 92),
                                        ),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              child: Text(
                                                '#$tag',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onTap: () {
                                                print("$tag selected");
                                              },
                                            ),
                                            const SizedBox(width: 4.0),
                                            InkWell(
                                              child: const Icon(
                                                Icons.cancel,
                                                size: 14.0,
                                                color: Color.fromARGB(
                                                    255, 233, 233, 233),
                                              ),
                                              onTap: () {
                                                onTagDelete(tag);
                                              },
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList()),
                                  )
                                : null,
                          ),
                          onChanged: (val) {
                            tags.add(val);
                          },
                          onSubmitted: onSubmitted,
                        ),
                      );
                    });
                  },
                ),
                isLoad == false
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: MyButton(
                          onpressed: () {
                            setState(() {
                              isLoad = true;
                            });
                            SaveMovie();
                          },
                          text: "Save",
                        ),
                      )
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0x68d388).withOpacity(0.2),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
