class Book {
  static const columnBookId = "bookId";
  static const columnName = "name";
  static const columnImg = "images";
  static const columnTitle = "title";

  int id;
  String name;
  String bookId;

//  String image = "https://bkimg.cdn.bcebos.com/pic/9a504fc2d5628535746e08f997ef76c6a6ef6358?x-bce-process=image/resize,m_lfit,w_268,limit_1";
  String title;
  Map<String, String> images;

  Book(this.name, this.bookId);

  Book.fromMap(Map<String, dynamic> map) {
    name = map[columnName];
    bookId = map[columnBookId];
    images = map[columnImg];
    title = map[columnTitle];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnImg: images,
      columnBookId: bookId,
      columnTitle: title
    };

    return map;
  }
}
