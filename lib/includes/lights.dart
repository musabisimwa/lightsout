import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'board.dart' ;

class UIBoard extends StatefulWidget{
  @override
  _UIBoardState createState() {
    return _UIBoardState();
  }
}

class _UIBoardState extends State<UIBoard>{
  ///create the grid to map the bulb position and state to the
  ///corresponding state of the board
  ///
  ///
  /// playable boaard
  Board boardMatrix ;
  _UIBoardState(){
    boardMatrix = Board(width: 13,length: 8);

  }
///  the position of the clicked signal
  int _sigX,_sigY;
  int _counter=0;



  Widget boardLight(Board board){
    /// object board -> lights::Widget
   int length = board.getBoard()[1].length;
   int width = board.getBoard().length;
   Widget gridLayout;
    ///  column-> x number of rows == width
    ///  length of Elements in row x == length
    ///

       List<List<Widget>> grid = List(width);
   for (var gridWidth =0; gridWidth< grid.length;gridWidth++){
      grid[gridWidth] = List(length);
      /// creating the same matrix that matches Board matrix so they
     /// perfectly fit

   }
   for(var i =0; i< width; i++){
     for(var j =0; j<length; j++){
       /// grid is a 2D array :
       /// fill with bulbs
       ///   /// button clicked to call position click on board
       //  /// the button clicked position x y  == board position x y
       grid[i][j] = bulbState(state: board.getBoard()[i][j],
                              onPressed: (){
                              _sigX=i;
                              _sigY=j;
                              print("$_sigX $_sigY");
                              setState(() {
                                board.boardClick(j, i);
                                _counter =board.getCounter();
                              });
                              });
     }
   }



    List<Widget> column =List(width);
   for(var i=0; i<width; i++){
     column[i]=Row(
       children: grid[i],
       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     );
   }

     gridLayout =Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: column
     );
    return gridLayout;
  }


  Widget bulbState({bool state, VoidCallback onPressed}){
    Widget _bulbOff= Container(
      margin: EdgeInsets.all(5),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        shape:BoxShape.circle,
        color: (state)?Colors.yellow:Colors.black,
      ),
      child: FlatButton(
        child: Container(
          height: 5,width: 5,
          decoration: BoxDecoration(
            shape:BoxShape.circle,
            color: (state)?Colors.black:Colors.grey,
          ),
        ),
        onPressed:onPressed,
      ),
    );
    return _bulbOff;
  }

  @override
  Widget build(BuildContext context) {
    /// force portraitmode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.blueGrey[600],
          items: <BottomNavigationBarItem>[BottomNavigationBarItem(
            icon: Icon(Icons.repeat, color: Colors.blueGrey[600],),
            title: FlatButton(
              onPressed: (){
                setState(() {
                  boardMatrix.reset(enhanced: false);
                  _counter  =boardMatrix.getCounter();
                });
              },

              child: Text( "Reset",
              style:TextStyle(
                fontSize: 16,
                color: Colors.white,
              )
                ,),
            ),
          ),

            BottomNavigationBarItem(
              icon: Icon(Icons.add, color: Colors.blueGrey[600],),
              title: Column(
                children: <Widget>[ Text("Light score",
                  style: TextStyle(fontSize: 16,
                    fontStyle: FontStyle.italic,color: Colors.white),),
                  Text("$_counter", style: TextStyle(fontSize: 40, color: Colors.white),)],
              )
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.repeat, color: Colors.blueGrey[600],),
              title: FlatButton(
                onPressed: (){
                  setState(() {
                    boardMatrix.reset(enhanced: true);
                  });
                },

                child: Text( "Enhanced Reset",
                  style:TextStyle(
                      fontSize: 16,
                    color: Colors.white,
                  )
                  ,),
              ),
            ),
          ]
        ),
          backgroundColor:Colors.brown[700],

        body:SafeArea(
        child :Container( child: boardLight(boardMatrix)
        ),
        )
      ),
    );}
}
