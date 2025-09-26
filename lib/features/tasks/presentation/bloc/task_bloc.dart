import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/task_model.dart';
import '../../data/repositories/task_repository_impl.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepositoryImpl taskRepository;
  StreamSubscription<List<TaskModel>>? _wsSub;

  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    // Load all tasks
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      try {
        final tasks = await taskRepository.getTasks();

        // Cancel previous subscription if exists
        await _wsSub?.cancel();

        // Subscribe to WebSocket stream (typed List<TaskModel>)
        _wsSub = taskRepository.getTaskStream().listen(
              (tasksFromWs) => emit(TaskLoaded(tasks: tasksFromWs)),
          onError: (error) => emit(TaskError(message: error.toString())),
        );

        // Emit initial tasks
        emit(TaskLoaded(tasks: tasks));
      } catch (e) {
        emit(TaskError(message: e.toString()));
      }
    });

    // Create a new task
    on<CreateTask>((event, emit) async {
      if (state is TaskLoaded) {
        final current = List<TaskModel>.from((state as TaskLoaded).tasks);
        try {
          final created = await taskRepository.createTask(event.payload as TaskModel);
          current.insert(0, created); // add to top
          emit(TaskLoaded(tasks: current));
        } catch (e) {
          emit(TaskError(message: e.toString()));
        }
      }
    });

    // Update an existing task
    on<UpdateTask>((event, emit) async {
      if (state is TaskLoaded) {
        final current = List<TaskModel>.from((state as TaskLoaded).tasks);
        try {
          final updated = await taskRepository.updateTask(event.id, event.payload as TaskModel);
          final idx = current.indexWhere((t) => t.id == updated.id);
          if (idx >= 0) current[idx] = updated;
          emit(TaskLoaded(tasks: current));
        } catch (e) {
          emit(TaskError(message: e.toString()));
        }
      }
    });
  }

  @override
  Future<void> close() async {
    await _wsSub?.cancel();          // cancel WebSocket subscription
    taskRepository.disposeWebSocket(); // close WS connection
    return super.close();
  }
}
