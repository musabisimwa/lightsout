// the board

import 'dart:math';

///  Board will contain  model such that true is !true
///  has reset(), click(x,y)  setSize(x,y) getSize()
///
class Board{
  int _length;
  int _width;
  int _counter;
  /// Decides  the board size
  List<List<bool>> _board;  //2d array
  Board({int length, int width}){

    this._width=width;
    this._length=length;
    this._counter =0;
    _board =  List(width);
    for( int i=0; i< _board.length; i++){
      _board[i] = List.filled(length, false,growable: false);
    }
  }

  void reset({bool enhanced}){
    /// if enhanced: -> random reset
  this._counter=0;
    if (!enhanced){
      for( int i=0; i< _board.length; i++) {
        for (int j=0; j< _board[0].length;j++){
          _board[i][j]=false;
        }
      }
    }
    else{
      for( int i=0; i< _board.length; i++) {
        for (int j=0; j< _board[0].length;j++){
          _board[i][j]= Random.secure().nextInt(10)>5;
        }
      }
    }

  }

  bool isSolved(){
    int checker=0;
    for(var i =0;i < _board.length; i++){
      for(var j=0; j<_board[0].length;j++){
        if(_board[i][j]==true){
          checker++;
        }
      }
    }
    return (checker == (_board.length*_board[0].length));
  }
  List<List<bool>> getBoard(){
    return this._board;
}

  int getCounter(){
    return this._counter;
}

bool boardClick(int posx,int posY){
    /**
     * boardClick takes @param : matrix[][]  and int,int
     * modifies the value of the selected index  and also modifies
     * the neighbor
     *
     */
    //posY: vertical movement
    //posX horizontal movement
    int length = _board[0].length;
    int height = _board.length;
    bool success =false; // true when data is complemented (-1)
    /** lower left and right corner */
    if(posY == height-1){
      if(posx ==0){
        // case 0 is the first  lower corner

        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx+1] = !( _board[posY][posx+1]); //its right
        _board[posY-1][posx] = !( _board[posY-1][posx]); // its top
        success =true;
      }
      else if(posx == length-1){
        // -1 the last position in the bottom  ;;botton corner
        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx-1] = !( _board[posY][posx-1]); //its left
        _board[posY-1][posx] = !( _board[posY-1][posx]); //its top
        success =true;
      }
      else{
        // any other position in the bottom
        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx-1] = !( _board[posY][posx-1]); //its left
        _board[posY][posx+1] = !( _board[posY][posx+1]); //its right
        _board[posY-1][posx] = !( _board[posY-1][posx]); //its top
        success =true;

      }
    }
    else  if(posY == 0){
      if(posx ==0){
        // case 0 is the first  upper corner

        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx+1] = !( _board[posY][posx+1]); //its right
        _board[posY+1][posx] = !( _board[posY+1][posx]); // its bottom
        success =true;
      }
      else if(posx == length-1){
        // -1 the last position in the top ;;top corner
        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx-1] = !( _board[posY][posx-1]); //its left
        _board[posY+1][posx] = !( _board[posY+1][posx]); //its bottom
        success =true;
      }
      else{
        // any other position in the top
        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx-1] = !( _board[posY][posx-1]); //its left
        _board[posY][posx+1] = !( _board[posY][posx+1]); //its right
        _board[posY+1][posx] = !( _board[posY+1][posx]); //its bottom
        success =true;

      }

    }

    else{
      //sides left edge
      if((posY>0 && posY < height-1) && (posx ==0)){

        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx+1] = !( _board[posY][posx+1]); //its right
        _board[posY-1][posx] = !( _board[posY-1][posx]); //its top
        _board[posY+1][posx] = !( _board[posY+1][posx]); //its bottom
        success =true;

      }else // right side edge
      if((posY > 0 && posY < height-1) && (posx ==length-1)){
        _board[posY+1][posx] = !( _board[posY+1][posx]); //its bottom
        _board[posY-1][posx] = !( _board[posY-1][posx]); //its top
        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx-1] = !( _board[posY][posx-1]); //its left

      }else{

        // any other position not on the sides
        _board[posY-1][posx] = !( _board[posY-1][posx]); //its top
        _board[posY][posx] = !( _board[posY][posx]); //itself
        _board[posY][posx-1] = !( _board[posY][posx-1]); //its left
        _board[posY][posx+1] = !( _board[posY][posx+1]); //its right
        _board[posY+1][posx] = !( _board[posY+1][posx]); //its bottom
        success =true;

      }


    }
    _counter++;

    return success;
  }

 String toString(){
    String repre ="";
    for(var i=0; i< this._board.length;i++){
      for(var j=0; j< this._board[0].length;j++){
        /// drawing a String matrix representation of the board
        ///
        var repres =_board[i][j];
        repre+=" $repres";

      }
      repre+="\n";
    }
    return repre;
 }

}