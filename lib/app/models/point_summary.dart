class PointPageSummary {
  final int totalAddedPoints;
  final int totalDeductedPoints;
  final int totalConsumedPointsByRewards;

  PointPageSummary({
    required this.totalAddedPoints,
    required this.totalDeductedPoints,
    required this.totalConsumedPointsByRewards,
  });

  factory PointPageSummary.fromJson(Map<String, dynamic> json) {
    // values may come as strings or numbers
    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is double) return v.toInt();
      final s = v.toString();
      return int.tryParse(s.replaceAll(RegExp(r"[^0-9\-]"), '')) ?? 0;
    }

    return PointPageSummary(
      totalAddedPoints: parseInt(json['total_added_points']),
      totalDeductedPoints: parseInt(json['total_deducted_points']),
      totalConsumedPointsByRewards: parseInt(json['total_consumed_points_by_rewards']),
    );
  }

  /// Combined used points as requested (deducted + consumed_by_rewards)
  int get totalUsedPoints => totalDeductedPoints + totalConsumedPointsByRewards;
}
