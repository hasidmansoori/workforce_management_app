import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../../data/models/task_model.dart';

class TasksPage extends StatelessWidget {
  TasksPage({Key? key}) : super(key: key);

  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();

  void _showCreateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Create Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Title')),
              TextField(controller: _descCtrl, decoration: const InputDecoration(labelText: 'Description')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                final newTask = TaskModel(
                  id: DateTime.now().millisecondsSinceEpoch.toString(), // temporary ID
                  title: _titleCtrl.text.trim(),
                  description: _descCtrl.text.trim(),
                  assignedTo: "user_id", // replace with current user ID
                  createdAt: DateTime.now(),
                );

                // dispatch using positional parameter
                context.read<TaskBloc>().add(CreateTask(newTask));

                _titleCtrl.clear();
                _descCtrl.clear();
                Navigator.pop(context);
              },
              child: const Text('Create'),
            )
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: Column(
        children: [
          ElevatedButton.icon(onPressed: () => bloc.add(LoadTasks()), icon: const Icon(Icons.refresh), label: const Text('Load Tasks')),
          ElevatedButton.icon(onPressed: () => _showCreateDialog(context), icon: const Icon(Icons.add), label: const Text('Create Task')),
          Expanded(
            child: BlocBuilder<TaskBloc, TaskState>(builder: (context, state) {
              if (state is TaskLoading) return const Center(child: CircularProgressIndicator());
              if (state is TaskLoaded) {
                final tasks = state.tasks;
                if (tasks.isEmpty) return const Center(child: Text('No tasks'));
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) => _TaskTile(task: tasks[index]),
                );
              }
              if (state is TaskError) return Center(child: Text('Error: \${state.message}'));
              return const Center(child: Text('Press Load Tasks to begin'));
            }),
          ),
        ],
      ),
    );
  }
}

class _TaskTile extends StatelessWidget {
  final TaskModel task;
  const _TaskTile({required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: PopupMenuButton<String>(
        onSelected: (val) {
          if (val == 'in_progress' || val == 'done' || val == 'todo') {
            // Convert string to TaskStatus enum
            final statusEnum = TaskStatus.values.firstWhere(
                  (e) => e.toString().split('.').last == val,
              orElse: () => TaskStatus.todo,
            );

            // Ensure task is a TaskModel
            final updatedTask = TaskModel(
              id: task.id,
              title: task.title,
              description: task.description,
              assignedTo: task.assignedTo,
              createdAt: task.createdAt,
              dueDate: task.dueDate,
              status: statusEnum,
            );

            context.read<TaskBloc>().add(UpdateTask(id: task.id, payload: updatedTask));
          }

        },
        itemBuilder: (_) => [
          PopupMenuItem(value: 'todo', child: Text('To-Do')),
          PopupMenuItem(value: 'in_progress', child: Text('In Progress')),
          PopupMenuItem(value: 'done', child: Text('Done')),
        ],
      ),
    );
  }
}
