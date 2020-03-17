class MovieDetail {
  String year;

  Map<String, dynamic> images;

  String id;

  String title;

  List<dynamic> countries;

  List<dynamic> genres;

  Map<String, dynamic> rating;

  String summary;

  String originalTitle;

  MovieDetail();

  MovieDetail.fromMap(Map<String, dynamic> map) {
    year = map["year"];
    images = map["images"];
    id = map["id"];
    title = map["title"];
    countries = map["countries"];
    genres = map["genres"];
    rating = map["rating"];
    summary = map["summary"];
    originalTitle = map["original_title"];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "year": year,
      "images": images,
      "id": id,
      "title": title,
      "countries": countries,
      "genres": genres,
      "rating": rating,
      "summary": summary,
      "original_title": originalTitle
    };

    return map;
  }
}
