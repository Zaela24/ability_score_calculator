import 'package:ability_score_calculator/data/races.dart';
import 'package:ability_score_calculator/models/race.dart';
import 'package:ability_score_calculator/models/score_costs.dart';
import 'package:flutter/material.dart';

class DND5ePointBuyScreen extends StatefulWidget {
  const DND5ePointBuyScreen({super.key});

  @override
  State<DND5ePointBuyScreen> createState() => _DND5ePointBuyScreenState();
}

class _DND5ePointBuyScreenState extends State<DND5ePointBuyScreen> {
  final TextEditingController otherScoreController = TextEditingController();
  String? selectedRace = 'Dragonborn';
  String? selectedSubRace;
  final double scoreDropdownWidth = 75;
  final Map<String, int> abilityCosts = {
    'STR': 0,
    'DEX': 0,
    'CON': 0,
    'INT': 0,
    'WIS': 0,
    'CHA': 0,
  };
  Map<String, int> customRacialMods = {
    'STR': 0,
    'DEX': 0,
    'CON': 0,
    'INT': 0,
    'WIS': 0,
    'CHA': 0,
  };

  int get abilityCostTotal => abilityCosts.values.reduce((a, b) => a + b);

  @override
  Widget build(BuildContext context) {
    Map<String, int> abilityTotals = {
      'STR': 0,
      'DEX': 0,
      'CON': 0,
      'INT': 0,
      'WIS': 0,
      'CHA': 0,
    };
    Race fullSelectedRace =
        dnd5eRaces.firstWhere((race) => race.name == selectedRace);
    List<Race>? subRaces = fullSelectedRace.subRaces;
    if (subRaces != null &&
        (selectedSubRace == null ||
            !subRaces
                .map((subRace) => subRace.name)
                .contains(selectedSubRace))) {
      selectedSubRace = subRaces.first.name;
    }

    for (final abilityCost in abilityCosts.entries) {
      if (selectedRace == 'Half-Elf') {
        abilityTotals[abilityCost.key] = dnd5eScoreCosts.keys.firstWhere(
                (key) =>
                    dnd5eScoreCosts[key] == abilityCosts[abilityCost.key]) +
            fullSelectedRace.abilityScoreMods[abilityCost.key]! +
            customRacialMods[abilityCost.key]!;
      } else {
        abilityTotals[abilityCost.key] = dnd5eScoreCosts.keys.firstWhere(
                (key) =>
                    dnd5eScoreCosts[key] == abilityCosts[abilityCost.key]) +
            fullSelectedRace.abilityScoreMods[abilityCost.key]! +
            (subRaces != null && selectedSubRace != null
                ? subRaces
                    .firstWhere((subRace) => subRace.name == selectedSubRace)
                    .abilityScoreMods[abilityCost.key]!
                : 0);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ability Scores'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              runSpacing: 8,
              children: [
                DropdownMenu(
                  dropdownMenuEntries: [
                    for (final race in dnd5eRaces)
                      DropdownMenuEntry(value: race.name, label: race.name)
                  ],
                  initialSelection: selectedRace,
                  onSelected: (race) {
                    setState(() {
                      selectedRace = race;
                    });
                  },
                  inputDecorationTheme: const InputDecorationTheme(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (subRaces != null)
                  DropdownMenu(
                    dropdownMenuEntries: [
                      for (final subRace in subRaces)
                        DropdownMenuEntry(
                            value: subRace.name, label: subRace.name)
                    ],
                    initialSelection: selectedSubRace,
                    onSelected: (subRace) {
                      setState(() {
                        selectedSubRace = subRace;
                      });
                    },
                    inputDecorationTheme: const InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Scrollbar(
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(columns: const [
                  DataColumn(label: Text('Ability')),
                  DataColumn(label: Text('Points')),
                  DataColumn(label: Text('Cost')),
                  DataColumn(label: Text('Racial Bonus')),
                  DataColumn(label: Text('Total')),
                  DataColumn(label: Text('Mod'))
                ], rows: [
                  for (final abilityCost in abilityCosts.entries)
                    DataRow(cells: [
                      DataCell(Text(abilityCost.key)),
                      DataCell(SizedBox(
                        width: scoreDropdownWidth,
                        child: DropdownMenu(
                          width: scoreDropdownWidth,
                          dropdownMenuEntries: dnd5eScoreCosts.entries
                              .map((scoreCost) => DropdownMenuEntry(
                                  value: scoreCost.value,
                                  label: scoreCost.key.toString()))
                              .toList(),
                          initialSelection: abilityCost.value,
                          onSelected: (cost) {
                            setState(() {
                              abilityCosts[abilityCost.key] = cost!;
                            });
                          },
                          inputDecorationTheme: const InputDecorationTheme(
                              border: InputBorder.none),
                        ),
                      )),
                      // ability score point buy cost
                      DataCell(Text(abilityCost.value.toString())),
                      // racial modifier
                      if (selectedRace == 'Half-Elf' &&
                          abilityCost.key != 'CHA')
                        DataCell(
                          SizedBox(
                            width: scoreDropdownWidth,
                            child: DropdownMenu(
                              width: scoreDropdownWidth,
                              dropdownMenuEntries: const [
                                DropdownMenuEntry(value: 0, label: '0'),
                                DropdownMenuEntry(value: 1, label: '1')
                              ],
                              enabled: customRacialMods.values
                                          .where((customMod) => customMod == 1)
                                          .length <
                                      2 ||
                                  customRacialMods[abilityCost.key] == 1,
                              initialSelection:
                                  customRacialMods[abilityCost.key],
                              onSelected: (value) {
                                setState(() {
                                  customRacialMods[abilityCost.key] = value!;
                                });
                              },
                              inputDecorationTheme: const InputDecorationTheme(
                                  border: InputBorder.none),
                            ),
                          ),
                        )
                      else
                        DataCell(Text((fullSelectedRace
                                    .abilityScoreMods[abilityCost.key]! +
                                (subRaces != null && selectedSubRace != null
                                    ? subRaces
                                        .firstWhere((subRace) =>
                                            subRace.name == selectedSubRace)
                                        .abilityScoreMods[abilityCost.key]!
                                    : 0))
                            .toString())),
                      // total score
                      DataCell(
                          Text((abilityTotals[abilityCost.key]).toString())),
                      // modifer -- displays + if total score 12+
                      DataCell(Text(abilityTotals[abilityCost.key]! > 11
                          ? '+${((abilityTotals[abilityCost.key]! - 10) / 2).floor()}'
                          : ((abilityTotals[abilityCost.key]! - 10) / 2)
                              .floor()
                              .toString())),
                    ]),
                ]),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Total Cost:',
              style: TextStyle(fontSize: 22),
            ),
            Text(
              '$abilityCostTotal/27',
              style: TextStyle(
                  fontSize: 50,
                  color: abilityCostTotal > 27
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      ),
    );
  }
}
