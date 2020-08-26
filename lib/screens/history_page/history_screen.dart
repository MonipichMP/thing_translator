import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thingtranslator/helpers/database_helper.dart';
import 'package:thingtranslator/models/history.dart';
import 'package:thingtranslator/models/history_url.dart';
import 'package:thingtranslator/providers/history_provider.dart';
import 'package:thingtranslator/providers/menu_index_provider.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    Provider.of<HistoryProvider>(context, listen: false).setImageFileHistory();
    Provider.of<HistoryProvider>(context, listen: false).setImageUrlHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var historyList = Provider.of<HistoryProvider>(context);
    var historyUrlList = Provider.of<HistoryProvider>(context);
    var tapIndex = Provider.of<MenuIndexProvider>(context);

    List<Widget> bodies = [
      buildListFile(historyList.getFileHistoryList),
      buildList(historyUrlList.getUrlHistoryList),
    ];
    void onTapChanged(int index) {
      Provider.of<MenuIndexProvider>(context, listen: false)
          .updateSegmentIndex(index);
    }

    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 15),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.92,
            child: CupertinoSegmentedControl(
              selectedColor: Theme.of(context).primaryColor,
              borderColor: Theme.of(context).primaryColor,
              groupValue: tapIndex.getSegmentIndex,
              onValueChanged: (value) => onTapChanged(value),
              children: {
                0: Text("File Images"),
                1: Text("Url Images"),
              },
            ),
          ),
          SizedBox(height: 15),
          historyList.getFileHistoryList.isNotEmpty ||
                  historyList.getUrlHistoryList.isNotEmpty
              ? bodies[tapIndex.getSegmentIndex]
              : Center(child: Text("No data"))
        ],
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      title: Text("History"),
      automaticallyImplyLeading: false,
    );
  }

  Widget buildListFile(List<History> fileList) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            confirmDismiss: (answer) {
              return showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text("Are you sure to remove this data?"),
                        actions: <Widget>[
                          FlatButton(
                            child:
                                Text('No', style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              DatabaseHelper.instance
                                  .deleteHistory(fileList[index].id);
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      ));
            },
            onDismissed: (value) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Delete ${fileList[index].english} from list'),
                ),
              );
            },
            key: Key(fileList[index].id.toString()),
            child: Column(
              children: <Widget>[
                Material(
                  child: SizedBox(
                    height: 110,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    FileImage(File(fileList[index].imageFile)),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                fileList[index].english,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                fileList[index].khmer,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "${fileList[index].score}%",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(height: 1),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildList(List<HistoryUrl> list) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            confirmDismiss: (answer) {
              return showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: Text("Are you sure to remove this data?"),
                        actions: <Widget>[
                          FlatButton(
                            child:
                                Text('No', style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              DatabaseHelper.instance
                                  .deleteHistoryUrl(list[index].id);
                              Navigator.of(context).pop(true);
                            },
                          ),
                        ],
                      ));
            },
            onDismissed: (value) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Delete ${list[index].english} from list'),
                ),
              );
            },
            key: Key(list[index].id.toString()),
            child: Column(
              children: <Widget>[
                Material(
                  child: SizedBox(
                    height: 110,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(list[index].imageUrl),
                              ),
                            ),
                          ),
                          SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                list[index].english,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                list[index].khmer,
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                "${list[index].score}%",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(height: 1),
              ],
            ),
          );
        },
      ),
    );
  }
}
