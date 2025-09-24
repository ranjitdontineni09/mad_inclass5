// Digital Pet App with Hunger Timer Countdown

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "";
  int happinessLevel = 50;
  int hungerLevel = 50;
  int energyLevel = 50;
  bool gameOver = false;
  bool win = false;

  TextEditingController nameController = TextEditingController();
  Timer? hungerTimer;
  Timer? countdownTimer;
  int countdown = 30; // seconds until next hunger increase

  String selectedActivity = "Nap";

  @override
  void initState() {
    super.initState();

    // Hunger increases every 30 seconds
    hungerTimer = Timer.periodic(Duration(seconds: 30), (timer) {
      _increaseHunger();
      countdown = 30; // reset countdown after hunger increase
    });

    // Countdown timer updates every second
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (countdown > 0) countdown--;
      });
    });
  }

  @override
  void dispose() {
    hungerTimer?.cancel();
    countdownTimer?.cancel();
    super.dispose();
  }

  void _playWithPet() {
    if (!gameOver) {
      setState(() {
        happinessLevel += 10;
        energyLevel -= 5;
        _updateHunger();
      });
    }
  }

  void _feedPet() {
    if (!gameOver) {
      setState(() {
        hungerLevel -= 10;
        if (hungerLevel < 0) hungerLevel = 0;
        _updateHappiness();
      });
    }
  }

  void _increaseHunger() {
    if (!gameOver) {
      setState(() {
        hungerLevel += 5;
        if (hungerLevel > 100) hungerLevel = 100;
        _updateHappiness();
        _checkLossCondition();
      });
    }
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel -= 10;
    } else {
      happinessLevel += 5;
    }
    if (happinessLevel > 100) happinessLevel = 100;
    if (happinessLevel < 0) happinessLevel = 0;
    _checkLossCondition();
  }

  void _updateHunger() {
    hungerLevel += 5;
    if (hungerLevel > 100) hungerLevel = 100;
    _checkLossCondition();
  }

  void _checkLossCondition() {
    if (hungerLevel >= 100 && happinessLevel <= 10) {
      setState(() {
        gameOver = true;
      });
    }
  }

  void _checkWinCondition() {
    if (happinessLevel > 80) {
      setState(() {
        win = true;
      });
    }
  }

  // Mood based on happiness
  String get mood {
    if (happinessLevel > 70) return "😊 Happy";
    if (happinessLevel >= 30) return "😐 Neutral";
    return "😢 Unhappy";
  }

  // Color based on happiness
  Color get petColor {
    if (happinessLevel > 70) return Colors.green;
    if (happinessLevel >= 30) return Colors.yellow;
    return Colors.red;
  }

  void _performActivity(String activity) {
    if (!gameOver) {
      setState(() {
        if (activity == "Nap") {
          energyLevel += 20;
          happinessLevel += 5;
        } else if (activity == "Walk") {
          happinessLevel += 15;
          hungerLevel += 10;
          energyLevel -= 10;
        } else if (activity == "Sing") {
          happinessLevel += 10;
          energyLevel -= 5;
        }
        if (energyLevel > 100) energyLevel = 100;
        if (energyLevel < 0) energyLevel = 0;
        if (happinessLevel > 100) happinessLevel = 100;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (petName.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Name Your Pet")),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Enter your pet's name:", style: TextStyle(fontSize: 18)),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Pet Name",
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      petName = nameController.text.isEmpty
                          ? "Your Pet"
                          : nameController.text;
                    });
                  },
                  child: Text("Confirm Name"),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet: $petName'),
      ),
      body: Center(
        child: gameOver
            ? Text(
                "💀 Game Over! $petName could not survive...",
                style: TextStyle(fontSize: 20, color: Colors.red),
                textAlign: TextAlign.center,
              )
            : win
                ? Text(
                    "🎉 Congratulations! $petName is very happy!",
                    style: TextStyle(fontSize: 20, color: Colors.green),
                    textAlign: TextAlign.center,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.pets, size: 100, color: petColor),
                      Text(
                        'Mood: $mood',
                        style: TextStyle(fontSize: 22),
                      ),
                      SizedBox(height: 20),
                      Text('Happiness Level: $happinessLevel',
                          style: TextStyle(fontSize: 20)),
                      Text('Hunger Level: $hungerLevel',
                          style: TextStyle(fontSize: 20)),
                      Text('Energy Level: $energyLevel',
                          style: TextStyle(fontSize: 20)),
                      SizedBox(height: 10),
                      Text(
                        'Next hunger increase in: $countdown s',
                        style: TextStyle(fontSize: 18, color: Colors.orange),
                      ),
                      SizedBox(height: 20),
                      LinearProgressIndicator(
                        value: energyLevel / 100,
                        color: Colors.blue,
                        minHeight: 10,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _playWithPet,
                        child: Text('Play with $petName'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _feedPet,
                        child: Text('Feed $petName'),
                      ),
                      SizedBox(height: 20),
                      DropdownButton<String>(
                        value: selectedActivity,
                        items: ["Nap", "Walk", "Sing"].map((String activity) {
                          return DropdownMenuItem<String>(
                            value: activity,
                            child: Text(activity),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedActivity = newValue!;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _performActivity(selectedActivity);
                        },
                        child: Text("Do Activity"),
                      ),
                    ],
                  ),
      ),
    );
  }
}
