class NotificationItem {
  final int id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final String createdAt;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) => NotificationItem(
        id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
        title: json['title']?.toString() ?? '',
        message: json['message']?.toString() ?? '',
        type: json['type']?.toString() ?? '',
        isRead: json['is_read'] is bool
            ? json['is_read']
            : (json['is_read'] is int ? (json['is_read'] == 1) : false),
        createdAt: json['created_at']?.toString() ?? json['createdAt']?.toString() ?? '',
      );
}
