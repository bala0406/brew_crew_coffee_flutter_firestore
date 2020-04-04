import 'package:flutter/material.dart';


class Demo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Demo2()),
      
    );
  }
}


class Demo2 extends StatefulWidget {
  @override
  _Demo2State createState() => _Demo2State();
}

class _Demo2State extends State<Demo2> {

  Color color = Colors.red;
  int number = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 200,
          width : 200,
          color: color,
          child: Text(number.toString(),style: TextStyle(fontSize: 30),),
        ),
        FlatButton(onPressed: (){
          setState(() {
            if(color == Colors.red)
            {
            color = Colors.blue;
            }else{
              color = Colors.red;
            }
            number++;
          });
        }, child: Text("Click me!"))
      ],
      
    );
  }
}