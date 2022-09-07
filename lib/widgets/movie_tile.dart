// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:aesthetic_app/local_database.dart/shared_preferences.dart';
import 'package:aesthetic_app/models/movie_model.dart';

class CustomListTile extends StatefulWidget {
  final MovieModel movie;
  final Function onPressed;
  const CustomListTile({
    Key? key,
    required this.movie,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  void deleteMovie() async {
    await LocalDB.delete(widget.movie.key);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.movie.images,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                fit: BoxFit.contain,
                //width: 50,
              ),
            ),
            title: Text(widget.movie.movieName),
            subtitle: Text(widget.movie.dirName),
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                widget.onPressed();
              },
            ),
          ),
        ],
      ),
    );
  }
}
