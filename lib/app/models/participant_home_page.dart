class ParticipantHomePageData {
  final WalletInfo walletInfo;
  final HomePageStatistics homePageStatistics;
  final List<TopParticipant> topTenParticipants;

  ParticipantHomePageData({
    required this.walletInfo,
    required this.homePageStatistics,
    required this.topTenParticipants,
  });

  factory ParticipantHomePageData.fromJson(Map<String, dynamic> json) {
    return ParticipantHomePageData(
      walletInfo: WalletInfo.fromJson(json['wallet_info'] ?? {}),
      homePageStatistics:
          HomePageStatistics.fromJson(json['home_page_statistics'] ?? {}),
      topTenParticipants: (json['top_ten_participants'] as List? ?? [])
          .map((e) => TopParticipant.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'wallet_info': walletInfo.toJson(),
        'home_page_statistics': homePageStatistics.toJson(),
        'top_ten_participants': topTenParticipants.map((e) => e.toJson()).toList(),
      };
}

class WalletInfo {
  final num walletPoints;
  final num walletBalance;

  WalletInfo({required this.walletPoints, required this.walletBalance});

  factory WalletInfo.fromJson(Map<String, dynamic> json) => WalletInfo(
        walletPoints: json['wallet_points'] ?? 0,
        walletBalance: json['wallet_balance'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'wallet_points': walletPoints,
        'wallet_balance': walletBalance,
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

  PeriodStats({required this.points, required this.growthPercentage});

  factory PeriodStats.fromJson(Map<String, dynamic> json) => PeriodStats(
        points: json['points'] ?? 0,
        growthPercentage: json['growth_percentage'] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'points': points,
        'growth_percentage': growthPercentage,
      };
}

class TopParticipant {
  final int order;
  final int studentId;
  final String name;
  final num points;
  final num balance;

  TopParticipant({
    required this.order,
    required this.studentId,
    required this.name,
    required this.points,
    required this.balance,
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
      );

  Map<String, dynamic> toJson() => {
        'order': order,
        'student_id': studentId,
        'name': name,
        'points': points,
        'balance': balance,
      };
}
