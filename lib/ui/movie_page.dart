import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  final String title;
  final String overview;
  final String poster;
  final int releaseDate;
  final List genres;

  const MoviePage(
      {Key key,
      this.title,
      this.overview,
      this.poster,
      this.releaseDate,
      this.genres})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text("Movie page"),
          ),
          body: Container(
            child: ListView(
              children: [Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MoviePoster(poster: poster),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Column(
                      children: [
                        Center(
                            child: Text("$title", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                        ),
                        Text("Genre: " + genres.toString().replaceAll("[", "").replaceAll("]", "")),

                        //  Cutting DateTime string from 0 to 10 gives us an Year-Month-Day only
                        Text("Release date: " + DateTime.fromMillisecondsSinceEpoch(releaseDate*1000).toString().substring(0, 10)),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: Text("$overview"),
                        )
                      ],
                    ),
                  )
                ],
              )],
            ),
          ),
        );
  }
}

class MoviePoster extends StatelessWidget {
  final String poster;

  const MoviePoster({Key key, this.poster}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover)),
    );
  }
}
