import 'dart:convert';

import 'package:thingtranslator/models/label_annotation.dart';
import 'package:http/http.dart' as http;

class LabelAnnotationAPI {
  static var key = 'AIzaSyBmsV4aqca6U-HkONO_ZZ-TCc-2fRj07zE';
  static var url = 'https://vision.googleapis.com/v1/images:annotate?key=$key';

  Future<LabelAnnotationList> getLabelListUsingImageUrl(String imageUrl) async {
    Map data = {
      "requests": [
        {
          "image": {
            "source": {
              "imageUri": "$imageUrl"
              }
          },
          "features": [
            {"type": "LABEL_DETECTION", "maxResults": 3}
          ]
        }
      ]
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      print("getting label annotation success!");
      var data = jsonDecode(response.body);
      print(data['responses']);
      LabelAnnotationList labelAnnotationList =
          LabelAnnotationList.fromJson(data['responses'][0]);
      return labelAnnotationList;
    } else {
      print("error: ${response.statusCode} , ${response.body}");
      return null;
    }
  }

  Future<LabelAnnotationList> getLabelListUsingImageBase64(
      String image64) async {
    Map data = {
      "requests": [
        {
          "image": {"content": image64},
          "features": [
            {"type": "LABEL_DETECTION", "maxResults": 3}
          ]
        }
      ]
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      print("getting label annotation success!");
      var data = jsonDecode(response.body);
      print(data['responses']);
      LabelAnnotationList labelAnnotationList =
          LabelAnnotationList.fromJson(data['responses'][0]);
      return labelAnnotationList;
    } else {
      print("error: ${response.statusCode} , ${response.body}");
      return null;
    }
  }
}
