import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> XorOlist = ['', '', '', '', '', '', '', '', ''];
  bool isTurnO = true;
  bool gameHasResult = false;
  String winnerTitle = '';
  int filledBoxes = 0;
  int scoreX = 0;
  int scoreO = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                clearGame();
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
        title: Text(
          'Tic Tac Toe',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            getScoreBord(),
            SizedBox(height: 20),
            getResultButton(),
            SizedBox(height: 15),
            getGrideView(),
            getTurn(),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  void checkWinner() {
    if (XorOlist[0] == XorOlist[1] &&
        XorOlist[0] == XorOlist[2] &&
        XorOlist[0] != '') {
      setResult(XorOlist[0], 'Winner is ' + XorOlist[0]);
      return;
    }
    if (XorOlist[3] == XorOlist[4] &&
        XorOlist[3] == XorOlist[5] &&
        XorOlist[3] != '') {
      setResult(XorOlist[3], 'Winner is ' + XorOlist[3]);

      return;
    }
    if (XorOlist[6] == XorOlist[7] &&
        XorOlist[6] == XorOlist[8] &&
        XorOlist[6] != '') {
      setResult(XorOlist[6], 'Winner is ' + XorOlist[6]);
      return;
    }
    if (XorOlist[0] == XorOlist[3] &&
        XorOlist[0] == XorOlist[6] &&
        XorOlist[0] != '') {
      setResult(XorOlist[0], 'Winner is ' + XorOlist[0]);
      return;
    }
    if (XorOlist[1] == XorOlist[4] &&
        XorOlist[1] == XorOlist[7] &&
        XorOlist[1] != '') {
      setResult(XorOlist[1], 'Winner is ' + XorOlist[1]);
      return;
    }
    if (XorOlist[2] == XorOlist[5] &&
        XorOlist[2] == XorOlist[8] &&
        XorOlist[2] != '') {
      setResult(XorOlist[2], 'Winner is ' + XorOlist[2]);
      return;
    }
    if (XorOlist[0] == XorOlist[4] &&
        XorOlist[0] == XorOlist[8] &&
        XorOlist[0] != '') {
      setResult(XorOlist[0], 'Winner is ' + XorOlist[0]);
      return;
    }
    if (XorOlist[2] == XorOlist[4] &&
        XorOlist[2] == XorOlist[6] &&
        XorOlist[2] != '') {
      setResult(XorOlist[2], 'Winner is ' + XorOlist[2]);
      return;
    }
    if (filledBoxes == 9) {
      setResult('', 'Draw');
    }
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == 'X') {
        scoreX = scoreX + 1;
      } else if (winner == 'O') {
        scoreO = scoreO + 1;
      } else {
        scoreO = scoreO + 0;
        scoreX = scoreX + 0;
      }
    });
  }

  void tapped(int index) {
    if (gameHasResult) {
      return;
    }
    setState(() {
      if (XorOlist[index] != '') {
        return;
      }
      if (isTurnO) {
        XorOlist[index] = 'O';
        filledBoxes = filledBoxes + 1;
      } else {
        XorOlist[index] = 'X';
        filledBoxes = filledBoxes + 1;
      }
      isTurnO = !isTurnO;
      checkWinner();
    });
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < XorOlist.length; i++) {
        XorOlist[i] = '';
      }
      gameHasResult = false;
    });
    filledBoxes = 0;
  }

  Widget getScoreBord() {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Player X',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Text(
                '$scoreX',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Player O',
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              Text(
                '$scoreO',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            primary: Colors.white, side: BorderSide(color: Colors.white)),
        onPressed: () {
          setState(() {
            clearGame();
          });
        },
        child: Text(
          '$winnerTitle, play again',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget getGrideView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(
                  XorOlist[index],
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: XorOlist[index] == 'X' ? Colors.red : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X',
      style: TextStyle(
          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }
}
