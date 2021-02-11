import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_flatter_app/logic/Network.dart';
import 'package:movies_flatter_app/ui/movie_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movies list")),
      body: Container(
        child: MoviesList(),
      ),
    );
  }
}

class MoviesList extends StatefulWidget {
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  Future data; //  Contains data from json

  @override
  void initState() {
    super.initState();
    data = Network(
            "https://raw.githubusercontent.com/meilisearch/MeiliSearch/master/datasets/movies/movies.json")
        .fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: data,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return movieListView(snapshot.data, context);
            } else {
              if (snapshot.hasError) {
                return Text("Error. Can't get data");
              }
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget movieListView(List data, BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  title: Text("${data[index]["title"]}"),
                  leading: CircleAvatar(
                    maxRadius: 25,
                    backgroundImage: NetworkImage(data[index]["poster"])
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MoviePage(
                      title: data[index]["title"],
                      overview: data[index]["overview"],
                      poster: data[index]["poster"],
                      releaseDate: data[index]["release_date"],
                      genres: data[index]["genres"]
                    )));
                  },
                ),
                Divider(
                  height: 5
                )
              ],
            );
          }),
    );
  }
}
