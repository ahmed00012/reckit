
class TripModel {
  final String id;
  final String status;
  final String title;
  final String start;
  final String end;
  final List<ParticipantModel> participants;
  final int unfinishedTasks;
  final String coverImage;

  TripModel({
    required this.id,
    required this.status,
    required this.title,
    required this.start,
    required this.end,
    required this.participants,
    required this.unfinishedTasks,
    required this.coverImage,
  });

  factory TripModel.fromJson(Map<String, dynamic> j) {
    final dates = j['dates'] ?? {};
    final participants = (j['participants'] as List<dynamic>)
        .map((p) => ParticipantModel.fromJson(p))
        .toList();
    return TripModel(
      id: j['id'],
      status: j['status'],
      title: j['title'],
      start: dates['start'] ?? '',
      end: dates['end'] ?? '',
      participants: participants,
      unfinishedTasks: j['unfinished_tasks'] ?? 0,
      coverImage: j['cover_image'] ?? '',
    );
  }
}


class ParticipantModel {
  final String name;
  final String avatarUrl;
  ParticipantModel({required this.name, required this.avatarUrl});
  factory ParticipantModel.fromJson(Map<String, dynamic> j) =>
      ParticipantModel(name: j['name'], avatarUrl: j['avatar_url']);
}