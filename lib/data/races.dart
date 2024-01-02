import 'package:ability_score_calculator/models/race.dart';

List<Race> races = [
  Race(name: 'Dwarf', abilityScoreMods: {
    'STR': 0,
    'DEX': 0,
    'CON': 2,
    'INT': 0,
    'WIS': 2,
    'CHA': -2,
  }),
  Race(name: 'Elf', abilityScoreMods: {
    'STR': 0,
    'DEX': 2,
    'CON': -2,
    'INT': 2,
    'WIS': 0,
    'CHA': 0,
  }),
  Race(name: 'Gnome', abilityScoreMods: {
    'STR': -2,
    'DEX': 0,
    'CON': 2,
    'INT': 0,
    'WIS': 0,
    'CHA': 2,
  }),
  Race(
    name: 'Half-Elf',
    abilityScoreMods: {
      // +2 to any
      'STR': 0,
      'DEX': 0,
      'CON': 0,
      'INT': 0,
      'WIS': 0,
      'CHA': 0,
    },
  ),
  Race(
    name: 'Half-Orc',
    abilityScoreMods: {
      // +2 to any
      'STR': 0,
      'DEX': 0,
      'CON': 0,
      'INT': 0,
      'WIS': 0,
      'CHA': 0,
    },
  ),
  Race(name: 'Halfling', abilityScoreMods: {
    'STR': -2,
    'DEX': 2,
    'CON': 0,
    'INT': 0,
    'WIS': 0,
    'CHA': 2,
  }),
  Race(
    name: 'Human',
    abilityScoreMods: {
      // +2 to any
      'STR': 0,
      'DEX': 0,
      'CON': 0,
      'INT': 0,
      'WIS': 0,
      'CHA': 0,
    },
  ),
];
