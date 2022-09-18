import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/movie.dart';
import 'package:movie_app/services/MovieService.dart';
import 'package:movie_app/ui/screen_detail.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  List<Results> movieList = [];

  var isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLoading = true;
    MovieService.getMovieList().then(((value) {
      setState(() {
        movieList = value;
        isLoading = false;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shobur Movie App',
        ),
        backgroundColor: Color(0x100720),
      ),
      body: Container(
        // color: Colors.grey,
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: movieList.length,
            itemBuilder: ((context, index) {
              return isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      margin: EdgeInsets.fromLTRB(8, 10, 8, 0),
                      height: 230,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) =>
                                      ScreenDetail(movieList[index].id))));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Image.network(
                                  'https://www.themoviedb.org/t/p/w440_and_h660_face/${movieList[index].posterPath}',
                                  height: 230,
                                  // fit: BoxFit.cover,
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              '${movieList[index].voteAverage}/10 | ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Expanded(
                                            child: Text(
                                              movieList[index].title.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                          'Release date: ${movieList[index].releaseDate.toString()}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600)),
                                      SizedBox(height: 10),
                                      Text(
                                        movieList[index].overview.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600),
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
            })),
      ),
    );
  }
}
