import 'package:get_it/get_it.dart';
import 'package:presentation_test/core/api/dio_client.dart';
import 'package:presentation_test/core/file/file_service_impl.dart';
import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/check_presentation_status.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/delete_presentation.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/download_presentation.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/get_presentation_paths.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/uncompress_presentation.dart';
import 'package:presentation_test/features/presentation_view/screens/loading_screen/loading_screen_vm.dart';
import 'package:presentation_test/features/presentation_view/widgets/presentation_widget_vm.dart';

GetIt sl = GetIt.instance;

Future<void> serviceLocator({bool isUnitTest = false}) async {
  _service();
  _useCase();
  _vm();
}

void _service() {
  sl.registerSingleton<DioClient>(DioClient());
  sl.registerLazySingleton<FileService>(() => FileServiceImpl());
}

void _useCase() {
  // Presentation viewer
  sl.registerLazySingleton(() => GetPresentationPath(sl<FileService>()));
  sl.registerLazySingleton(
      () => DeletePresentation(sl<FileService>(), sl<GetPresentationPath>()));
  sl.registerLazySingleton(() => CheckPresentationStatus(sl<FileService>()));
  sl.registerLazySingleton(() => DownloadPresentation(sl<DioClient>()));
  sl.registerLazySingleton(() => UncompressPresentation(sl<FileService>()));
}

void _vm() {
  // Presentation viewer
  sl.registerFactory(() => LoadingScreenVm(
        deletePresentation: sl<DeletePresentation>(),
      ));
  sl.registerFactory(() => PresentationWidgetVm(
        getPresentationPath: sl<GetPresentationPath>(),
        checkPresentationStatus: sl<CheckPresentationStatus>(),
        downloadPresentation: sl<DownloadPresentation>(),
        uncompressPresentation: sl<UncompressPresentation>(),
        deletePresentation: sl<DeletePresentation>(),
      ));
}
