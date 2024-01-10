import 'package:ability_score_calculator/widgets/dnd5e_point_buy.dart';
import 'package:ability_score_calculator/widgets/main_drawer.dart';
import 'package:ability_score_calculator/widgets/pathfinder_dice_roll.dart';
import 'package:ability_score_calculator/widgets/pathinder_point_buy.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PathfinderTabsScreen extends StatefulWidget {
  const PathfinderTabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PathfinderTabsScreen();
  }
}

class _PathfinderTabsScreen extends State<PathfinderTabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == 'dnd') {
      await Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const DND5ePointBuyScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const PathfinderPointBuyScreen();
    String activeTitle = "Ability Score Calculator";

    if (_selectedPageIndex == 1) {
      activePage = const PathfinderDiceRollScreen();
      activeTitle = "Pathfinder Dice Roller";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activeTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.one), label: "Point Buy"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.diceD20), label: "Dice Roller")
        ],
      ),
    );
  }
}
