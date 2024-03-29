import 'package:dart_dice_parser/dart_dice_parser.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PathfinderDiceRollScreen extends StatefulWidget {
  const PathfinderDiceRollScreen({super.key});

  @override
  State<PathfinderDiceRollScreen> createState() {
    return _PathfinderDiceRollScreenState();
  }
}

class _PathfinderDiceRollScreenState extends State<PathfinderDiceRollScreen> {
  List<TextEditingController> standardRollControllers = [
    for (int i = 0; i < 6; i++) TextEditingController()
  ];
  List<TextEditingController> classicRollControllers = [
    for (int i = 0; i < 6; i++) TextEditingController()
  ];
  List<TextEditingController> heroicRollControllers = [
    for (int i = 0; i < 6; i++) TextEditingController()
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (int i = 0; i < 6; i++)
                SizedBox(
                  width: 50,
                  child: TextField(
                      controller: standardRollControllers[i], readOnly: true),
                ),
              ElevatedButton.icon(
                  onPressed: () {
                    final standardRoll = DiceExpression.create('4d6 kh3');
                    setState(() {
                      for (int i = 0; i < 6; i++) {
                        standardRollControllers[i].text =
                            standardRoll.roll().total.toString();
                      }
                    });
                  },
                  icon: const FaIcon(FontAwesomeIcons.diceD20),
                  label: const Text('Standard Roll')),
              Tooltip(
                message:
                    "Rolls six 4d6, dropping the lowest roll; assign in any order.",
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 7, 255),
                      Color.fromARGB(255, 1, 140, 159)
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                textStyle: const TextStyle(color: Colors.white),
                child: FaIcon(
                  FontAwesomeIcons.circleQuestion,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (int i = 0; i < 6; i++)
                SizedBox(
                  width: 50,
                  child: TextField(
                      controller: classicRollControllers[i], readOnly: true),
                ),
              ElevatedButton.icon(
                  onPressed: () {
                    final classicRoll = DiceExpression.create('3d6');
                    setState(() {
                      for (int i = 0; i < 6; i++) {
                        classicRollControllers[i].text =
                            classicRoll.roll().total.toString();
                      }
                    });
                  },
                  icon: const FaIcon(FontAwesomeIcons.diceD20),
                  label: const Text('Classic Roll')),
              Tooltip(
                message: "Rolls six 3d6; assign in any order.",
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 188, 3, 188),
                      Color.fromARGB(255, 1, 140, 159)
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                textStyle: const TextStyle(color: Colors.white),
                child: FaIcon(
                  FontAwesomeIcons.circleQuestion,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (int i = 0; i < 6; i++)
                SizedBox(
                  width: 50,
                  child: TextField(
                      controller: heroicRollControllers[i], readOnly: true),
                ),
              ElevatedButton.icon(
                  onPressed: () {
                    final classicRoll = DiceExpression.create('2d6 + 6');
                    setState(() {
                      for (int i = 0; i < 6; i++) {
                        heroicRollControllers[i].text =
                            classicRoll.roll().total.toString();
                      }
                    });
                  },
                  icon: const FaIcon(FontAwesomeIcons.diceD20),
                  label: const Text('Heroic Roll')),
              Tooltip(
                message: "Rolls six 2d6 + 6; assign in any order.",
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 7, 255),
                      Color.fromARGB(255, 1, 140, 159)
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                textStyle: const TextStyle(color: Colors.white),
                child: FaIcon(
                  FontAwesomeIcons.circleQuestion,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
