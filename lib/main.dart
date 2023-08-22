import 'package:flutter/material.dart';
import 'package:presentation_test/core/api/dio_client.dart';
import 'package:presentation_test/core/file/file_service_impl.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/check_presentation_status.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/delete_presentation.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/download_presentation.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/get_presentation_paths.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/uncompress_presentation.dart';
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
    final fileService = FileServiceImpl();
    final dioClient = DioClient();

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
          getPresentationPath: GetPresentationPath(fileService),
          checkPresentationStatus: CheckPresentationStatus(fileService),
          downloadPresentation: DownloadPresentation(dioClient),
          uncompressPresentation: UncompressPresentation(fileService),
          deletePresentation: DeletePresentation(fileService),
        ),
        child: const LoadingScreen(),
      ),
    );
  }
}
