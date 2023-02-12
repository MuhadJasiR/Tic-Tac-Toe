// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tac_toe/constants/colors.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String resultDeclaration = "";
  bool oTurn = true;
  List<String> displayXo = ["", "", "", "", "", "", "", "", ""];
  List<int> matchedIndexes = [];
  int attempts = 0;
  int scoreO = 0;
  int scoreX = 0;
  int filledBox = 0;
  bool winnerFound = false;
  static const maxSeconds = 30;
  int seconds = maxSeconds;
  Timer? timer;
  static var customFontWhite = GoogleFonts.coiny(
    textStyle: const TextStyle(
      color: Colors.white,
      letterSpacing: 3,
      fontSize: 28,
    ),
  );

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          stopTimer();
        }
      });
    });
  }

  void stopTimer() {
    resetTimer();
    timer?.cancel();
  }

  void resetTimer() {
    seconds = maxSeconds;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: MainColors.primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Player O",
                            style: customFontWhite,
                          ),
                          Text(
                            scoreO.toString(),
                            style: customFontWhite,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Player X",
                            style: customFontWhite,
                          ),
                          Text(
                            scoreX.toString(),
                            style: customFontWhite,
                          )
                        ],
                      )
                    ],
                  )),
                ),
                Expanded(
                    flex: 3,
                    child: GridView.builder(
                        itemCount: 9,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: (() {
                              tapped(index);
                            }),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 5, color: MainColors.primaryColor),
                                color: matchedIndexes.contains(index)
                                    ? MainColors.accentColor
                                    : MainColors.secondColor,
                              ),
                              child: Center(
                                child: Text(
                                  displayXo[index],
                                  style: GoogleFonts.coiny(
                                      textStyle: TextStyle(
                                          fontSize: 64,
                                          color: MainColors.primaryColor)),
                                ),
                              ),
                            ),
                          );
                        }))),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          resultDeclaration,
                          style: customFontWhite,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        buildBoxes()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void tapped(int index) {
    final isRunning = timer == null ? false : timer!.isActive;

    if (isRunning) {
      setState(() {
        if (oTurn && displayXo[index] == "") {
          displayXo[index] = "O";
          filledBox++;
        } else if (!oTurn && displayXo[index] == "") {
          displayXo[index] = "X";
          filledBox++;
        }

        oTurn = !oTurn;
        _checkWinner();
      });
    }
  }

  void _checkWinner() {
    if (displayXo[0] == displayXo[1] &&
        displayXo[0] == displayXo[2] &&
        displayXo[0] != '') {
      setState(() {
        resultDeclaration = "Player  ${displayXo[0]}  Wins";
        matchedIndexes.addAll([0, 1, 2]);
        stopTimer();
        updateScore(displayXo[0]);
      });
    }

    if (displayXo[3] == displayXo[4] &&
        displayXo[3] == displayXo[5] &&
        displayXo[3] != '') {
      setState(() {
        resultDeclaration = "Player  ${displayXo[3]}  Wins";
        matchedIndexes.addAll([3, 4, 5]);
        stopTimer();
        updateScore(displayXo[3]);
      });
    }

    if (displayXo[6] == displayXo[7] &&
        displayXo[6] == displayXo[8] &&
        displayXo[6] != '') {
      setState(() {
        resultDeclaration = "Player  ${displayXo[6]}  Wins";
        matchedIndexes.addAll([6, 7, 8]);
        stopTimer();
        updateScore(displayXo[6]);
      });
    }

    if (displayXo[0] == displayXo[3] &&
        displayXo[0] == displayXo[6] &&
        displayXo[0] != '') {
      setState(() {
        resultDeclaration = "Player  ${displayXo[0]}  Wins";
        matchedIndexes.addAll([0, 3, 6]);
        stopTimer();
        updateScore(displayXo[0]);
      });
    }

    if (displayXo[1] == displayXo[4] &&
        displayXo[1] == displayXo[7] &&
        displayXo[1] != '') {
      setState(() {
        resultDeclaration = "Player  ${displayXo[1]}  Wins";
        matchedIndexes.addAll([1, 4, 7]);
        stopTimer();
        updateScore(displayXo[1]);
      });
    }

    if (displayXo[2] == displayXo[5] &&
        displayXo[2] == displayXo[8] &&
        displayXo[2] != '') {
      setState(() {
        resultDeclaration = "Player  ${displayXo[2]}  Wins";
        matchedIndexes.addAll([2, 5, 8]);
        stopTimer();
        updateScore(displayXo[2]);
      });
    }

    if (displayXo[0] == displayXo[4] &&
        displayXo[0] == displayXo[8] &&
        displayXo[0] != '') {
      setState(() {
        resultDeclaration = "Player  ${displayXo[0]}  Wins";
        matchedIndexes.addAll([0, 4, 8]);
        stopTimer();
        updateScore(displayXo[0]);
      });
    }

    if (displayXo[2] == displayXo[4] &&
        displayXo[2] == displayXo[6] &&
        displayXo[2] != '') {
      setState(() {
        resultDeclaration = "Player  ${displayXo[2]}  Wins";
        matchedIndexes.addAll([2, 4, 6]);
        stopTimer();
        updateScore(displayXo[2]);
      });
    }

    if (winnerFound && filledBox == 9) {
      setState(() {
        resultDeclaration = "Nobody Wins!";
      });
    }
  }

  void updateScore(String winner) {
    if (winner == "O") {
      scoreO++;
    } else if (winner == "X") {
      scoreX++;
    }
  }

  void clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXo[i] = '';
      }
      resultDeclaration = '';
    });
    filledBox = 0;
  }

  Widget buildBoxes() {
    final isRunning = timer == null ? false : timer!.isActive;

    return isRunning
        ? SizedBox(
            width: 100,
            height: 100,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: 1 - seconds / maxSeconds,
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                  strokeWidth: 8,
                  backgroundColor: MainColors.accentColor,
                ),
                Center(
                  child: Text(
                    "$seconds",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 50),
                  ),
                )
              ],
            ),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
            onPressed: () {
              startTimer();
              clearBoard();
              attempts++;
            },
            child: Text(
              attempts == 0 ? "Start" : "Play Again!",
              style: const TextStyle(color: Colors.black),
            ),
          );
  }
}
