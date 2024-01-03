import 'package:ability_score_calculator/data/races.dart';
import 'package:ability_score_calculator/models/campaign_type.dart';
import 'package:ability_score_calculator/models/score_costs.dart';
import 'package:flutter/material.dart';

class PathfinderPointBuyScreen extends StatefulWidget {
  const PathfinderPointBuyScreen({super.key});

  @override
  State<PathfinderPointBuyScreen> createState() =>
      _PathfinderPointBuyScreenState();
}

class _PathfinderPointBuyScreenState extends State<PathfinderPointBuyScreen> {
  final TextEditingController otherScoreController = TextEditingController();
  int? selectedScore = 15; // set default score to 'Standard Fantasy'
  String? selectedRace = 'Dwarf';
  final double scoreDropdownWidth = 75;
  final Map<String, int> abilityCosts = {
    'STR': 0,
    'DEX': 0,
    'CON': 0,
    'INT': 0,
    'WIS': 0,
    'CHA': 0,
  };

  @override
  Widget build(BuildContext context) {
    otherScoreController.text = selectedScore.toString();
    Map<String, int> abilityTotals = {
      'STR': 0,
      'DEX': 0,
      'CON': 0,
      'INT': 0,
      'WIS': 0,
      'CHA': 0,
    };
    for (final abilityCost in abilityCosts.entries) {
      abilityTotals[abilityCost.key] = pathfinder1eScoreCosts.keys.firstWhere(
              (key) =>
                  pathfinder1eScoreCosts[key] ==
                  abilityCosts[abilityCost.key]) +
          races
              .firstWhere((race) => race.name == selectedRace)
              .abilityScoreMods[abilityCost.key]!;
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
              runSpacing: 16,
              children: [
                SizedBox(
                  width: 225,
                  child: DropdownMenu(
                    enableSearch: false,
                    inputDecorationTheme: const InputDecorationTheme(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    dropdownMenuEntries: [
                      ...CampaignType.values.map(
                        (CampaignType campaignType) => DropdownMenuEntry(
                          value: campaignTypePoints[campaignType],
                          label: campaignType.adjustedName,
                        ),
                      ),
                      DropdownMenuEntry(
                        value: int.tryParse(otherScoreController.text) ?? 0,
                        label: 'Other',
                      )
                    ],
                    initialSelection: selectedScore,
                    onSelected: (campaignTypeScore) {
                      setState(() {
                        selectedScore = campaignTypeScore;
                        otherScoreController.text = selectedScore.toString();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: TextField(
                    controller: otherScoreController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Point Buy Score',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          selectedScore = int.tryParse(value);
                        });
                      }
                    },
                  ),
                ),
                if (MediaQuery.of(context).size.width > 500)
                  const SizedBox(
                    width: 16,
                  ),
                DropdownMenu(
                  dropdownMenuEntries: [
                    for (final race in races)
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
                  DataColumn(label: Text('Racial Trait')),
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
                          dropdownMenuEntries: pathfinder1eScoreCosts.entries
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
                      DataCell(Text(races
                          .firstWhere((race) => race.name == selectedRace)
                          .abilityScoreMods[abilityCost.key]
                          .toString())),
                      // total score
                      DataCell(
                          Text((abilityTotals[abilityCost.key]).toString())),
                      // modifer -- displays + if total score 12+
                      DataCell(Text(abilityTotals[abilityCost.key]! > 11
                          ? '+${((abilityTotals[abilityCost.key]! - 10) / 2).truncate()}'
                          : ((abilityTotals[abilityCost.key]! - 10) / 2)
                              .truncate()
                              .toString())),
                    ]),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
