class TotalReceived {
  final String id;
  final totalReceived;

  TotalReceived({required this.id, required this.totalReceived});

  factory TotalReceived.fromJson(Map<String, dynamic> json) {
    return TotalReceived(totalReceived: json['totalReceived'], id: json['id']);
  }
}
