class TimerEntry {
  int? id;
  String name;
  int totalSeconds;
  int remainingSeconds;
  bool isRunning;

  TimerEntry({
    this.id,
    required this.name,
    required this.totalSeconds,
    required this.remainingSeconds,
    required this.isRunning,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'totalSeconds': totalSeconds,
      'remainingSeconds': remainingSeconds,
      'isRunning': isRunning ? 1 : 0,
    };
  }

  factory TimerEntry.fromMap(Map<String, dynamic> map) {
    return TimerEntry(
      id: map['id'],
      name: map['name'],
      totalSeconds: map['totalSeconds'],
      remainingSeconds: map['remainingSeconds'],
      isRunning: map['isRunning'] == 1,
    );
  }
}
