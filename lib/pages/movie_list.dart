import 'package:flutter/material.dart';
import 'package:http_movie/service/http_service.dart';
import 'package:http_movie/pages/movie_detail.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int moviesCount;
  List movies;
  HttpService service;
  String imgPath = 'https://image.tmdb.org/t/p/w500/';

  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  void initState(){
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular Movies"),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.white60,
      body: ListView.builder(
        itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
        itemBuilder: (context, int position) {
          return Card(
            color: Colors.white70,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: InkWell(
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (_) => MovieDetail(movies[position]));
                Navigator.push(context, route);
              },
              child: ListTile(
              title: Row(
                children: [
                  SizedBox(width: 100,
                  child: Image.network(imgPath + movies[position].posterPath,),
                  ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(movies[position].title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                        Text(''),
                        Text(''),
                        Text(''),
                        Text(''),
                        Text(''),
                        Text(movies[position].voteAverage.toString(),),
                      ],
                    )
                  )
                )
                ],
              ),
            ),
            )
          );
        },
      )
    );
  }
}