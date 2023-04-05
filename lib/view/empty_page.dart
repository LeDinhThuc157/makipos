import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class EmptyPage extends StatefulWidget {
  @override
  _EmptyPageState createState() => new _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
  TextEditingController controller = new TextEditingController();
  final Storage _localStorage = window.localStorage;
  var token;
  var ListID = [];
  var ListStatus = [];
  var _data;
  int i = 0;
  var List_1 = [];
  Future save(String data, String propertyCode) async {
    _localStorage['$propertyCode'] = data;
  }
  Future<String?> _token() async => token = _localStorage['Token'];
  // Get json result and convert it to model. Then add
  getData() async {
    _token();
    try {
      var responseGet_Listdevice = await http.get(
        Uri.parse("http://smarthome.test.makipos.net:3028/devices"),
        headers: {"Authorization": token},
      );
      Map<String, dynamic> userMap = jsonDecode(responseGet_Listdevice.body);
      _data = userMap["data"];
      if (i == 0) {
        while (true) {
          ListID.add(_data[i]["productId"].toString());
          ListStatus.add(_data[i]["status"].toString());
          i++;
        }
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return StreamBuilder(
        stream:
        Stream.periodic(Duration(milliseconds: 100)).asyncMap((event) => List_1 = ListID),
        builder: (context, snapshot) => Scaffold(
          appBar: new AppBar(
            title: new Text('Home'),
            elevation: 0.0,
          ),
          body: new Column(
            children: <Widget>[
               Container(
                color: Theme.of(context).primaryColor,
                child: new Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        controller: controller,
                        decoration: new InputDecoration(
                            hintText: 'Search', border: InputBorder.none),
                        onChanged: onSearchTextChanged,
                      ),
                      trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                        controller.clear();
                        onSearchTextChanged('');
                      },),
                    ),
                  ),
                ),
              ),
               Expanded(
                child: _searchResult.length != 0 || controller.text.isNotEmpty
                    ? new ListView.builder(
                  itemCount: _searchResult.length,
                  itemBuilder: (context, i) {
                    return new Card(
                      child: new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Icon(
                                Icons.devices,
                                size: 40,
                                color: ListStatus[i] == "OFFLINE" ? Colors.red : Colors.green[500],
                              ),
                              SizedBox(),
                              Text(
                                "${_searchResult[i]}",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(),
                            ],
                          )
                      ),
                      margin: const EdgeInsets.all(0.0),
                    );
                  },
                )
                    : new ListView.builder(
                  itemCount: ListID.length,
                  itemBuilder: (context, index) {
                    return new Card(
                      child: new Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(),
                              Icon(
                                Icons.devices,
                                size: 40,
                                color: ListStatus[index] == "OFFLINE" ? Colors.red : Colors.green[500],
                              ),
                              SizedBox(),
                              Text(
                                "${ListID[index]}",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(),
                            ],
                          )
                      ),
                      margin: const EdgeInsets.all(0.0),
                    );
                  },
                ),
              ),
            ],
          ),
        )

    );

  }
  List<String> _searchResult = [];
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    print("Clear!");
    if (text.isEmpty) {
      setState(() {

      });
      return;
    }

    List_1.forEach((userDetail) {
      if (userDetail.contains(text) || userDetail.contains(text))
        _searchResult.add(userDetail);
    });


    setState(() {});
  }
}
