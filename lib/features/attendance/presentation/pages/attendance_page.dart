import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/attendance_bloc.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AttendanceBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocConsumer<AttendanceBloc, AttendanceState>(
              listener: (context, state) {
                if (state is AttendanceSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                } else if (state is AttendanceError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is AttendanceLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.login),
                      label: const Text('Check In'),
                      onPressed: () => bloc.add(CheckInRequested()),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.logout),
                      label: const Text('Check Out'),
                      onPressed: () => bloc.add(CheckOutRequested()),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.history),
                      label: const Text('Load Attendance History'),
                      onPressed: () => bloc.add(LoadAttendanceHistory()),
                    )
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<AttendanceBloc, AttendanceState>(builder: (context, state) {
                if (state is AttendanceHistoryLoaded) {
                  final records = state.records;
                  if (records.isEmpty) return const Center(child: Text('No records'));
                  return ListView.builder(
                    itemCount: records.length,
                    itemBuilder: (context, index) {
                      final r = records[index];
                      return ListTile(
                        title: Text('${r.type} — ${r.timestamp.toLocal()}'),
                        subtitle: Text('Lat: ${r.latitude}, Lng: ${r.longitude}'),
                      );
                    },
                  );
                }
                return const Center(child: Text('Use buttons above to check in/out or load history'));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
