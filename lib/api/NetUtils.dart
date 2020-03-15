import 'dart:async';
import 'package:http/http.dart' as http;

class NetUtils {
  static Future<String> get(String url, {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer('?');
      params.forEach((key, value) {
        sb.write('$key' + '=' + '$value' + '&');
      });

      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }
    http.Response res = await http.get(url);
    return res.body;
  }
}
