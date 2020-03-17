import 'package:flutter/material.dart';
import 'package:lovebooks/api/Api.dart';
import 'dart:io';

import 'package:lovebooks/api/NetUtils.dart';
import 'dart:convert';

import 'package:lovebooks/models/MovieDetail.dart';

class MovieDetailPage extends StatefulWidget {
  String id;
  String title;

  MovieDetailPage(this.id, this.title);

  @override
  State<StatefulWidget> createState() {
    return _MovieDetailState(id, title);
  }
}

class _MovieDetailState extends State<MovieDetailPage> {
  String id;
  String title;

  MovieDetail movieDetail = new MovieDetail();

  _MovieDetailState(this.id, this.title);

  @override
  void initState() {
    super.initState();
    loadDetail();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
          margin: EdgeInsets.all(20.0),
          color: Colors.blueGrey,
          child: Row(
            children: <Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: movieDetail.images == null
                      ? Image.asset(
                          "images/placeholder.jpg",
                          width: 90.0,
                          height: 160.0,
                          fit: BoxFit.fitHeight,
                        )
                      : Image.network(
                          movieDetail.images["small"],
                          width: 90.0,
                          height: 160.0,
                          fit: BoxFit.fitHeight,
                        )),
              Column(
                children: <Widget>[
                  Text(
                    movieDetail.title == null ? '' : movieDetail.title,
                    style: TextStyle(fontSize: 30.0),
                  ),
                  Text(
                    movieDetail.originalTitle == null
                        ? ''
                        : movieDetail.originalTitle,
                    style: TextStyle(fontSize: 20.0),
                  )
                ],
              )
            ],
          )),
    );
  }

  void loadDetail() {
    var url = Api.DETAIL + id + "?" + Api.API_KEY;
    print(url);
    NetUtils.get(url).then((data) {
      if (data != null) {
        Map<String, dynamic> map = json.decode(data);
        MovieDetail detail = MovieDetail.fromMap(map);
        setState(() {
          movieDetail = detail;
        });
      }
    });
  }
}
