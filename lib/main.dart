import 'package:flutter/material.dart';
import 'package:presentation_test/core/api/dio_client.dart';
import 'package:presentation_test/core/file/file_service.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/loading_screen.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/loading_screen_vm.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Тестирование презентаций',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(131, 0, 81, 1),
        ),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider<LoadingScreenVm>(
        create: (context) => LoadingScreenVm(
          context,
          fileService: FileServiceImpl(),
          dioClient: DioClient(),
        ),
        child: const LoadingScreen(),
      ),
    );
  }
}
