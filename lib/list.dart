import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class ListOfWords extends StatefulWidget {
  final String _query;

  ListOfWords(this._query);

  @override
  _ListOfWords createState() => _ListOfWords(_query);
}

class _ListOfWords extends State<ListOfWords> {
  final String _url = 'http://crossword-solver.000webhostapp.com/?req=';
  String _query;
  List<String> _list;
  String _msgText = '';

  _ListOfWords(this._query);

  @override
  initState() {
    super.initState();
    _list = List();
    _getFromDB();
  }

  _getFromDB() async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState((){_msgText = 'No internet connection';});
      return;
    }
    setState((){_msgText = 'Please wait...';});
    _query = _query.replaceAll('?', '_');
    var response = await http.get(_url+_query);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = convert.jsonDecode(response.body);
      jsonResponse.forEach((item) => _list.add(item['txt']));
      _msgText = '';
    }else{
      _msgText = 'Server error. Try later';
    }
    setState((){});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(53, 152, 219, 1.0),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              _msgText,
              style: TextStyle(color: Colors.white, fontSize: 20.0, fontFamily: 'FjallaOne-Regular'),
            ),
          ),
          ScrollConfiguration(
            behavior: Behavior(),
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index){
                return ListTile(
                  title: Text(
                    '${_list[index]}',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Behavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection){
    return child;
  }
}