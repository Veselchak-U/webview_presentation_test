import 'package:flutter/material.dart';
import 'package:presentation_test/core/di/dependency_injection.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/loading_screen.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/loading_screen_vm.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тестирование презентаций',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(131, 0, 81, 1),
        ),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<LoadingScreenVm>(
        create: (context) => sl<LoadingScreenVm>(),
        child: const LoadingScreen(),
      ),
    );
  }
}
