import 'package:flutter/material.dart';
import 'package:thingtranslator/apis/label_api.dart';
import 'package:thingtranslator/models/label_annotation.dart';

class LabelListProvider extends ChangeNotifier {
  List<LabelAnnotation> labelList = [];

  // get label List
  List<LabelAnnotation> get getAllList {
    return labelList;
  }

  void setLabelListUsingImageUrl(String imageUrl) {
    var list = LabelAnnotationAPI().getLabelListUsingImageUrl(imageUrl);
    list.then((value) {
      labelList = value.data;
      notifyListeners();
    });
  }

  void setLabelListFromImage64(String imageBase64) {
    var list = LabelAnnotationAPI().getLabelListUsingImageBase64(imageBase64);
    list.then((value) {
      labelList = value.data;
      notifyListeners();
    });
  }
}
