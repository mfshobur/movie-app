import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movie_app/data/movie_detail.dart';
import 'package:movie_app/services/MovieService.dart';

class ScreenDetail extends StatefulWidget {
  var id;
  ScreenDetail(this.id);

  @override
  State<ScreenDetail> createState() => _ScreenDetailState(id);
}

class _ScreenDetailState extends State<ScreenDetail> {
  var id;
  _ScreenDetailState(this.id);

  BoxDecoration boxDecoration = BoxDecoration(
      color: Color.fromARGB(255, 14, 6, 29),
      borderRadius: BorderRadius.circular(20));

  MovieDetail movie = MovieDetail();
  List<Genres> genre = [];
  var isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLoading = true;
    MovieService.getMovieDetail(id).then(((value) {
      setState(() {
        movie = value;
        genre = value.genres!;
        // print(movie);
        isLoading = false;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    // var posterPath = movie.posterPath ?? movie.backdropPath;
    // print(movie.posterPath);
    // print(movie.backdropPath);
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : NestedScrollView(
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: true,
                    collapsedHeight: 100,
                    backgroundColor: Color.fromRGBO(255, 255, 255, 0),
                    expandedHeight: 550.0,
                    floating: false,
                    pinned: false,
                    snap: false,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            movie.belongsToCollection?.name != null
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue),
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                        movie.belongsToCollection!.name
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                        )),
                                  )
                                : Text(''),
                            SizedBox(height: 5),
                            Text(
                              movie.title.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 3),
                            Text(
                              movie.tagline.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  '${movie.voteAverage}/10',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '(${movie.voteCount})',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${movie.runtime} min',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      background: Container(
                        // width: double.infinity,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Color.fromRGBO(0, 0, 0, 0.6), BlendMode.darken),
                          child: Image.network(
                            'https://www.themoviedb.org/t/p/w440_and_h660_face/${movie.posterPath}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ];
              }),
              body: ListView(
                padding: EdgeInsets.all(8),
                children: [
                  // kotak keterangan di bawah gambar
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: genre.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Chip(
                                    backgroundColor:
                                        Color.fromARGB(255, 14, 6, 29),
                                    label: Text(genre[index].name.toString())),
                              );
                            })),
                      ),
                      // Release
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: boxDecoration,
                            child: Text('Release Date: ${movie.releaseDate}'),
                          ),
                          SizedBox(width: 25),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: boxDecoration,
                            child:
                                Text('Revenue \$${movie.revenue.toString()}'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: boxDecoration,
                        child: Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Overview:'),
                              SizedBox(height: 10),
                              Text(movie.overview.toString()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: boxDecoration,
                        child: Expanded(
                          child: Text('Original language: ${movie.originalLanguage}'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
