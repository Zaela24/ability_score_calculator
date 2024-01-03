class Race {
  Race({required this.name, required this.abilityScoreMods, this.subRaces});

  final String name;
  final Map<String, int> abilityScoreMods;
  List<Race>? subRaces;
}
