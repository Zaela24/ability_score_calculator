import 'package:ability_score_calculator/models/campaign_type.dart';
import 'package:ability_score_calculator/models/score_costs.dart';
import 'package:flutter/material.dart';

class AbilityScoreScreen extends StatefulWidget {
  const AbilityScoreScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AbilityScoreScreenState();
}

class _AbilityScoreScreenState extends State<AbilityScoreScreen> {
  final TextEditingController otherScoreController = TextEditingController();
  int? selectedScore = 15; // set default score to 'standard'
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
            Row(
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
                Expanded(
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
                )
              ],
            ),
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
                      DataCell(Text(abilityCost.value.toString())),
                      const DataCell(Text('0')),
                      DataCell.empty,
                      DataCell.empty
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
