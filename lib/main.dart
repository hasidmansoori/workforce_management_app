import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/attendance/presentation/bloc/attendance_bloc.dart';
import 'features/tasks/presentation/bloc/task_bloc.dart';
import 'injection_container.dart' as di;
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/attendance/presentation/pages/attendance_page.dart';
import 'features/tasks/presentation/pages/tasks_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const WorkforceApp());
}

class WorkforceApp extends StatelessWidget {
  const WorkforceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provide top-level Blocs if needed
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
        BlocProvider(create: (_) => di.sl<AttendanceBloc>()),
        BlocProvider(create: (_) => di.sl<TaskBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Workforce App',
        theme: ThemeData(primarySwatch: Colors.indigo),
        initialRoute: '/attendance',
        routes: {
          '/login': (_) => LoginPage(),
          '/attendance': (_) => AttendancePage(),
          '/tasks': (_) => TasksPage(),
        },
      ),
    );
  }
}
