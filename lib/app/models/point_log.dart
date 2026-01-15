class PointLogItem {
  final int id;
  final String title;
  final String tag;
  final num points;
  final num walletPointsAfter;
  final num walletBalanceAfter;
  final String date;
  final String type;

  PointLogItem({
    required this.id,
    required this.title,
    required this.tag,
    required this.points,
    required this.walletPointsAfter,
    required this.walletBalanceAfter,
    required this.date,
    required this.type,
  });

  factory PointLogItem.fromJson(Map<String, dynamic> json) => PointLogItem(
        id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
        title: json['title']?.toString() ?? '',
        points: json['points'] ?? 0,
        walletPointsAfter: json['wallet_points_after'] ?? 0,
        walletBalanceAfter: json['wallet_balance_after'] ?? 0,
        date: json['date']?.toString() ?? '',
        tag: json['tag']?.toString() ?? '',
        type: json['type']?.toString() ?? '',
      );
}
