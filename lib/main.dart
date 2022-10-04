import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];
  var winner = '';
  var currentplayer = 'X';
  void drawxo(i) {
    setState(() {
      if (grid[i] == '-') {
        grid[i] = currentplayer;
        currentplayer = currentplayer == 'X' ? 'O' : 'X';
        // if (currentplayer == 'X')
        //   currentplayer = 'O';
        // else
        //   currentplayer = 'X';
        findWinner(grid[i]);
      }
    });
  }

  bool checkMove(i1, i2, i3, sign) {
    if (grid[i1] == sign && grid[i2] == sign && grid[i3] == sign) {
      return true;
    }
    return false;
  }

  void findWinner(currentsign) {
    if (checkMove(0, 1, 2, currentsign) ||
            checkMove(3, 4, 5, currentsign) ||
            checkMove(6, 7, 8, currentsign) //rows
            ||
            checkMove(0, 3, 6, currentsign) ||
            checkMove(1, 4, 7, currentsign) ||
            checkMove(2, 5, 8, currentsign) || //column
            checkMove(0, 4, 8, currentsign) ||
            checkMove(2, 4, 6, currentsign) //diagnols
        ) {
      setState(() {
        winner = currentsign;
      });
    }
  }

  void reset() {
    setState(() {
      grid = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];
      winner = '';
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(primarySwatch: Colors.amber),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tic Tac Toe'),
        ),
        body: Column(
          children: [
            if (winner != '')
              Text(
                '$winner won the game',
                style: TextStyle(fontSize: 20),
              ),
            Container(
              //for web if we increse svreensize to set max width and height
              constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
              margin: EdgeInsets.all(10),

              color: Colors.black,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: grid.length,
                itemBuilder: (context, index) => Material(
                  color: Colors.amber,
                  child: InkWell(
                    splashColor: Colors.black,
                    onTap: () {
                      drawxo(index);
                    },
                    child: Center(
                      child: Text(
                        grid[index],
                        style: TextStyle(fontSize: 50),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton.icon(
                onPressed: reset,
                icon: Icon(Icons.refresh),
                label: Text('PLAY AGAIN'))
          ],
        ),
      ),
    );
  }
}
