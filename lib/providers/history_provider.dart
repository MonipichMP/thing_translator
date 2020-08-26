import 'package:flutter/material.dart';
import 'package:thingtranslator/helpers/database_helper.dart';
import 'package:thingtranslator/models/history.dart';
import 'package:thingtranslator/models/history_url.dart';

class HistoryProvider extends ChangeNotifier {
  List<History> historyFileList = [];
  List<HistoryUrl> historyUrlList = [];

  List<History> get getFileHistoryList {
    return historyFileList;
  }

  void setImageFileHistory() {
    var list = DatabaseHelper.instance.getImageFileHistoryList();
    list.then((value) {
      historyFileList = value;
      notifyListeners();
    });
  }

  List<HistoryUrl> get getUrlHistoryList {
    return historyUrlList;
  }

  void setImageUrlHistory() {
    var list = DatabaseHelper.instance.getImageUrlHistoryList();
    list.then((value) {
      historyUrlList = value;
      notifyListeners();
    });
  }
}
