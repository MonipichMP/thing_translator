import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thingtranslator/models/translate.dart';

class TranslateAPI {
  static var key = 'AIzaSyBmsV4aqca6U-HkONO_ZZ-TCc-2fRj07zE';
  static var url =
      'https://translation.googleapis.com/language/translate/v2?key=$key';

  Future<Translate> getTranslateText(String sourceText) async {
    Map data = {
      "q": [sourceText],
      "target": "km"
    };

    var body = json.encode(data);

    var response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      print("get translate success");

      var data = jsonDecode(response.body);
      Translate translate = Translate.fromJSon(data['data']['translations'][0]);
      return translate;
    } else {
      print("error: ${response.statusCode}, ${response.body}");
      return null;
    }
  }
}
