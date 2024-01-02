enum CampaignType {
  low,
  standard,
  high,
  epic;

  /// gets string with name adjusted, for example [low] evaluates to `'Low Fantasy'`
  String get adjustedName =>
      '${name.substring(0, 1).toUpperCase()}${name.substring(1)} Fantasy';
}

Map<CampaignType, int> campaignTypePoints = {
  CampaignType.low: 10,
  CampaignType.standard: 15,
  CampaignType.high: 20,
  CampaignType.epic: 25,
};
