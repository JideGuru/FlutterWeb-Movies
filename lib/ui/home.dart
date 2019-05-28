import 'dart:convert';

import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_web/podo/Movies.dart';
import 'package:movie_web/util/constants.dart';


class Home extends StatefulWidget {

  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading;
  Map response;
  Movies movies;

  getMovies() async{

    setState((){
      _loading = true;
    });
    var res = await http.get("${Constants.popularUrl}${Constants.apiKey}");
    var decodedJson = jsonDecode(res.body);
    print(decodedJson);

    if(res.statusCode == 200 && decodedJson != null){
      if(mounted) {
        setState(() {
          movies = Movies.fromJson(decodedJson);
          _loading = false;
        });
      }

    }else{
      print("Something went wrong");
      if(mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }


  @override
  void initState() {
    super.initState();
    getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(


        title: Padding(
          child: Text(
            "${widget.title}",
          ),
          padding: EdgeInsets.only(left: 12.0),
        ),

        actions: <Widget>[
          FlatButton(
            child: Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            onPressed: (){
              print("pressed");
            },
          ),

          FlatButton(
            child: Text(
              "Popular",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            onPressed: (){
              print("pressed");
            },
          ),

          FlatButton(
            child: Text(
              "Top Rated",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            onPressed: (){
              print("pressed");
            },
          ),

          FlatButton(
            child: Text(
              "About Us",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            onPressed: (){
              print("pressed");
            },
          ),

          FlatButton(
            child: Text(
              "Contact Us",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
            onPressed: (){
              print("pressed");
            },
          ),

          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: (){
              print("Pressed");
            },
          ),

        ],
//        elevation: 0.0,
        backgroundColor: Colors.black,
      ),

      body: Padding(
        padding: EdgeInsets.all(
          5.0
        ),

        child:  _loading
            ? Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),
          ),
        )
            :GridView.builder(
          itemCount: movies.results == null ? 0 : movies.results.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: (MediaQuery.of(context).size.width/2.5) /
                MediaQuery.of(context).size.height,
          ),
          itemBuilder: (BuildContext context, int index){
            Results movie = movies.results[index];
            var imageURL = "https://image.tmdb.org/t/p/w500" + movie.posterPath;
            return Container(
              padding: EdgeInsets.all(5.0),
              child: GridTile(
                footer: new GridTileBar(
                  backgroundColor: Colors.black45,
                  title: new Text(movie.title),
                ),
                child: new GestureDetector(
                  onTap: () {
                    print(movie.title);
                  },
                  child: Image.network(
                    imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),

      ),
    );
  }
}
