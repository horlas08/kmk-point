class ScanHistoryItem {
  final int id;
  final String category;
  final String tag;
  final num points;
  final String qrCode;
  final String createdAt;

  ScanHistoryItem({
    required this.id,
    required this.category,
    required this.tag,
    required this.points,
    required this.qrCode,
    required this.createdAt,
  });

  factory ScanHistoryItem.fromJson(Map<String, dynamic> json) => ScanHistoryItem(
        id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
        category: json['category']?.toString() ?? '',
        tag: json['tag']?.toString() ?? '',
        points: json['points'] ?? int.tryParse('${json['points']}') ?? 0,
        qrCode: json['qr_code']?.toString() ?? json['qrCode']?.toString() ?? '',
        createdAt: json['created_at']?.toString() ?? json['createdAt']?.toString() ?? '',
      );
}
