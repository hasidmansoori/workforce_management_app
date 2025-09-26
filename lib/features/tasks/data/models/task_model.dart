import '../../domain/entities/task.dart';

class TaskModel extends Task1 {
  const TaskModel({
    required String id,
    required String title,
    required String description,
    required String assignedTo,
    required DateTime createdAt,
    DateTime? dueDate,
    TaskStatus status = TaskStatus.todo,
  }) : super(
    id: id,
    title: title,
    description: description,
    assignedTo: assignedTo,
    createdAt: createdAt,
    dueDate: dueDate,
    status: status,
  );

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      assignedTo: json['assignedTo'],
      createdAt: DateTime.parse(json['createdAt']),
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      status: TaskStatus.values.firstWhere(
              (e) => e.toString() == 'TaskStatus.${json['status']}',
          orElse: () => TaskStatus.todo),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "assignedTo": assignedTo,
      "createdAt": createdAt.toIso8601String(),
      "dueDate": dueDate?.toIso8601String(),
      "status": status.toString().split('.').last,
    };
  }

  Task1 copyWith({
    String? id,
    String? title,
    String? description,
    String? assignedTo,
    DateTime? createdAt,
    DateTime? dueDate,
    TaskStatus? status,
  }) {
    return Task1(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      assignedTo: assignedTo ?? this.assignedTo,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }

  static List<TaskModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TaskModel.fromJson(json)).toList();
  }
}
