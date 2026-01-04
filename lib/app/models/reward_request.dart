class RewardRequestStatistics {
  final int accepted;
  final int pending;
  final int rejected;

  RewardRequestStatistics({
    required this.accepted,
    required this.pending,
    required this.rejected,
  });

  factory RewardRequestStatistics.fromJson(Map<String, dynamic> json) =>
      RewardRequestStatistics(
        accepted: json['accepted'] is int
            ? json['accepted']
            : int.tryParse('${json['accepted']}') ?? 0,
        pending: json['pending'] is int
            ? json['pending']
            : int.tryParse('${json['pending']}') ?? 0,
        rejected: json['rejected'] is int
            ? json['rejected']
            : int.tryParse('${json['rejected']}') ?? 0,
      );
}

class RewardRequestHistoryItem {
  final int id;
  final String reward;
  final num point;
  final String date;
  final String status;

  RewardRequestHistoryItem({
    required this.id,
    required this.reward,
    required this.point,
    required this.date,
    required this.status,
  });

  factory RewardRequestHistoryItem.fromJson(Map<String, dynamic> json) =>
      RewardRequestHistoryItem(
        id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
        reward: json['reward']?.toString() ?? json['reward_name']?.toString() ?? '',
        point: json['point'] ?? json['points'] ?? 0,
        date: json['date']?.toString() ?? json['created_at']?.toString() ?? '',
        status: json['status']?.toString() ?? json['reward_request_status']?.toString() ?? '',
      );
}

class RewardRequestStatAndHistory {
  final RewardRequestStatistics statistics;
  final List<RewardRequestHistoryItem> history;

  RewardRequestStatAndHistory({
    required this.statistics,
    required this.history,
  });

  factory RewardRequestStatAndHistory.fromJson(Map<String, dynamic> json) {
    final statsJson = json['statistics'] as Map<String, dynamic>? ?? {};
    final historyList = (json['history'] as List? ?? []).cast<Map<String, dynamic>>();
    return RewardRequestStatAndHistory(
      statistics: RewardRequestStatistics.fromJson(statsJson),
      history: historyList.map((e) => RewardRequestHistoryItem.fromJson(e)).toList(),
    );
  }
}

class Reward {
  final int id;
  final String name;

  Reward({required this.id, required this.name});

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
        name: json['name']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
