class ReceiveData {
  final String id;
  final custName;
  final custAmount;
  final date;

  ReceiveData(
      {required this.custAmount,
      required this.custName,
      required this.date,
      required this.id});

  factory ReceiveData.fromJson(Map<String, dynamic> json) {
    return ReceiveData(
        custAmount: json['custAmount'],
        custName: json['custName'],
        date: json['date'],
        id: json['id']);
  }
}
