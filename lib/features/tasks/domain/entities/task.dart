import 'package:equatable/equatable.dart';

enum TaskStatus { todo, inProgress, done }

class Task1 extends Equatable {
  final String id;
  final String title;
  final String description;
  final String assignedTo;
  final DateTime createdAt;
  final DateTime? dueDate;
  final TaskStatus status;

  const Task1({
    required this.id,
    required this.title,
    required this.description,
    required this.assignedTo,
    required this.createdAt,
    this.dueDate,
    this.status = TaskStatus.todo,
  });

  @override
  List<Object?> get props =>
      [id, title, description, assignedTo, createdAt, dueDate, status];
}
