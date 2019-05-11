import 'package:flutter/material.dart';
import 'list.dart';


class Solver extends StatefulWidget {
  @override
  _Solver createState() => _Solver();
}

class _Solver extends State<Solver> {
  String _query = '';
  double _width;
  bool _getList = false;

  Widget _btn(String btnText){
    return InkWell(
      splashColor: Colors.white,
      onTap: (){
        if(_query.length > 20) return;
        setState(() {
          _query = _query + btnText;
        });
      },
      child: SizedBox(
        width: _width,
        child: Center(
          child: Text(
            btnText,
            style: TextStyle(color: btnText == '?' ? Colors.yellow : Colors.white, fontSize: 24.0, fontFamily: 'FjallaOne-Regular'),
          ),
        ),
      )
    );
  }

  Widget _del(){
    return InkWell(
      splashColor: Colors.white,
      onTap: (){
        setState(() {
          if(_query.length == 1) _query = '';
          if(_query.length > 1) _query = _query.substring(0, _query.length - 1);
        });
      },
      child: SizedBox(
        width: _width,
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: Icon(Icons.backspace, color: Colors.white, size: 20.0),
          ),
        ),
      ),
    );
  }

  Widget _search(){
    return InkWell(
      splashColor: Colors.white,
      onTap: (){
        if (_query.length > 2){
          setState((){
            _getList = true;
          });
        }
      },
      child: SizedBox(
        width: _width*2,
        child: Center(
          child: Icon(Icons.search, color: Colors.white, size: 30.0),
        ),
      ),
    );
  }

  Widget _list(){
    if(_getList){
      _getList = false;
      return ListOfWords(_query);
    }
    return Container(color: Color.fromRGBO(53, 152, 219, 1.0));
  }

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width/10;
    return SafeArea(
      child: Material(
        color: Color.fromRGBO(39, 174, 97, 1.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Center(
                child: Text(
                  _query,
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: TextStyle(color: Colors.white, fontSize: 40.0, fontFamily: 'FjallaOne-Regular'),
                ),
              ),
            ),
            Divider(color: Colors.white, height: 3.0,),
            Expanded(
              child: _list(),
            ),
            Divider(color: Colors.white, height: 3.0,),
            SizedBox(height: 5.0,),
            Row(
              children: <Widget>[
                _btn('Q'),_btn('W'),_btn('E'),_btn('R'),_btn('T'),_btn('Y'),_btn('U'),_btn('I'),_btn('O'),_btn('P'),
              ],
            ),
            Row(
              children: <Widget>[
                _btn('A'),_btn('S'),_btn('D'),_btn('F'),_btn('G'),_btn('H'),_btn('J'),_btn('K'),_btn('L'),_btn('?'),
              ],
            ),
            Row(
              children: <Widget>[
                _btn('Z'),_btn('X'),_btn('C'),_btn('V'),_btn('B'),_btn('N'),_btn('M'),_del(),_search()
              ],
            ),
            SizedBox(height: 5.0,),
          ],
        ),
      ),
    );
  }
}
