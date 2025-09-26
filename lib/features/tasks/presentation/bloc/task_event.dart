part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

/// Load all tasks
class LoadTasks extends TaskEvent {}

/// Create a new task
class CreateTask extends TaskEvent {
  final TaskModel payload;

  const CreateTask(this.payload);

  @override
  List<Object?> get props => [payload];
}

/// Update an existing task
class UpdateTask extends TaskEvent {
  final String id;
  final TaskModel payload;

  const UpdateTask({required this.id, required this.payload});

  @override
  List<Object?> get props => [id, payload];
}

/// WebSocket message received (optional if you handle WS inside Bloc directly)
class TaskSocketMessageReceived extends TaskEvent {
  final dynamic message;

  const TaskSocketMessageReceived({required this.message});

  @override
  List<Object?> get props => [message];
}
