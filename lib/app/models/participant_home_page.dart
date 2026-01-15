class ParticipantHomePageData {
  final WalletInfo walletInfo;
  final int currentParticipantRank;
  final HomePageStatistics homePageStatistics;
  final List<TopParticipant> topTenParticipants;
  final int unreadNotificationsCount;

  ParticipantHomePageData({
    required this.walletInfo,
    required this.currentParticipantRank,
    required this.homePageStatistics,
    required this.unreadNotificationsCount,
    required this.topTenParticipants,
  });

  factory ParticipantHomePageData.fromJson(Map<String, dynamic> json) {
    return ParticipantHomePageData(
      walletInfo: WalletInfo.fromJson(json['wallet_info'] ?? {}),
      unreadNotificationsCount: json['unread_notifications_count'] is int
          ? json['unread_notifications_count']
          : int.tryParse(json['unread_notifications_count']),
      currentParticipantRank: json['current_participant_rank'] is int
          ? json['current_participant_rank']
          : int.tryParse('${json['current_participant_rank']}') ?? 0,
      homePageStatistics: HomePageStatistics.fromJson(
        json['home_page_statistics'] ?? {},
      ),
      topTenParticipants:
          (json['top_ten_participants']?['top_10'] as List? ?? [])
              .map((e) => TopParticipant.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'wallet_info': walletInfo.toJson(),
    'unread_notifications_count': unreadNotificationsCount,
    'current_participant_rank': currentParticipantRank,
    'home_page_statistics': homePageStatistics.toJson(),
    'top_ten_participants': {
      'top_10': topTenParticipants.map((e) => e.toJson()).toList(),
    },
  };
}

class WalletInfo {
  final num walletPoints;
  final num walletBalance;
  final String projectName;

  WalletInfo({
    required this.walletPoints,
    required this.walletBalance,
    required this.projectName,
  });

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
    walletPoints: json['wallet_points'] ?? 0,
    walletBalance: json['wallet_balance'] ?? 0,
    projectName: json['project_name']?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    'wallet_points': walletPoints,
    'wallet_balance': walletBalance,
    'project_name': projectName,
  };
}

class HomePageStatistics {
  final PeriodStats week;
  final PeriodStats month;

  HomePageStatistics({required this.week, required this.month});

  factory HomePageStatistics.fromJson(Map<String, dynamic> json) =>
      HomePageStatistics(
        week: PeriodStats.fromJson(json['week'] ?? {}),
        month: PeriodStats.fromJson(json['month'] ?? {}),
      );

  Map<String, dynamic> toJson() => {
    'week': week.toJson(),
    'month': month.toJson(),
  };
}

class PeriodStats {
  final num points;
  final num growthPercentage;
  final String growthLabel;
  final String growthDirection;

  PeriodStats({
    required this.points,
    required this.growthPercentage,
    required this.growthLabel,
    required this.growthDirection,
  });

  factory PeriodStats.fromJson(Map<String, dynamic> json) => PeriodStats(
    points: json['points'] ?? 0,
    growthPercentage: json['growth_percentage'] ?? 0,
    growthLabel: json['growth_label']?.toString() ?? '',
    growthDirection: json['growth_direction']?.toString() ?? '',
  );

  Map<String, dynamic> toJson() => {
    'points': points,
    'growth_percentage': growthPercentage,
    'growth_label': growthLabel,
    'growth_direction': growthDirection,
  };
}

class TopParticipant {
  final int order;
  final int studentId;
  final String name;
  final num points;
  final num balance;
  final bool isHighlighted;

  TopParticipant({
    required this.order,
    required this.studentId,
    required this.name,
    required this.points,
    required this.balance,
    required this.isHighlighted,
  });

  factory TopParticipant.fromJson(Map<String, dynamic> json) => TopParticipant(
    order: json['order'] is int
        ? json['order']
        : int.tryParse('${json['order']}') ?? 0,
    studentId: json['student_id'] is int
        ? json['student_id']
        : int.tryParse('${json['student_id']}') ?? 0,
    name: json['name']?.toString() ?? '',
    points: json['points'] ?? 0,
    balance: json['balance'] ?? 0,
    isHighlighted: json['is_highlighted'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'order': order,
    'student_id': studentId,
    'name': name,
    'points': points,
    'balance': balance,
    'is_highlighted': isHighlighted,
  };
}
